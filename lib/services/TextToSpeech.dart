import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';
import '';

FlutterTts flutterTts = FlutterTts();
Future speak(String text) async{
  await flutterTts.setLanguage('ar');
  await flutterTts.setPitch(1);
  await flutterTts.speak(text);
}




