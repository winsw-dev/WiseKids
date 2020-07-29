import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

enum TtsState { playing, stopped }

class TTSProvider extends ChangeNotifier {
  ///////////////////////////////// TTS variable
  FlutterTts flutterTts;
  dynamic languages;
  String language = "en-US";
  double volume = 0.5;
  double pitch = 1.0;
  double rate = 0.5;

  ////////////////////////////////// TTS stage
  TtsState ttsState = TtsState.stopped;
  get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;

  ////////////////////////////////////// TTS Init
  initTts() {
    flutterTts = FlutterTts();

    _getLanguages();

    flutterTts.setStartHandler(() {
      print("playing");
      ttsState = TtsState.playing;
    });

    flutterTts.setCompletionHandler(() {
      print("Complete");
      ttsState = TtsState.stopped;
    });

    flutterTts.setErrorHandler((msg) {
      print("error: $msg");
      ttsState = TtsState.stopped;
    });
  }
  ///////////////////////////////////////// TTS functions

  Future _getLanguages() async {
    languages = await flutterTts.getVoices;
    print("pritty print $languages");
  }

  Future speak(String wordToSpeech) async {
    await flutterTts.setLanguage(language);
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    if (wordToSpeech != null) {
      if (wordToSpeech.isNotEmpty) {
        var result = await flutterTts.speak(wordToSpeech);
        if (result == 1) {
          return ttsState = TtsState.playing;
        }
      }
    }
  }

  Future stop() async {
    var result = await flutterTts.stop();
    if (result == 1) {
      return ttsState = TtsState.stopped;
    }
  }

  void disposeTTS() {
    flutterTts.stop();
  }
}
