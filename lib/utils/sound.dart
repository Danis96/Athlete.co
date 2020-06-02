import 'package:audioplayers/audio_cache.dart';

class SoundPlayer {

    static AudioCache player = new AudioCache();
    static const alarmAudioPath = 'audio/bel.mp3';

    playSound() {
       player.play(alarmAudioPath);
       print('Sound played');
    }
}