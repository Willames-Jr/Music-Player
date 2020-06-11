import 'package:floor/floor.dart';
import 'package:music_player/app/entitys/playlist_entity.dart';

@dao
abstract class PlaylistDao {
  @Query('SELECT * FROM Playlists')
  Future<List<PlaylistEntity>> findAllPlaylists();

  @Query('SELECT * FROM Playlists WHERE index = :index')
  Stream<PlaylistEntity> findPlaylistByIndex(int index);

  @Query('DELETE FROM Playlists WHERE name = :name')
  Future<void> deletePlaylistWhereName(String name);

  @delete
  Future<int> deletePlaylist(PlaylistEntity playlist);

  @insert
  Future<int> insertPlaylist(PlaylistEntity playlist);
}
