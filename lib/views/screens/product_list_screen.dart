import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../controllers/product_controller.dart';
import '../widgets/category_chips.dart';
import '../widgets/product_card.dart';

class ProductListScreen extends StatefulWidget {
  ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final controller = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    print('Building ProductListScreen...');
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '🛍️ Products',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          CategoryChips(controller: controller),
          Expanded(child: _buildProductGrid()),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search by title",
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
        onChanged: (value) {
          if (value.isEmpty) {
            controller.fetchProducts();
          } else {
            controller.searchProducts(value);
          }
        },
      ),
    );
  }

  Widget _buildProductGrid() {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: SpinKitFadingCircle(
            color: Colors.deepPurple,
            size: 50.0,
          ),
        );
      }

      if (controller.products.isEmpty) {
        return const Center(child: Text("No products found."));
      }

      return GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: controller.products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.75,
        ),
        itemBuilder: (context, index) {
          final product = controller.products[index];
          return ProductCard(product: product);
        },
      );
    });
  }
}
