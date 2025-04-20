import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/product_controller.dart';

class CategoryChips extends StatefulWidget {
  final ProductController controller;

  const CategoryChips({super.key, required this.controller});

  @override
  State<CategoryChips> createState() => _CategoryChipsState();
}

class _CategoryChipsState extends State<CategoryChips> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (widget.controller.categories.isEmpty) return const SizedBox.shrink();

      return SizedBox(
        height: 50,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          itemCount: widget.controller.categories.length,
          itemBuilder: (context, index) {
            final category = widget.controller.categories[index];
            final isSelected =
                widget.controller.selectedCategory.value == category.slug;

            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChoiceChip(
                label: Text(
                  category.name,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                selected: isSelected,
                onSelected: (_) {
                  if (!isSelected) {
                    widget.controller.filterByCategory(category.slug);
                    setState(() {});
                  }
                },
                selectedColor: Colors.deepPurple,
                checkmarkColor: Colors.white,
                backgroundColor: Colors.grey[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: isSelected ? 4 : 0,
                pressElevation: 2,
              ),
            );
          },
        ),
      );
    });
  }
}
