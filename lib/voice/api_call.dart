import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart'; // Required for Color and TextSpan
// import 'package:finishedapp/voice/voice.dart';
// --- Data Models ---

// Model for the entity detected by your Python API
class DetectedEntity {
  final String text; // The word/phrase detected (e.g., "Deepak Kumar")
  final String label; // The label (e.g., "NAME")

  DetectedEntity(this.text, this.label);
}

// Model to hold the complete highlight information for UI rendering
class HighlightSpan {
  final String text; 
  final String label; 
  final int startIndex; 
  final int endIndex; 

  HighlightSpan(this.text, this.label, this.startIndex, this.endIndex);
}

// Assumes fullTranscript and _currentHighlights are available in the scope (e.g., State class)
// Assumes HighlightSpan is defined as: class HighlightSpan {final String text; final String label; final int startIndex; final int endIndex;}

List<TextSpan> buildHighlightedTextSpans(
  String fullTranscript, 
  List<HighlightSpan> currentHighlights
) {
  if (fullTranscript.isEmpty) {
    return [const TextSpan(text: '')];
  }
  
  List<TextSpan> spans = [];
  int currentPosition = 0;

  // Ensure highlights are sorted by their start index
  currentHighlights.sort((a, b) => a.startIndex.compareTo(b.startIndex));

  for (var highlight in currentHighlights) {
    // 1. Add unhighlighted text (from currentPosition to highlight start)
    if (highlight.startIndex > currentPosition) {
      spans.add(TextSpan(
        text: fullTranscript.substring(currentPosition, highlight.startIndex),
        style: const TextStyle(color: Colors.black),
      ));
    }

    // 2. Add highlighted text
    spans.add(TextSpan(
      text: highlight.text,
      style: TextStyle(
        color: getLabelColor(highlight.label),
        fontWeight: FontWeight.bold,
        // color: Colors.black, // Ensures text is readable
      ),
    ));

    // 3. Update position to the end of the current highlight
    currentPosition = highlight.endIndex;
  }

  // 4. Add any remaining unhighlighted text
  if (currentPosition < fullTranscript.length) {
    spans.add(TextSpan(
      text: fullTranscript.substring(currentPosition),
      style: const TextStyle(color: Colors.black),
    ));
  }

  return spans;
}
Color getLabelColor(String label) {
  switch (label.toUpperCase()) {
    case "NAME":
      return Colors.blue;
    case "FATHER_NAME":
      return Colors.green;
    case "AGE":
      return Colors.orange;
    case "ADDRESS":
      return Colors.purple;
    default:
      return Colors.transparent; // No highlight for unknown labels
  }
}
// --- API Utility Function ---

// IMPORTANT: Replace with the correct host IP. 10.0.2.2 is for Android Emulator.
const String apiHost = '127.0.0.1:8000'; 

Future<List<DetectedEntity>> extractChunk(String chunk) async {
  final url = Uri.http(apiHost, 'stream_info');

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'current_chunk': chunk}), 
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      
      // The API returns a list of lists: [["text", "LABEL"], ["text", "LABEL"], ...]
      List<dynamic> entityData = jsonResponse['entities'] ?? [];
      
      // FIX IS HERE: Use .map and then .toList() to return the required List<DetectedEntity>
      return entityData.map((e) {
          // e is the inner list/array like ["Deepak", "NAME"]
          // We return the single DetectedEntity object for each map iteration.
          return DetectedEntity(e[0].toString(), e[1].toString());
      }).toList(); // <--- CRITICAL: .toList() converts the iterable to the required List

    } else {
      print('Stream API Error: ${response.statusCode}');
      return []; // Return an empty list on API failure
    }
  } catch (e) {
    print('Stream Network Error: $e');
    return []; // Return an empty list on network error
  }
}