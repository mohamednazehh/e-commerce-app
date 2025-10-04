/*import '../../product_by_category_screen/product_by_category_screen.dart';
import '../../../utility/animation/open_container_wrapper.dart';
import 'package:flutter/material.dart';
import '../../../models/category.dart';

class CategorySelector extends StatelessWidget {
  final List<Category> categories;


  const CategorySelector({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 6,vertical: 1),
            child: OpenContainerWrapper(
              nextScreen: ProductByCategoryScreen(selectedCategory: categories[index]),
              child: Container(
                width: 80,
                height: 80,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: category.isSelected ? const Color(0xFFf16b26) : const Color(0xFFE5E6E8),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Image.network(
                        category.image ?? '',
                        width: 90,
                        height: 90,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.error, color: Colors.grey);
                        },
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      category.name ?? '',
                      style: TextStyle(
                        color: category.isSelected ? Colors.white : Colors.black,
                        fontSize: 12,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}*/
import '../../product_by_category_screen/product_by_category_screen.dart';
import '../../../utility/animation/open_container_wrapper.dart';
import 'package:flutter/material.dart';
import '../../../models/category.dart';

class CategorySelector extends StatelessWidget {
  final List<Category> categories;


  const CategorySelector({
    super.key,
    required this.categories,
  });

  // 🛠️ Helper function to apply the localhost fix (moved here from CustomNetworkImage)
  String _getFixedImageUrl(String imageUrl) {
    // Check if the URL contains 'localhost' and replace it with the Android emulator's IP (10.0.2.2).
    if (imageUrl.contains('localhost')) {
      // Use replaceFirst to ensure only the first instance (the host) is replaced.
      return imageUrl.replaceFirst('localhost', '10.0.2.2');
    }
    return imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];

          // Get the original URL, ensuring it's not null/empty
          final originalImageUrl = category.image ?? '';

          // Apply the fix directly to the URL before using Image.network
          final fixedImageUrl = _getFixedImageUrl(originalImageUrl);

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 6,vertical: 1),
            child: OpenContainerWrapper(
              nextScreen: ProductByCategoryScreen(selectedCategory: categories[index]),
              child: Container(
                width: 80,
                height: 80,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: category.isSelected ? const Color(0xFFf16b26) : const Color(0xFFE5E6E8),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      // Using Image.network directly as requested
                      child: Image.network(
                        fixedImageUrl, // 💡 Use the fixed URL here
                        width: 90,
                        height: 90,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          // Retaining the original errorBuilder logic
                          return const Icon(Icons.error, color: Colors.grey);
                        },
                        // You might want to add a loadingBuilder here too, similar to CustomNetworkImage
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      category.name ?? '',
                      style: TextStyle(
                        color: category.isSelected ? Colors.white : Colors.black,
                        fontSize: 12,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
