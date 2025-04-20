import 'package:get/get.dart';
import '../models/product_model.dart';
import '../models/category_model.dart';
import '../services/product_service.dart';

class ProductController extends GetxController {
  var products = <Product>[].obs;
  var isLoading = true.obs;
  var categories = <Category>[].obs;
  var selectedCategory = ''.obs;

  @override
  void onInit() {
    fetchProducts();
    fetchCategories();
    super.onInit();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      final result = await ProductService.fetchProducts();
      products.assignAll(result);
    } catch (e) {
      print('Error fetching products: $e');
    } finally {
      isLoading(false);
    }
  }

  void searchProducts(String query) async {
    try {
      isLoading(true);
      final result = await ProductService.searchProducts(query);
      products.assignAll(result);
    } catch (e) {
      print('Error searching products: $e');
    } finally {
      isLoading(false);
    }
  }

  void fetchCategories() async {
    try {
      final result = await ProductService.fetchCategories();
      categories.assignAll(result);
    } catch (e) {
      print('Error loading categories: $e');
    }
  }

  void filterByCategory(String categorySlug) async {
    try {
      isLoading(true);
      selectedCategory.value = categorySlug;
      final result = await ProductService.fetchByCategory(categorySlug);
      products.assignAll(result);
    } catch (e) {
      print('Error filtering by category: $e');
    } finally {
      isLoading(false);
    }
  }
}
