import 'package:mobx/mobx.dart';
import 'package:music_player/app/shared/audio_manage/audio_manager.dart';

part 'app_controller.g.dart';

class AppController = _AppBase with _$AppController;

abstract class _AppBase with Store {
  final AudioManager audioManager;

  _AppBase(this.audioManager);
}
