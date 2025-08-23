import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:e_commerce_app/widgets/custom_button.dart';
import 'package:e_commerce_app/widgets/custom_gap.dart';
import 'package:e_commerce_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _productName = TextEditingController();
  final TextEditingController _productDescription = TextEditingController();
  final TextEditingController _productPrice = TextEditingController();

  File? _image;
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;

  @override
  void dispose() {
    _productName.dispose();
    _productDescription.dispose();
    _productPrice.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile == null) return;

    final compressedFile = await _compressImage(File(pickedFile.path));
    if (compressedFile != null) {
      setState(() => _image = compressedFile);
    } else {
      _showSnack('Image compression failed!');
    }
  }

  Future<File?> _compressImage(File file) async {
    final compressedBytes = await FlutterImageCompress.compressWithFile(
      file.path,
      minWidth: 600,
      minHeight: 600,
      quality: 60,
      format: CompressFormat.jpeg,
    );

    if (compressedBytes == null) return null;
    if (compressedBytes.length > 500 * 1024) {
      _showSnack('Image too large even after compression (max 500KB).');
      return null;
    }

    final tempFile = File('${file.path}_compressed.jpg');
    await tempFile.writeAsBytes(compressedBytes);
    return tempFile;
  }

  Future<String?> _imageToBase64(File? image) async {
    if (image == null) return null;
    final bytes = await image.readAsBytes();
    return base64Encode(bytes);
  }

  Future<void> _addProduct() async {
    if (_productName.text.isEmpty ||
        _productPrice.text.isEmpty ||
        _image == null) {
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
      final imageBase64 = await _imageToBase64(_image);
      final productData = {
        'name': _productName.text.trim(),
        'price': price,
        'image': imageBase64,
        'description': _productDescription.text.trim(),
        'createdAt': FieldValue.serverTimestamp(),
      };

      await FirebaseFirestore.instance.collection('products').add(productData);

      if (mounted) {
        _showSnack('Product added successfully!', isError: false);
      }

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
    setState(() => _image = null);
  }

  void _showSnack(String message, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Product')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            CustomTextfield(
              controller: _productName,
              labelText: 'Product Name',
            ),
            const CustomGap(h: 15),
            CustomTextfield(
              controller: _productPrice,
              labelText: 'Price',
              keyboardType: TextInputType.number,
            ),
            const CustomGap(h: 15),
            CustomTextfield(
              controller: _productDescription,
              labelText: 'Description',
            ),
            const CustomGap(h: 20),

            DottedBorder(
              color: Colors.brown,
              padding: const EdgeInsets.all(20),
              radius: const Radius.circular(20),
              borderType: BorderType.RRect,
              child: Column(
                children: [
                  _image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            _image!,
                            height: 220,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const Text(
                          'No image selected',
                          style: TextStyle(color: Colors.grey),
                        ),
                  const CustomGap(h: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButton(
                        onPressed: () => _pickImage(ImageSource.gallery),
                        text: 'Gallery',
                        width: 140,
                      ),
                      CustomButton(
                        onPressed: () => _pickImage(ImageSource.camera),
                        text: 'Camera',
                        width: 140,
                      ),
                    ],
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
