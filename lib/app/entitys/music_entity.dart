import 'package:floor/floor.dart';

//Define atributes for "Musics" in the database
//Each atribute is a column in database

@Entity(tableName: 'Musics')
class MusicEntity {
  @PrimaryKey(autoGenerate: true)
  int index;

  String path;

  int indexOfPlaylist;

  MusicEntity({this.index, this.path, this.indexOfPlaylist});
}
