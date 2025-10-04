/*import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final double scale;

  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.scale = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(

      imageUrl,
      fit: fit,
      scale: scale,
      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                : null,  // Progress indicator.
          ),
        );
      },
      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
        return const Icon(Icons.error, color: Colors.red);
      },
    );
  }
}*/



import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final double scale;

  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.scale = 1.0,
  });

  // 🛠️ Helper function to fix the localhost URL issue
  String _getFixedImageUrl() {
    String fixedUrl = imageUrl;

    // Check if the URL contains 'localhost' and replace it with the Android emulator's IP (10.0.2.2).
    // This resolves the "Connection refused" error when running on an emulator.
    if (fixedUrl.contains('localhost')) {
      // Use replaceFirst to ensure only the first instance (the host) is replaced.
      fixedUrl = fixedUrl.replaceFirst('localhost', '10.0.2.2');
    }

    // Note: If you are using a physical device, replace '10.0.2.2' with your computer's actual local IP (e.g., '192.168.1.10').

    return fixedUrl;
  }

  @override
  Widget build(BuildContext context) {
    // 🔗 Use the corrected URL for network fetching
    String finalUrl = _getFixedImageUrl();

    return Image.network(
      finalUrl, // The fixed URL is used here
      fit: fit,
      scale: scale,
      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                : null,  // Progress indicator while loading.
          ),
        );
      },
      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
        // Fallback icon displayed on image loading error
        return const Icon(Icons.error, color: Colors.red);
      },
    );
  }
}


