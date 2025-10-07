import 'dart:async';
// NOTE: Change the import alias to just 'speech_to_text' for simplicity
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:highlight_text/highlight_text.dart'; 
import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:finishedapp/voice/api_call.dart'; 


class VoiceText extends StatefulWidget {
  const VoiceText({super.key});

  @override
  State<VoiceText> createState() => _VoiceTextState();
}

class _VoiceTextState extends State<VoiceText> {
  // --- 1. STATE VARIABLES ---
  // Note: Since we removed the 'as stt' alias, we use SpeechToText directly.
  SpeechToText speechToText = SpeechToText();
  bool isListning = false;
  String text = "Press the button to start speaking";
  String fullTranscript = '';


  List<HighlightSpan> currentHighlights = []; 
  
  @override
  void initState() {
    super.initState();
  }
  // --- 2. STT LISTENER (Corrected Signature) ---
  // FIX: Use the class name directly without the 'stt.' alias.
  void sttListener(SpeechRecognitionResult result) { 
    // 1. Update the UI and full transcript
    setState(() {
      text = result.recognizedWords; 
      fullTranscript = result.recognizedWords; 
    });

    // 2. Trigger the API call with the recognized string.
    _processTextChunk(result.recognizedWords); 

    // 3. Handle the end of speech
    if (result.finalResult) { 
      setState(() {
        isListning = false;
      });
    }
  }

  // --- 3. API PROCESSOR ---
  void _processTextChunk(String text) async {
    final List<DetectedEntity> newEntities = await extractChunk(text);

    if (newEntities.isEmpty) {
      return;
    }

    setState(() {
      currentHighlights.clear(); 
      for (var entity in newEntities) {
        // Find the index in the full string
        int startIndex = fullTranscript.indexOf(entity.text);
        
        if (startIndex != -1) {
          final newSpan = HighlightSpan(
            entity.text,
            entity.label,
            startIndex,
            startIndex + entity.text.length,
          );
          currentHighlights.add(newSpan);
        }
      }
      currentHighlights.sort((a, b) => a.startIndex.compareTo(b.startIndex));
    });
  }
  // --- 4. LISTEN/STOP METHOD ---
  void lition() async {
    if (!isListning) {
      bool connected = await speechToText.initialize(
        onStatus: (status) => print("onstatus($status) and(${currentHighlights.length})"),
        onError: (errorNotification) => print('onerror ($errorNotification)'),
      );
      if (connected) {
        setState(() {
          isListning = true;
        });
        // Pass the listener function directly
        speechToText.listen(onResult: sttListener); 
      }
    } else {
      setState(() {
        isListning = false;
      });
      speechToText.stop();
    }
  }
  
  // --- 5. BUILD METHOD ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Voice to Text"),
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AvatarGlow(
            animate: isListning,
            glowColor: Colors.blue, 
            glowRadiusFactor: 0.6,
            repeat: true,
            child: FloatingActionButton(
              onPressed: lition,
              child: Icon(isListning ? Icons.mic : Icons.mic_none),
            ),
          ),
          const SizedBox(height: 20,),
          FloatingActionButton(onPressed:(){
            Navigator.of(context).pushReplacementNamed('/show_detail/',arguments: fullTranscript,);
            print("Submit action triggered($fullTranscript)" );
          },child: const Text("Submit"),)
        ],
      ),
      
      body: SingleChildScrollView( 
        reverse: true,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: SelectableText.rich( 
            TextSpan(
              children: buildHighlightedTextSpans(
                fullTranscript, 
                currentHighlights
              ),
              style: const TextStyle( 
                fontSize: 35,
                color: Colors.lightGreen,
              ),
            ),
          )
        ),
      ),
    ); 
  }
}