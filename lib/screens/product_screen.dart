import 'dart:convert';
import 'package:e_commerce_app/widgets/custom_button.dart';
import 'package:e_commerce_app/widgets/custom_gap.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  final String name;
  final double price;
  final String description;
  final String image;

  const ProductScreen({
    super.key,
    required this.name,
    required this.price,
    required this.description,
    required this.image,
  });

  Widget buildImage(String? imageBase64) {
    if (imageBase64 == null || imageBase64.isEmpty) {
      return const Icon(
        Icons.image_not_supported,
        size: 120,
        color: Colors.grey,
      );
    }
    try {
      return Image.memory(
        base64Decode(imageBase64),
        height: 200,
        width: 200,
        fit: BoxFit.cover,
        gaplessPlayback: true,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.broken_image, size: 120, color: Colors.grey);
        },
      );
    } catch (e) {
      return const Icon(Icons.broken_image, size: 120, color: Colors.grey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: buildImage(image)),
            const SizedBox(height: 20),

            Text(
              name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const CustomGap(h: 10),
            Text(
              description,
              style: const TextStyle(fontSize: 18, color: Colors.black87),
            ),
            const CustomGap(h: 20),
            Text(
              "\$${price.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 25, color: Colors.green),
            ),

            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Added to Cart ")),
                  );
                },
                text: "Add to Cart",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
