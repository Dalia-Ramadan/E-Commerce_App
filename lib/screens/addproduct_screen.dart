import 'dart:convert';
import 'package:flutter/foundation.dart'; // kIsWeb
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/widgets/custom_button.dart';
import 'package:e_commerce_app/widgets/custom_gap.dart';
import 'package:e_commerce_app/widgets/custom_textfield.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});
  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _productName = TextEditingController();
  final _productDescription = TextEditingController();
  final _productPrice = TextEditingController();
  final _picker = ImagePicker();

  Uint8List? _imageBytes; // ✅ بدل File - بيشتغل على Web وAndroid
  bool _isLoading = false;

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
      maxHeight: 600,
      imageQuality: 60,
    );
    if (picked == null) return;
    final bytes = await picked.readAsBytes();
    if (bytes.length > 500 * 1024) {
      _showSnack('Image too large (max 500KB)');
      return;
    }
    setState(() => _imageBytes = bytes);
  }

  Future<void> _addProduct() async {
    if (_productName.text.isEmpty ||
        _productPrice.text.isEmpty ||
        _imageBytes == null) {
      _showSnack('Please fill all fields and select an image');
      return;
    }
    final price = double.tryParse(_productPrice.text);
    if (price == null || price <= 0) {
      _showSnack('Please enter a valid price');
      return;
    }
    setState(() => _isLoading = true);
    try {
      final imageBase64 = base64Encode(_imageBytes!);
      await FirebaseFirestore.instance.collection('products').add({
        'name': _productName.text.trim(),
        'price': price,
        'image': imageBase64,
        'description': _productDescription.text.trim(),
        'createdAt': FieldValue.serverTimestamp(),
      });
      if (mounted) _showSnack('Product added successfully!', isError: false);
      _resetForm();
    } catch (e) {
      _showSnack('Error: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _resetForm() {
    _productName.clear();
    _productPrice.clear();
    _productDescription.clear();
    setState(() => _imageBytes = null);
  }

  void _showSnack(String msg, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: isError ? Colors.red : Colors.green,
    ));
  }

  @override
  void dispose() {
    _productName.dispose();
    _productDescription.dispose();
    _productPrice.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Product')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            CustomTextfield(controller: _productName, labelText: 'Product Name'),
            const CustomGap(h: 15),
            CustomTextfield(
              controller: _productPrice,
              labelText: 'Price',
              keyboardType: TextInputType.number,
            ),
            const CustomGap(h: 15),
            CustomTextfield(controller: _productDescription, labelText: 'Description'),
            const CustomGap(h: 20),

            // ✅ بدل DottedBorder
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.brown, width: 1.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  if (_imageBytes != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.memory(_imageBytes!, height: 220, fit: BoxFit.cover),
                    )
                  else
                    const Text('No image selected', style: TextStyle(color: Colors.grey)),
                  const CustomGap(h: 20),
                  CustomButton(
                    onPressed: _pickImage,
                    text: 'Pick Image',
                    width: 180,
                  ),
                ],
              ),
            ),
            const CustomGap(h: 40),

            _isLoading
                ? const CircularProgressIndicator()
                : CustomButton(
                    onPressed: _addProduct,
                    text: 'Add Product',
                    width: 180,
                    backgroundColor: Colors.brown,
                  ),
          ],
        ),
      ),
    );
  }
}