import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:mobx/mobx.dart';
import 'package:music_player/app/db/app_database.dart';
import 'package:music_player/app/entitys/music_entity.dart';
import 'package:music_player/app/entitys/playlist_entity.dart';
import 'package:music_player/app/shared/models/audio_model.dart';
import 'package:music_player/app/shared/models/playlist_model.dart';
import 'package:music_player/app/shared/paths_manage/paths_manager.dart';
part 'audio_manager.g.dart';

class AudioManager = _AudioManagerBase with _$AudioManager;

abstract class _AudioManagerBase with Store {
  final PathsManager _pathsManager;

  final DataBase _db;

  @observable
  ObservableList<Playlistmodel> playlists = ObservableList<Playlistmodel>();

  @observable
  var assetsAudioPlayer = AssetsAudioPlayer();

  var liste;

  @observable
  PlayingAudio atualMusic = PlayingAudio(
      audio: Audio.file("", metas: Metas(artist: "Artist", title: "Music")));

  @observable
  ObservableFuture<List<Files>> musicList;

  _AudioManagerBase(this._db, this._pathsManager) {
    musicList = _pathsManager.initializeList().asObservable();
    _initPlaylists();
    liste = assetsAudioPlayer.playlistAudioFinished.listen(
      (Playing playing) {
        int index = playing.index + 1;
        atualMusic =
            PlayingAudio(audio: assetsAudioPlayer.playlist.audios[index]);
      },
    );
  }

  @action
  createNewPlaylist({PlaylistEntity playlist, MusicEntity music}) async {
    int index = await _db.playlistDao.insertPlaylist(playlist);
    music.indexOfPlaylist = index;
    await _db.musicDao.insertMusic(music);
    ObservableList<MusicEntity> list = ObservableList<MusicEntity>();
    list.add(music);
    playlists.add(
      Playlistmodel(
          name: playlist.name,
          image: playlist.image,
          index: index,
          musics: list),
    );
  }

  @action
  addMusicOnPlaylist({MusicEntity music, int index}) async {
    await _db.musicDao.insertMusic(music);
    playlists[index].musics.add(music);
  }

  @action
  deletePlaylist({PlaylistEntity playlist}) async {
    playlists.forEach(
      (element) {
        if (element.name == playlist.name) {
          playlist.index = element.index;
        }
      },
    );

    playlists.removeWhere((element) => element.index == playlist.index);

    await _db.playlistDao.deletePlaylistWhereName(playlist.name);
    await _db.musicDao.deleteAllMusicsOfPlaylist(playlist.index);
  }

  @action
  deleteMusicFromPlaylist({int indexOfPlaylist, String path}) async {
    int index = playlists[indexOfPlaylist].index;
    await _db.musicDao.deleteMusicWhere(index, path);
    playlists[indexOfPlaylist]
        .musics
        .removeWhere((element) => element.path == path);
  }

  @action
  _initPlaylists() async {
    var dbPlaylists = await _db.playlistDao.findAllPlaylists();
    for (PlaylistEntity playlist in dbPlaylists) {
      playlists.add(
        Playlistmodel(
          index: playlist.index,
          name: playlist.name,
          image: playlist.image,
          musics: ObservableList.of(
              await _db.musicDao.findMusicsWhere(playlist.index)),
        ),
      );
    }
  }

  List<Audio> getMusicsOfPlaylist(int index) {
    var atualPlaylist = playlists[index];
    List<Audio> musics = [];

    for (MusicEntity music in atualPlaylist.musics) {
      var actual =
          musicList.value.firstWhere((element) => element.path == music.path);
      musics.add(
        Audio.file(
          music.path,
          metas: Metas(
            artist: actual.artist,
            album: actual.album,
            title: actual.displayName,
          ),
        ),
      );
    }

    return musics;
  }

  @action
  playPlaylist(int index, {bool shuffle, int startIndex}) async {
    var atualPlaylist = playlists[index];
    List<Audio> musics = [];

    for (MusicEntity music in atualPlaylist.musics) {
      var actual =
          musicList.value.firstWhere((element) => element.path == music.path);
      musics.add(
        Audio.file(
          music.path,
          metas: Metas(
            artist: actual.artist,
            album: actual.album,
            title: actual.displayName,
          ),
        ),
      );
    }
    if (shuffle) {
      musics.shuffle();
    }

    await assetsAudioPlayer.open(
      Playlist(audios: musics, startIndex: startIndex),
      showNotification: true,
      notificationSettings: NotificationSettings(
        stopEnabled: true,
        customStopAction: (player) => stopMusic(player),
        customPlayPauseAction: (player) => playOrPauseMusic(),
        customPrevAction: (player) {
          previousMusic(player);
        },
        customNextAction: (player) {
          nextMusic(player);
        },
      ),
    );
    atualMusic = assetsAudioPlayer.current.value.audio;
  }

  @action
  playMusic(Files _file, {bool shuffle}) async {
    List<Audio> pathsList = [];
    for (int c = 0; c < musicList.value.length; c++) {
      pathsList.add(Audio.file(
        musicList.value[c].path,
        metas: new Metas(
          title: musicList.value[c].displayName,
          album: musicList.value[c].album,
          artist: musicList.value[c].artist == "<unknown>"
              ? "Artista Desconhecido"
              : musicList.value[c].displayName,
        ),
      ));
    }
    if (shuffle) {
      pathsList.shuffle();
    }
    await assetsAudioPlayer.open(
      Playlist(audios: pathsList, startIndex: musicList.value.indexOf(_file)),
      showNotification: true,
      notificationSettings: NotificationSettings(
        stopEnabled: true,
        customStopAction: (player) => stopMusic(player),
        customPlayPauseAction: (player) => playOrPauseMusic(),
        customPrevAction: (player) {
          previousMusic(player);
        },
        customNextAction: (player) {
          nextMusic(player);
        },
      ),
    );
    atualMusic = assetsAudioPlayer.current.value.audio;
  }

  @action
  playMusicOnPlaylist(int index) async {
    List<Audio> atualPlaylist = assetsAudioPlayer.playlist.audios;

    await assetsAudioPlayer.open(
      Playlist(audios: atualPlaylist, startIndex: index),
      showNotification: true,
      notificationSettings: NotificationSettings(
        stopEnabled: true,
        customStopAction: (player) => stopMusic(player),
        customPlayPauseAction: (player) => playOrPauseMusic(),
        customPrevAction: (player) {
          previousMusic(player);
        },
        customNextAction: (player) {
          nextMusic(player);
        },
      ),
    );

    atualMusic = assetsAudioPlayer.current.value.audio;
  }

  @action
  addAsNextMusic(Audio audio) {
    int indexOfAtualMusic =
        assetsAudioPlayer.current.value.playlist.currentIndex;
    assetsAudioPlayer.playlist.insert(indexOfAtualMusic + 1, audio);
  }

  @action
  addAtTheEndOfQueue(Audio audio) {
    assetsAudioPlayer.playlist.add(audio);
  }

  @action
  modifyPosition(int newIndex, int oldIndex) async {
    final indexOfAtualMusic =
        assetsAudioPlayer.current.value.playlist.currentIndex;
    final atualPosition = assetsAudioPlayer.currentPosition.value;
    final music = assetsAudioPlayer.playlist.removeAtIndex(oldIndex);
    assetsAudioPlayer.playlist.insert(newIndex, music);
    if (oldIndex == assetsAudioPlayer.current.value.playlist.currentIndex) {
      await stopMusic(assetsAudioPlayer);
      await assetsAudioPlayer.playlistPlayAtIndex(newIndex);
      await assetsAudioPlayer.seek(atualPosition);
    } else if (newIndex ==
        assetsAudioPlayer.current.value.playlist.currentIndex) {
      await stopMusic(assetsAudioPlayer);
      await assetsAudioPlayer.playlistPlayAtIndex(
          newIndex > oldIndex ? indexOfAtualMusic - 1 : indexOfAtualMusic + 1);
      await assetsAudioPlayer.seek(atualPosition);
    }
    atualMusic = assetsAudioPlayer.current.value.audio;
  }

  @action
  nextMusic(AssetsAudioPlayer player) async {
    await player.next();
    atualMusic = assetsAudioPlayer.current.value.audio;
    assetsAudioPlayer.playlist.startIndex =
        assetsAudioPlayer.current.value.index;
  }

  @action
  previousMusic(AssetsAudioPlayer player) async {
    await player.previous();
    atualMusic = assetsAudioPlayer.current.value.audio;
    assetsAudioPlayer.playlist.startIndex =
        assetsAudioPlayer.current.value.index;
  }

  @action
  stopMusic(AssetsAudioPlayer player) async {
    int atualIndex = assetsAudioPlayer.current.value.index;
    PlayingAudio _atualMusic = assetsAudioPlayer.current.value.audio;
    await player.stop();
    assetsAudioPlayer.playlist.startIndex = atualIndex;
    atualMusic = _atualMusic;
  }

  @action
  playOrPauseMusic() async {
    await assetsAudioPlayer.playOrPause();
  }

  String getAtualDuration(int seconds, int minutes) {
    var atualSeconds = "00";
    var atualMinutes = minutes == 0 ? "0" : minutes.toString();
    if (seconds < 60) {
      atualSeconds =
          seconds < 10 ? "0" + seconds.toString() : seconds.toString();
    } else {
      if (seconds % 60 >= 10) {
        atualSeconds = (seconds % 60).toString();
      } else {
        atualSeconds =
            seconds % 60 == 0 ? "00" : "0" + (seconds % 60).toString();
      }
    }
    String textDisplayed =
        seconds == 0 ? "00:00" : atualMinutes + ":" + atualSeconds;

    return textDisplayed;
  }

  String getTotalDuration(AssetsAudioPlayer player) {
    var returned = "00:00";
    try {
      var duration = player.current.value.audio.duration;
      int seconds = duration.inSeconds;
      String minutesRt =
          player.current.value.audio.duration.inMinutes.toString();
      int secondsRt =
          (seconds - player.current.value.audio.duration.inMinutes * 60 + 1);
      returned = secondsRt < 10
          ? minutesRt + ":0" + secondsRt.toString()
          : minutesRt + ":" + secondsRt.toString();
    } catch (e) {
      print(e);
    }

    return returned;
  }
}
