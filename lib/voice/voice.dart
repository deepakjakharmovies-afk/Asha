import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:highlight_text/highlight_text.dart';
import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';

class VoiceText extends StatefulWidget {
  const VoiceText({super.key});

  @override
  State<VoiceText> createState() => _VoiceTextState();
}

class _VoiceTextState extends State<VoiceText> {
  stt.SpeechToText speechToText = stt.SpeechToText();
  bool isListning = false;
  String text = "Press the button to start speaking";

final Map<String, HighlightedWord> toHighlight = {
  'name': HighlightedWord(
    textStyle: TextStyle(
      color: Colors.amber,
      fontWeight: FontWeight.bold,
    ),
  ),
};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    speechToText=stt.SpeechToText();

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: const Text("Voice to Text"),
        centerTitle: true,

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: isListning,
        glowColor: Colors.blue, 
        glowRadiusFactor: 0.6,
        // duration: Duration(microseconds: 2000),
        
        // repeat:false,
        repeat: true,
        child: FloatingActionButton(
          onPressed: lition,
          child: Icon(isListning ? Icons.mic : Icons.mic_none),
        ),
      ),
      body: SingleChildScrollView( 
        reverse: true,// Added a body to the Scaffold
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: TextHighlight(
            text: text, 
            words: toHighlight,
            textStyle: TextStyle(
              fontSize: 31,
              color: Colors.lightGreen,
            ),
          )
        ),
      ),
    ); // Added closing parenthesis for Scaffold
}

  void lition() async{
    if(!isListning){
      bool connected = await speechToText.initialize(
        
        onStatus: (status) => print("onstatus($status)"),
        onError: (errorNotification) => print('onerror ($errorNotification)'),


      );
      if (connected){
        setState(() {
          isListning = true;
        });
        speechToText.listen(
          onResult: (result) => setState(() {
            text = result.recognizedWords;
            
          }),
        );
      }

    }else{
      setState(() {
        isListning = false;
        speechToText.stop();
      });
    }
  }
}
