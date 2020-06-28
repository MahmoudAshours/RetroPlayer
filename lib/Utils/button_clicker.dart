import 'package:flutter_sound/flutter_sound_player.dart';

// ignore: top_level_function_literal_block
var buttonClickSound = () async {
  FlutterSoundPlayer player = await FlutterSoundPlayer().initialize();

  return await player.startPlayer('assets/audio/buttonPress.mp3');
};
