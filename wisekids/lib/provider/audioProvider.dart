import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';

class AudioProvider extends ChangeNotifier {
  AudioCache _audioCache = AudioCache();
  AudioPlayer _advancedPlayer = AudioPlayer();

  AudioCache _audioCacheSoundEffect = AudioCache();
  AudioPlayer _advancedPlayerSoundEffect =
      AudioPlayer(mode: PlayerMode.LOW_LATENCY);

  AudioCache _audioCacheCandyMonster = AudioCache();
  AudioPlayer _advancedPlayerCandyMonster = AudioPlayer();

  AudioCache _audioCacheCongrat = AudioCache();
  AudioPlayer _advancedPlayerCongrat = AudioPlayer();

  AudioCache _audioCacheCongrat2 = AudioCache();
  AudioPlayer _advancedPlayerCongrat2 = AudioPlayer();

  AudioCache _audioCachePlayTheme = AudioCache();
  AudioPlayer _advancedPlayTheme = AudioPlayer();

  ////////////////////////////////////////////// BG Music
  Future playBgMusic() async {
    _advancedPlayer =
        await _audioCache.loop('sound/background.mp3', volume: 0.05);
  }

  Future pauseBgMusic() async {
    await _advancedPlayer.pause();
  }

  Future resumeBgMusic() async {
    await _advancedPlayer.resume();
  }

  Future stopBgMusic() async {
    await _advancedPlayer.stop();
  }

  /////////////////////////////////////////////// Candy Monster Theme
  Future playCandyMonsterTheme() async {
    _advancedPlayerCandyMonster = await _audioCacheCandyMonster
        .loop('sound/candyMonsterTheme.mp3', volume: 0.20);
  }

  Future stopCandyMonsterTheme() async {
    await _advancedPlayerCandyMonster.stop();
    _audioCacheCandyMonster.clearCache();
  }

  /////////////////////////////////////////////// Congrat Theme
  Future playCongratTheme() async {
    _advancedPlayerCongrat =
        await _audioCacheCongrat.loop('sound/gasPedal.mp3', volume: 0.20);
  }

  Future stopCongratTheme() async {
    await _advancedPlayerCongrat.stop();
    _audioCacheCongrat.clearCache();
  }

  /////////////////////////////////////////////// Congrat Theme2
  Future playCongratTheme2() async {
    _advancedPlayerCongrat2 =
        await _audioCacheCongrat2.loop('sound/cubicZ.mp3', volume: 0.20);
  }

  Future stopCongratTheme2() async {
    await _advancedPlayerCongrat2.stop();
    _audioCacheCongrat2.clearCache();
  }

  /////////////////////////////////////////////// Play Theme
  Future playPlayTheme() async {
    _advancedPlayTheme =
        await _audioCachePlayTheme.loop('sound/cuckoo.mp3', volume: 0.1);
  }

  Future stopPlayTheme() async {
    await _advancedPlayTheme.stop();
    _audioCachePlayTheme.clearCache();
  }

  /////////////////////////////////////////////// Sound Effect

  Future playSoundEffect(String soundEffect, double volume) async {
    if (soundEffect == "select") {
      volume = 0.35;
    } else if (soundEffect == "click2") {
      volume = 0.35;
    } else if (soundEffect == "achievement1") {
      volume = 0.1;
    } else if (soundEffect == "confirmationDownward") {
      volume = 0.4;
    } else if (soundEffect == "switch") {
      volume = 0.1;
    } else if (soundEffect == "btnClick") {
      volume = 0.4;
    }
    await _audioCacheSoundEffect.play('sound/' + soundEffect + '.mp3',
        mode: PlayerMode.LOW_LATENCY, volume: volume);
    _audioCacheSoundEffect.clearCache();
  }
}
