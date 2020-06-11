import 'package:mobx/mobx.dart';
import 'package:music_player/app/entitys/music_entity.dart';

class Playlistmodel {
  int index;
  String name;
  String image;
  ObservableList<MusicEntity> musics;

  Playlistmodel({this.index, this.image, this.name, this.musics});
}
