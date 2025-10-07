import 'package:flutter/material.dart';
import 'package:finishedapp/voice/voice.dart'; // Assuming voice.dart contains VoiceText and its key/logic
// import 'package:finishedapp/voice/voice.dart' ; // Original import path (keep this if it's correct)

// Data model for the detected details (No change)
class DetectedDetails {
  final String name;
  final String fatherName;
  final int age;
  final String address;

  DetectedDetails({
    required this.name,
    required this.fatherName,
    required this.age,
    required this.address,
  });
}

class UserDetailsApp extends StatelessWidget {
  const UserDetailsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Voice to Text Details',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: 'Inter',
        scaffoldBackgroundColor: const Color(0xFFF0F2F5),
        useMaterial3: true,
      ),
      // 💡 FIX 1: Remove 'home' property and use 'initialRoute' and 'routes'.
      initialRoute: '/voice_input', // Set your initial screen (where the mic button is)
      routes: {
        // Assuming your voice input screen is here
        '/voice_input': (context) => const VoiceText(), 

        // 💡 FIX 2: This route is the target of the navigation.
        '/show_detail/': (context) {
          // Access the arguments that were passed during the pushReplacementNamed call
          final arguments = ModalRoute.of(context)?.settings.arguments;
          
          // Ensure the argument is a String, otherwise provide a default value
          final String transcript = arguments is String
              ? arguments
              : 'Error: No transcript or argument provided.'; 
          
          // Pass the received transcript to the UserDetailsScreen
          return UserDetailsScreen(initialTranscript: transcript);
        },
      },
      // If you still need a main function that runs this app:
      // main: () => runApp(const UserDetailsApp()), 
    );
  }
}

class UserDetailsScreen extends StatelessWidget {
  // 💡 FIX 3: Accept the transcript via the constructor
  final String initialTranscript;
  
  // The name 'transcribedText' was misleading as it was a field initializer, now it's a constructor argument.
  // The line 'final String transcribedText = WhatText();' caused an error.
  UserDetailsScreen({super.key, required this.initialTranscript});

  // Sample data (can be extracted/parsed from the transcript later)
  final DetectedDetails detected = DetectedDetails(
    name: "Pawan",
    fatherName: "Narsingh",
    age: 21,
    address: "Haryana",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _buildTitleSection(),
                const SizedBox(height: 32),

                // 💡 FIX 4: Use the constructor argument here
                _buildTranscribedTextBox(initialTranscript), 
                const SizedBox(height: 16),

                _buildDetectedDetailsBox(detected),
                const SizedBox(height: 48),

                _buildOkButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- Helper Widgets remain the same ---

  Widget _buildTitleSection() {
    // ... (implementation remains the same) ...
    const Color purpleColor = Color(0xFF7B1FA2);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Icon(Icons.mic, color: purpleColor, size: 24),
        SizedBox(width: 8),
        Text('Voice to Text', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)),
        Text(' — User Details', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400, color: Colors.black54)),
      ],
    );
  }

  Widget _buildTranscribedTextBox(String text) {
    const Color blueBorder = Color(0xFF42A5F5);

    return Container(
      constraints: const BoxConstraints(maxWidth: 500),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: blueBorder, width: 1.5),
        boxShadow: [
          BoxShadow(color: blueBorder, spreadRadius: 1, blurRadius: 3, offset: const Offset(0, 2)),
        ],
      ),
      child: Text(
        'You said: $text', // Use the provided text
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 16, height: 1.5, color: Colors.black87),
      ),
    );
  }

  Widget _buildDetectedDetailsBox(DetectedDetails details) {
    // ... (implementation remains the same) ...
    const Color greenBackground = Color(0xFFE8F5E9);
    const Color greenBorder = Color(0xFF66BB6A);
    const Color highlightColor = Color(0xFFFB8C00);

    Widget _buildDetailRow(String label, String value) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: RichText(
          text: TextSpan(
            style: const TextStyle(fontSize: 16, color: Colors.black, height: 1.4),
            children: <TextSpan>[
              TextSpan(text: '$label: ', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
              TextSpan(text: value, style: const TextStyle(color: highlightColor)),
            ],
          ),
        ),
      );
    }

    return Container(
      constraints: const BoxConstraints(maxWidth: 500),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: greenBackground,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: greenBorder, width: 1.5),
        boxShadow: [
          BoxShadow(color: greenBorder.withOpacity(0.1), spreadRadius: 1, blurRadius: 3, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Detected Details:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF388E3C))),
          const Divider(color: greenBorder, height: 16),
          _buildDetailRow('Name', details.name),
          _buildDetailRow('Father Name', details.fatherName),
          _buildDetailRow('Age', details.age.toString()),
          _buildDetailRow('Address', details.address),
        ],
      ),
    );
  }

  Widget _buildOkButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('OK button pressed!')));
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.deepPurple,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        elevation: 8,
      ),
      child: const Text('OK', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }
}