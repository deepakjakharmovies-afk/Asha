import 'package:flutter/material.dart';

// --- Placeholder Constants (Colors and Strings) ---
// Define placeholder colors based on the XML
const Color bg = Color(0xFFF5F5F5); // light grey background
const Color white = Color(0xFFFFFFFF);
const Color pink50 = Color(0xFFFCE4EC); // Very light pink
const Color pink700 = Colors.blueAccent; // Darker pink for buttons
const Color grey = Color(0xFF9E9E9E); // Medium grey
const String developerText = "Developed by @team"; // Placeholder for @string/developer

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ConstraintLayout with overlapping elements is best handled by a Stack in Flutter.
    return Scaffold(
      backgroundColor: bg,
      body: Stack(
        children: <Widget>[
          // 1. Header with Gradient (toptxt)
          _buildHeader(),

          // 2. Scrollable Login Form Card (scrollView2)
          // Positioning is done relative to the top of the Stack (using margin/padding)
          // and using a fractional offset (negative translationY in XML).
          Positioned(
            top: 230 - 70, // toptxt height - translationY
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildLoginForm(context),
          ),

          // 3. Developer Footer (Text near the bottom)
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 12.0),
              child: Text(
                developerText,
                textAlign: TextAlign.center,
                style: TextStyle(
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

  // --- Header Widget (toptxt) ---
  Widget _buildHeader() {
    return Container(
      height: 230, // android:layout_height="230dp"
      width: double.infinity,
      // Placeholder for @drawable/bg_gradient
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [pink700, Color(0xFFEC407A)], // Pink gradient placeholder
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center, // android:gravity="center"
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Welcome Back!",
              style: TextStyle(
                color: white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "Login to Continue",
              style: TextStyle(
                color: pink50,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Scrollable Login Form Card (scrollView2 content) ---
  Widget _buildLoginForm(BuildContext context) {
    return SingleChildScrollView(
      // Replicates ScrollView's role
      // The overall card structure is defined by the first LinearLayout in the ScrollView
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          margin: const EdgeInsets.all(8), // outer margin
          // Placeholder for @drawable/search_input_bg (assumed to be white, rounded)
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              // 1. Beneficiary ID Input
              _buildInputField(
                hintText: "Beneficiary ID",
                icon: Icons.badge, // ic_badge placeholder
                inputType: TextInputType.number,
                isPassword: false,
              ),

              const SizedBox(height: 12),

              // 2. Password Input
              _buildInputField(
                hintText: "Password",
                icon: Icons.lock, // ic_lock placeholder
                inputType: TextInputType.text,
                isPassword: true,
              ),

              const SizedBox(height: 12),

              // 3. Language Select (MaterialAutoCompleteTextView)
              _buildLanguageDropdown(),

              const SizedBox(height: 28),

              // Divider (View)
              const Divider(height: 2, thickness: 2, color: grey),

              const SizedBox(height: 28),

              // 4. Login as ASHA Worker Button
              _buildLoginButton(
                text: "Login as ASHA Worker",
                icon: Icons.person_add_alt_1, // ic_add_person placeholder
                onPressed: () {
                  Navigator.pushReplacementNamed(context,'/home/');
                },
              ),

              const SizedBox(height: 18),

              // 5. Login as PHC Button
              _buildLoginButton(
                text: "Login as PHC",
                icon: Icons.local_hospital, // ic_local_hospital placeholder
                onPressed: () {},
              ),
              // Add padding at the bottom for the SingleChildScrollView to not be cut off
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  // --- Reusable Input Field Widget ---
  Widget _buildInputField({
    required String hintText,
    required IconData icon,
    required TextInputType inputType,
    required bool isPassword,
  }) {
    // This replicates the TextInputLayout with filled style and custom radius.
    return TextFormField(
      obscureText: isPassword,
      keyboardType: inputType,
      decoration: InputDecoration(
        hintText: hintText,
        // Replicates app:boxStrokeWidth="1.4dp"
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(width: 1.4, color: grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(width: 1.4, color: grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          // Use a primary color for focused state
          borderSide: const BorderSide(width: 1.4, color: pink700),
        ),
        // drawableStart
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 4.0),
          child: Icon(icon, color: grey),
        ),
        // app:endIconMode="password_toggle"
        suffixIcon: isPassword
            ? IconButton(
                icon: const Icon(Icons.visibility, color: grey),
                onPressed: () {
                  // Implement visibility toggle logic here
                },
              )
            : null,
        contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
      ),
    );
  }

  // --- Language Dropdown Widget ---
  Widget _buildLanguageDropdown() {
    // This replicates the MaterialAutoCompleteTextView inside a TextInputLayout
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        hintText: "Select Language",
        // Rounded corners
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(width: 1.4, color: grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(width: 1.4, color: grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(width: 1.4, color: pink700),
        ),
        // drawableStart
        prefixIcon: const Padding(
          padding: EdgeInsets.only(left: 8.0, right: 4.0),
          child: Icon(Icons.language, color: grey), // ic_language placeholder
        ),
        // drawableEnd is handled by the default DropdownButton icon
        contentPadding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
      ),
      value: null, // No initial value selected
      items: const [
        DropdownMenuItem(value: 'English', child: Text('English')),
        DropdownMenuItem(value: 'Hindi', child: Text('Hindi')),
      ],
      onChanged: (String? newValue) {
        // Handle language selection logic here
      },
    );
  }

  // --- Reusable Button Widget ---
  Widget _buildLoginButton({
    required String text,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    // Replicates MaterialButton with background and custom styling
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: pink700, // Placeholder for @drawable/bg_button tint
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 0,
        padding: EdgeInsets.zero,
      ),
      icon: Icon(icon, color: white),
      label: Text(
        text,
        style: const TextStyle(color: white, fontSize: 18),
      ),
    );
  }
}