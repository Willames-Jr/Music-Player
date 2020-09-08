import 'package:floor/floor.dart';
import 'package:music_player/app/entitys/music_entity.dart';

// Contains all the methods that make a query in the local database in the "Music" table

@dao
abstract class MusicDao {
  @Query('SELECT * FROM Musics')
  Future<List<MusicEntity>> findAllMusics();

  @Query('SELECT * FROM Musics WHERE index = :index')
  Stream<MusicEntity> findMusicByIndex(int index);

  @Query('SELECT * FROM Musics WHERE indexOfPlaylist = :indexOfPlaylist')
  Future<List<MusicEntity>> findMusicsWhere(int indexOfPlaylist);

  @Query(
      'DELETE FROM Musics WHERE indexOfPlaylist = :indexOfPlaylist AND path = :path')
  Future<void> deleteMusicWhere(int indexOfPlaylist, String path);

  @Query('DELETE FROM Musics WHERE indexOfPlaylist = :indexOfPlaylist')
  Future<MusicEntity> deleteAllMusicsOfPlaylist(int indexOfPlaylist);

  @delete
  Future<void> deleteMusic(MusicEntity music);

  @insert
  Future<void> insertMusic(MusicEntity music);
}
