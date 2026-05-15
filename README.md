# Trendify Store - E-Commerce Flutter App

## 📖 Overview
Trendify Store is a modern e-commerce application built with **Flutter** and **Firebase**. It allows users to browse and search products, manage their cart, upload new products, and customize their profile — all with a clean and intuitive UI.

---

## ✨ Features

### 🔐 Authentication
- Sign up with name, email, and password
- Sign in with existing credentials via Firebase Authentication
- Secure sign out from the profile screen

### 🛍️ Product Management
- Browse all products in a responsive grid view
- Real-time product syncing via Firebase Firestore
- Add new products with name, price, description, and image
- Product images compressed and stored as Base64 in Firestore (max 500KB)

### 🔍 Search
- Search products by name in real-time
- Results update instantly as you type

### 🛒 Cart
- Add products to cart from the product details screen
- Increment or decrement item quantity
- Remove items automatically when quantity reaches zero
- Checkout clears the cart with a confirmation message
- Continue shopping navigates back to the home screen

### 👤 Profile
- View display name, email, and member since date
- **Upload and update profile picture** from gallery (stored in Firestore)
- Profile picture persists across sessions
- Sign out securely

### 🎨 UI / UX
- Splash screen with 3-second delay before onboarding
- Welcome screen with Sign Up and Log In options
- Custom reusable widgets: buttons, text fields, product cards, bottom navbar, gap
- Consistent bottom navigation bar across all main screens

---

## 🛠️ Technologies Used

| Technology | Purpose |
|---|---|
| Flutter | Cross-platform UI framework |
| Firebase Authentication | User sign-up & sign-in |
| Firebase Firestore | Real-time database for products & user profiles |
| Image Picker | Select images from gallery |
| Dart | Programming language |

---

## 📂 Project Structure

```
Trendify Store/
├── assets/
│   └── images/
│       ├── splash.png
│       └── welcome.png
├── lib/
│   ├── firebase_options.dart
│   ├── main.dart
│   ├── screens/
│   │   ├── splash_screen.dart
│   │   ├── welcome_screen.dart
│   │   ├── signin_screen.dart
│   │   ├── signup_screen.dart
│   │   ├── home_screen.dart
│   │   ├── search_screen.dart
│   │   ├── product_screen.dart
│   │   ├── cart_screen.dart
│   │   ├── profile_screen.dart
│   │   └── addproduct_screen.dart
│   └── widgets/
│       ├── cart_manager.dart
│       ├── custom_bottom_navbar.dart
│       ├── custom_button.dart
│       ├── custom_gap.dart
│       ├── custom_productcard.dart
│       └── custom_textfield.dart
├── pubspec.yaml
└── README.md
```

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.0+
- Dart
- Firebase account
- Android Studio or VS Code
- Physical device or emulator

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/smartshop.git
   cd smartshop
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Set up Firebase**
   - Create a project at [Firebase Console](https://console.firebase.google.com/)
   - Enable **Authentication** (Email/Password)
   - Enable **Firestore Database**
   - Run FlutterFire CLI to generate `firebase_options.dart`:
     ```bash
     flutterfire configure
     ```

4. **Set Firestore Rules**
   ```js
   rules_version = '2';
   service cloud.firestore {
     match /databases/{database}/documents {
       match /users/{userId} {
         allow read, write: if request.auth != null
                            && request.auth.uid == userId;
       }
       match /products/{productId} {
         allow read, write: if request.auth != null;
       }
     }
   }
   ```

5. **Add assets** — place images in `assets/images/` and update `pubspec.yaml`:
   ```yaml
   flutter:
     assets:
       - assets/images/splash.png
       - assets/images/welcome.png
   ```

6. **Run the app**
   ```bash
   flutter run
   ```

---

## 📱 App Flow

```
Splash Screen (3s)
      ↓
Welcome Screen
   ↙       ↘
Sign Up   Sign In
      ↓
Home Screen  ──→  Search Screen
     ↓                  ↓
Product Screen      Product Screen
     ↓
  Cart Screen
     ↓
Profile Screen
```

---

## 👩‍💻 Developed by Dalia Ramadan
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Dalia%20Ramadan-blue?style=flat&logo=linkedin)](https://www.linkedin.com/in/dalia-ramadan-ahmed-435912252/)

---

> Happy Shopping with **SmartShop**! 🛍️