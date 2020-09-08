import 'package:floor/floor.dart';

//Define atributes for "Playlist" in the database
//Each atribute is a column in database

@Entity(tableName: "Playlists")
class PlaylistEntity {
  @PrimaryKey(autoGenerate: true)
  int index;

  String name;

  String image;

  PlaylistEntity({this.index, this.name, this.image});
}
