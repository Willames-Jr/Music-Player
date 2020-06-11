import 'package:floor/floor.dart';

@Entity(tableName: "Playlists")
class PlaylistEntity {
  @PrimaryKey(autoGenerate: true)
  int index;

  String name;

  String image;

  PlaylistEntity({this.index, this.name, this.image});
}
