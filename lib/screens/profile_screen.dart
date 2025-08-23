import 'package:e_commerce_app/screens/welcome_screen.dart';
import 'package:e_commerce_app/widgets/custom_gap.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => _firebaseAuth.currentUser;
  Future<void> signOut(BuildContext context) async {
    await _firebaseAuth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => WelcomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.account_circle, size: 30),
            CustomGap(w: 5),
            Text(
              'Profile',
              style: TextStyle(
                letterSpacing: 3,
                fontSize: 30,
                fontWeight: FontWeight.normal,
              ),
            ),
            CustomGap(w: 60),
          ],
        ),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                currentUser!.displayName ?? 'No Name',
                style: TextStyle(fontSize: 25),
              ),
              CustomGap(h: 10),
              Text(
                currentUser?.email ?? "No email",
                style: TextStyle(fontSize: 20, color: Colors.black38),
              ),
              CustomGap(h: 30),
              IconButton(
                onPressed: () async => await signOut(context),
                icon: Icon(
                  Icons.logout_rounded,
                  size: 40,
                  color: Colors.redAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
