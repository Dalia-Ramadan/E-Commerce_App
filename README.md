# SmartShop - E-Commerce Flutter App

## 📖 Overview
SmartShop is a modern e-commerce mobile application built with **Flutter** and **Firebase**. It allows users to browse products, add new products, and manage their profiles with a clean and intuitive user interface. The app supports user authentication, product management, and image uploads with compression for efficient storage.

## ✨ Features
- **User Authentication**: Secure sign-up and sign-in using Firebase Authentication.
- **Product Management**: Add, view, and sort products by name or price.
- **Image Upload**: Upload product images from gallery or camera with compression to optimize storage.
- **Responsive UI**: Clean and user-friendly interface with custom widgets for text fields, buttons, and product cards.
- **Real-time Data**: Uses Firebase Firestore for real-time product data syncing.
- **Profile Management**: View user details and sign out securely.
- **Splash & Welcome Screens**: Engaging onboarding experience with a splash screen and welcome page.

## 🛠️ Technologies Used
- **Flutter**: For cross-platform mobile app development.
- **Firebase Authentication**: For secure user sign-up and sign-in.
- **Firebase Firestore**: For real-time database and product storage.
- **Image Picker**: For selecting images from gallery or camera.
- **Flutter Image Compress**: For compressing images before upload.
- **Dotted Border**: For stylish UI elements.
- **Dart**: Programming language for Flutter.

## 📂 Project Structure
```
smartshop/
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

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (version 3.0 or higher)
- Dart
- Firebase account
- Android Studio / VS Code
- A physical device or emulator for testing

### Installation
1. **Clone the Repository**:
   ```bash
   git clone https://github.com/yourusername/smartshop.git
   cd smartshop
   ```

2. **Install Dependencies**:
   ```bash
   flutter pub get
   ```

3. **Set Up Firebase**:
   - Create a Firebase project at [Firebase Console](https://console.firebase.google.com/).
   - Add an Android/iOS app to your Firebase project.
   - Download the `google-services.json` (for Android) or `GoogleService-Info.plist` (for iOS) and place it in the appropriate directory.
   - Enable Firebase Authentication (Email/Password) and Firestore in the Firebase Console.

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

## 📱 Usage
1. **Splash Screen**: The app starts with a 3-second splash screen displaying the app logo.
2. **Welcome Screen**: Users can choose to sign up or sign in.
3. **Sign Up / Sign In**: Register with a name, email, and password, or log in with existing credentials.
4. **Home Screen**: Browse products in a grid view, sort by name or price, and access the profile or add product screens via the drawer or floating action button.
5. **Add Product**: Upload a product with a name, price, description, and image (compressed to max 500KB).
6. **Product Screen**: View detailed product information and add items to the cart (mock functionality).
7. **Profile Screen**: View user details and sign out.

## 🖼️ Screenshots
*(Add screenshots of the app here, e.g., splash screen, home screen, product screen, etc.)*


## Developed by: Dalia Ramadan 
- LinkedIn: [Dalia Ramadan Ahmed](https://www.linkedin.com/in/dalia-ramadan-ahmed-435912252/)


---

Happy Shopping with **SmartShop**! 🛍️