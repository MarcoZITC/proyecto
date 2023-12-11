import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BlurredBackgroundWeb extends StatelessWidget {
  const BlurredBackgroundWeb({
    super.key,
    required this.tag,
    required this.backgroundUrl,    
  });

  final Object tag;
  final String backgroundUrl;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: CachedNetworkImage(
        imageUrl: backgroundUrl,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.black.withOpacity(0.3)),
          ),
        ),
        placeholder: (context, url) => const CircularProgressIndicator(), // Opcional
        errorWidget: (context, url, error) => const Icon(Icons.error), // Opcional
      ),
    );
  }
}