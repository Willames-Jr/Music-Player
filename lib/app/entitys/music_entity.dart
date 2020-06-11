import 'package:floor/floor.dart';

@Entity(tableName: 'Musics')
class MusicEntity {
  @PrimaryKey(autoGenerate: true)
  int index;

  String path;

  int indexOfPlaylist;

  MusicEntity({this.index, this.path, this.indexOfPlaylist});
}
