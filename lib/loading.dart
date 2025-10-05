import 'package:finishedapp/login.dart';
import 'package:flutter/material.dart';
// Import the dashboard file to navigate to the HomePage
import 'dashboard.dart';

// Define placeholder colors and string constants based on the XML
const Color bg = Colors.blue; // Placeholder for @color/bg
const Color white = Color(0xFFFFFFFF); // Placeholder for @color/white
const Color grey = Color(0xFF9E9E9E); // Placeholder for @color/grey
const String developerText = "Developed by @Team"; // Placeholder for @string/developer

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    // Start the timer to navigate after a delay
    _navigateToHome();
  }

  void _navigateToHome() async {
    // Wait for 3 seconds (or any desired duration for the splash screen)
    await Future.delayed(const Duration(seconds: 1));

    // Navigate to the HomePage using a custom PageRouteBuilder for a transition
    if (mounted) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500), // Duration of the transition
          pageBuilder: (context, animation, secondaryAnimation) => const LoginScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Use a FadeTransition for a smooth fade-in effect
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold provides the basic structure and background color
    return Scaffold(
      backgroundColor: bg,
      body: Stack(
        // Stack is used to place widgets relative to each other (similar to ConstraintLayout)
        children: <Widget>[
          // App Logo (Centered with specific constraints)
          // The combination of Align/Center and padding/SizedBox is used to replicate
          // the centering and size constraints.
          const Align(
            // Replicates app:layout_constraintVertical_bias="0.392"
            alignment: Alignment(0.0, -0.2), 
            child: AppLogoWidget(),
          ),

          // Developer Text (Fixed at the bottom with a margin)
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12.0), // layout_marginBottom="12dp"
              child: Text(
                developerText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: grey,
                  fontSize: 10.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget for the App Logo section to keep the main build method clean
class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180, // android:layout_width="180dp"
      height: 180, // android:layout_height="180dp"
      // Replicates android:background="@drawable/circle_bg" and android:backgroundTint="@color/white"
      decoration: const BoxDecoration(
        color: white,
        shape: BoxShape.circle,
      ),
      padding: const EdgeInsets.all(16.0), // android:padding="16dp"
      child: Image.asset(
        // IMPORTANT: Replace 'assets/asha_app.png' with the actual path to your image
        './lib/assets/asha_app.jpeg', 
        fit: BoxFit.contain,
        // Assuming asha_app is a raster image, not an icon that needs tinting
      ),
    );
  }
}