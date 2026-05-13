import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/screens/product_screen.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  List<QueryDocumentSnapshot> _allProducts = [];
  List<QueryDocumentSnapshot> _results = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final snap = await FirebaseFirestore.instance
        .collection('products')
        .orderBy('createdAt', descending: true)
        .get();
    setState(() {
      _allProducts = snap.docs;
      _results = snap.docs;
      _loading = false;
    });
  }

  void _onSearch(String query) {
    setState(() {
      _results = query.isEmpty
          ? _allProducts
          : _allProducts
              .where((doc) => (doc['name'] as String)
                  .toLowerCase()
                  .contains(query.toLowerCase()))
              .toList();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextField(
          controller: _controller,
          autofocus: true,
          onChanged: _onSearch,
          decoration: InputDecoration(
            hintText: 'Search products...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.grey[100],
            prefixIcon: const Icon(Icons.search),
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _controller.clear();
                _onSearch('');
              },
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 0),
          ),
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _results.isEmpty
              ? const Center(
                  child: Text('No products found',
                      style: TextStyle(color: Colors.grey, fontSize: 16)))
              : GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.72,
                  ),
                  itemCount: _results.length,
                  itemBuilder: (context, index) {
                    final p = _results[index];
                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductScreen(
                            productId: p.id,
                            name: p['name'],
                            price: (p['price'] as num).toDouble(),
                            description: p['description'] ?? '',
                            image: p['image'] ?? '',
                          ),
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(16)),
                              child: _buildImage(p['image']),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(p['name'],
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${(p['price'] as num).toStringAsFixed(2)}\$',
                                    style: const TextStyle(
                                        color: Color(0xFF2E7D32),
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }

  Widget _buildImage(String? base64) {
    if (base64 == null || base64.isEmpty) {
      return Container(
          height: 160,
          color: Colors.grey[200],
          child: const Icon(Icons.image, color: Colors.grey, size: 50));
    }
    try {
      return Image.memory(base64Decode(base64),
          height: 160, width: double.infinity, fit: BoxFit.cover);
    } catch (_) {
      return Container(
          height: 160,
          color: Colors.grey[200],
          child: const Icon(Icons.broken_image, color: Colors.grey));
    }
  }
}