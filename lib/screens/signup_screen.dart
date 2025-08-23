import 'package:e_commerce_app/screens/home_screen.dart';
import 'package:e_commerce_app/widgets/custom_button.dart';
import 'package:e_commerce_app/widgets/custom_gap.dart';
import 'package:e_commerce_app/widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _name = TextEditingController();

  final TextEditingController _email = TextEditingController();

  final TextEditingController _password = TextEditingController();

  final TextEditingController _confirmPassword = TextEditingController();

  final _keyForm = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;

  void signUp() async {
    if (!_keyForm.currentState!.validate()) return;
    try {
      UserCredential user = await _auth.createUserWithEmailAndPassword(
        email: _email.text.trim(),
        password: _password.text,
      );
    await user.user!.updateDisplayName(_name.text.trim());
    await user.user!.reload();
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('User Registered Successfully!')));

      _name.clear();
      _email.clear();
      _password.clear();
      _confirmPassword.clear();

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        // ignore: use_build_context_synchronously
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to register: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Register')),
        body: Form(
          key: _keyForm,
          autovalidateMode: AutovalidateMode.disabled,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      CustomTextfield(
                        controller: _name,
                        labelText: 'Name',
                        prefixIcon: Icons.person,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please fill the name field';
                          } else {
                            return null;
                          }
                        },
                      ),
                      CustomGap(h: 20),
                      CustomTextfield(
                        controller: _email,
                        labelText: 'Email',
                        prefixIcon: Icons.email,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please fill the email field';
                          }
                          if (!value.contains('@') || !value.contains('.com')) {
                            return 'please enter a valid email';
                          } else {
                            return null;
                          }
                        },
                      ),
                      CustomGap(h: 20),
                      CustomTextfield(
                        obscureText: true,
                        controller: _password,
                        labelText: 'Password',
                        prefixIcon: Icons.lock,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please fill the password field';
                          }
                          if (value.length < 6) {
                            return 'password must be more than 6 characters';
                          } else {
                            return null;
                          }
                        },
                      ),
                      CustomGap(h: 20),
                      CustomTextfield(
                        obscureText: true,
                        controller: _confirmPassword,
                        labelText: 'Confirm Password',
                        prefixIcon: Icons.lock,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please fill the confirm password field';
                          }
                          if (value != _password.text) {
                            return 'Passwords do not match';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  ),
                ),
                CustomGap(h: 20),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: CustomButton(onPressed: signUp, text: 'Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
