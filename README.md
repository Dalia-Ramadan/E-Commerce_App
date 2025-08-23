# SmartShop - E-Commerce Flutter App 🛍️

## 📖 Overview

SmartShop is a modern, cross-platform e-commerce mobile application built with **Flutter** and **Firebase**. It provides a seamless shopping experience, allowing users to browse products, add new products, and manage their profiles through an intuitive and responsive user interface. The app supports secure user authentication, efficient image uploads with compression, and real-time data synchronization.

---

## ✨ Features

- **User Authentication**: Secure sign-up and sign-in using Firebase Authentication (Email/Password).
- **Product Management**: Add, view, and sort products by name or price.
- **Image Upload**: Upload product images from gallery or camera with compression (max 500KB).
- **Responsive UI**: Clean, user-friendly interface with custom widgets for text fields, buttons, and product cards.
- **Real-time Data**: Powered by Firebase Firestore for real-time product data syncing.
- **Profile Management**: View user details and sign out securely.
- **Splash & Welcome Screens**: Engaging onboarding with a splash screen and welcome page.

---

## 🛠️ Technologies Used

- **Flutter**: Cross-platform mobile app development framework.
- **Firebase Authentication**: Secure user authentication.
- **Firebase Firestore**: Real-time database for product storage.
- **Image Picker**: Select images from gallery or camera.
- **Flutter Image Compress**: Optimize image storage with compression.
- **Dotted Border**: Stylish UI elements for enhanced design.
- **Dart**: Programming language for Flutter.

---

## 📂 Project Structure

```
├── assets/
│   ├── images/
│   │   ├── splash.png
│   │   ├── welcome.png
├── lib/
│   ├── screens/
│   │   ├── addproduct_screen.dart
│   │   ├── home_screen.dart
│   │   ├── product_screen.dart
│   │   ├── profile_screen.dart
│   │   ├── signin_screen.dart
│   │   ├── signup_screen.dart
│   │   ├── splash_screen.dart
│   │   ├── welcome_screen.dart
│   ├── widgets/
│   │   ├── custom_button.dart
│   │   ├── custom_gap.dart
│   │   ├── custom_productcard.dart
│   │   ├── custom_textfield.dart
├── pubspec.yaml
├── README.md
```

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (version 3.0 or higher)
- Dart
- Firebase account
- Android Studio or VS Code
- Physical device or emulator for testing

### Installation

1. **Clone the Repository**:

   ```bash
   git clone https://github.com/Dalia-Ramadan/E-Commerce_App.git
   cd smartshop
   ```

2. **Install Dependencies**:

   ```bash
   flutter pub get
   ```

3. **Set Up Firebase**:

   - Create a Firebase project at Firebase Console.
   - Add an Android/iOS app to your Firebase project.
   - Download the `google-services.json` (Android) or `GoogleService-Info.plist` (iOS) and place it in the appropriate directory.
   - Enable **Firebase Authentication** (Email/Password) and **Firestore** in the Firebase Console.

4. **Add Assets**:

   - Place `splash.png` and `welcome.png` in the `assets/images/` directory.
   - Update `pubspec.yaml` to include assets:

     ```yaml
     flutter:
       assets:
         - assets/images/splash.png
         - assets/images/welcome.png
     ```

5. **Run the App**:

   ```bash
   flutter run
   ```

---

## 📱 Usage

1. **Splash Screen**: Displays the app logo for 3 seconds on startup.
2. **Welcome Screen**: Allows users to navigate to sign-up or sign-in.
3. **Sign Up / Sign In**: Register with name, email, and password, or log in with existing credentials.
4. **Home Screen**: Browse products in a grid view, sort by name or price, and access profile or add product screens via the drawer or floating action button.
5. **Add Product**: Upload products with name, price, description, and compressed image.
6. **Product Screen**: View detailed product information and add items to the cart (mock functionality).
7. **Profile Screen**: View user details and sign out securely.

---

## 👩‍💻 Developed By

**Dalia Ramadan**

- LinkedIn: Dalia Ramadan Ahmed

---

Happy Shopping with **SmartShop**! 🛍️

