import 'dart:convert';
import 'package:flutter/material.dart';

class CustomProductCard extends StatelessWidget {
  final String name;
  final double price;
  final String? imageBase64;
  final VoidCallback? onTap;

  const CustomProductCard({
    super.key,
    required this.name,
    required this.price,
    this.imageBase64,
    this.onTap,
  });

  Widget buildCardImage(String? base64Image) {
    if (base64Image == null || base64Image.isEmpty) {
      return Container(
        height: 160,
        color: const Color(0xFFF5F5F5),
        child: const Center(
          child: Icon(Icons.image, size: 60, color: Colors.grey),
        ),
      );
    }
    try {
      return Image.memory(
        base64Decode(base64Image),
        fit: BoxFit.cover,
        height: 160,
        width: double.infinity,
        gaplessPlayback: true,
        errorBuilder: (context, error, stackTrace) => Container(
          height: 160,
          color: const Color(0xFFF5F5F5),
          child: const Center(
            child: Icon(Icons.broken_image, size: 60, color: Colors.grey),
          ),
        ),
      );
    } catch (e) {
      return Container(
        height: 160,
        color: const Color(0xFFF5F5F5),
        child: const Center(
          child: Icon(Icons.broken_image, size: 60, color: Colors.grey),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: buildCardImage(imageBase64),
            ),
            // Info
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${price.toStringAsFixed(2)}\$',
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color(0xFF2E7D32),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}