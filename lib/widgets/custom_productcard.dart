import 'dart:convert';
import 'package:e_commerce_app/widgets/custom_button.dart';
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
      return const Icon(Icons.image, size: 80, color: Colors.grey);
    }
    try {
      return Image.memory(
        base64Decode(base64Image),
        fit: BoxFit.contain,
        height: 120,
        width: double.infinity,
        gaplessPlayback: true,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.broken_image, size: 80, color: Colors.grey);
        },
      );
    } catch (e) {
      return const Icon(Icons.broken_image, size: 80, color: Colors.grey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: buildCardImage(imageBase64),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "\$${price.toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 16, color: Colors.green),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0,right: 5.0),
              child: CustomButton(onPressed: onTap ?? () {}, text: 'add to card',),
            )
          ],
        ),
      ),
    );
  }
}
