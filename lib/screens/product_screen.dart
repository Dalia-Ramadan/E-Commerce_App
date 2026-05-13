import 'dart:convert';
import 'package:e_commerce_app/screens/cart_screen.dart';
import 'package:e_commerce_app/screens/profile_screen.dart';
import 'package:e_commerce_app/widgets/cart_manager.dart';
import 'package:e_commerce_app/widgets/custom_bottom_navbar.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  final String productId;
  final String name;
  final double price;
  final String description;
  final String image;

  const ProductScreen({
    super.key,
    required this.productId,
    required this.name,
    required this.price,
    required this.description,
    required this.image,
  });

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int _selectedColorIndex = 0;

  final List<Color> _colors = [
    Colors.blue,
    Colors.purple,
    const Color(0xFF4A0E4E),
    Colors.red,
  ];

  Widget buildImage(String? imageBase64) {
    if (imageBase64 == null || imageBase64.isEmpty) {
      return Container(
        height: 280,
        color: Colors.grey[200],
        child: const Center(
          child: Icon(Icons.image_not_supported, size: 80, color: Colors.grey),
        ),
      );
    }
    try {
      return Image.memory(
        base64Decode(imageBase64),
        height: 280,
        width: double.infinity,
        fit: BoxFit.cover,
        gaplessPlayback: true,
        errorBuilder: (_, __, ___) => Container(
          height: 280,
          color: Colors.grey[200],
          child: const Center(
            child: Icon(Icons.broken_image, size: 80, color: Colors.grey),
          ),
        ),
      );
    } catch (e) {
      return Container(
        height: 280,
        color: Colors.grey[200],
        child: const Center(
          child: Icon(Icons.broken_image, size: 80, color: Colors.grey),
        ),
      );
    }
  }

  void _addToCart() {
    CartManager().addItem(
      productId: widget.productId,
      name: widget.name,
      price: widget.price,
      imageBase64: widget.image,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Added to Cart ✓'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Full-width image (no border radius on top)
                buildImage(widget.image),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name and price row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.name,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '"${widget.description.isNotEmpty ? widget.description.split(' ').take(4).join(' ') : 'Product description'}"',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                    fontStyle: FontStyle.italic,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '${widget.price.toStringAsFixed(0)}\$',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2E7D32),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Color options
                      Row(
                        children: List.generate(
                          _colors.length,
                          (index) => GestureDetector(
                            onTap: () => setState(() => _selectedColorIndex = index),
                            child: Container(
                              margin: const EdgeInsets.only(right: 12),
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: _colors[index],
                                shape: BoxShape.circle,
                                border: _selectedColorIndex == index
                                    ? Border.all(color: Colors.black, width: 2.5)
                                    : null,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Details section
                      const Text(
                        'Details',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.description.isNotEmpty
                            ? widget.description
                            : 'No description available.',
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.redAccent,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Floating add to cart button
          Positioned(
            bottom: 80,
            right: 20,
            child: GestureDetector(
              onTap: _addToCart,
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.pink[50],
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Icon(Icons.shopping_cart, color: Colors.black, size: 26),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.add, color: Colors.white, size: 10),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 2) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen()));
          } else if (index == 3) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileScreen()));
          }
        },
      ),
    );
  }
}