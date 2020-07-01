import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:mobx/mobx.dart';
import 'package:music_player/app/db/app_database.dart';
import 'package:music_player/app/entitys/music_entity.dart';
import 'package:music_player/app/entitys/playlist_entity.dart';
import 'package:music_player/app/shared/audio_manage/audio_manager.dart';
import 'package:music_player/app/shared/models/audio_model.dart';
import 'package:music_player/app/shared/models/playlist_model.dart';
import 'package:music_player/app/shared/paths_manage/paths_manager.dart';

part 'app_controller.g.dart';

class AppController = _AppBase with _$AppController;

abstract class _AppBase with Store {
  //final PathsManager pathsManager;

  //final DataBase db;

  final AudioManager audioManager;

  /*@observable
  ObservableList<Playlistmodel> playlists = ObservableList<Playlistmodel>();

  @observable
  var assetsAudioPlayer = AssetsAudioPlayer();

  var liste;

  @observable
  PlayingAudio atualMusic = PlayingAudio(
      audio: Audio.file("", metas: Metas(artist: "Artist", title: "Music")));

  @observable
  ObservableFuture<List<Files>> musicList;*/

  _AppBase(this.audioManager);

  /*@action
  createNewPlaylist({PlaylistEntity playlist, MusicEntity music}) async {
    int index = await db.playlistDao.insertPlaylist(playlist);
    music.indexOfPlaylist = index;
    await db.musicDao.insertMusic(music);
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
    await db.musicDao.insertMusic(music);
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

    await db.playlistDao.deletePlaylistWhereName(playlist.name);
    await db.musicDao.deleteAllMusicsOfPlaylist(playlist.index);
  }

  @action
  deleteMusicFromPlaylist({int indexOfPlaylist, String path}) async {
    int index = playlists[indexOfPlaylist].index;
    await db.musicDao.deleteMusicWhere(index, path);
    playlists[indexOfPlaylist]
        .musics
        .removeWhere((element) => element.path == path);
  }

  @action
  _initPlaylists() async {
    var dbPlaylists = await db.playlistDao.findAllPlaylists();
    for (PlaylistEntity playlist in dbPlaylists) {
      playlists.add(
        Playlistmodel(
          index: playlist.index,
          name: playlist.name,
          image: playlist.image,
          musics: ObservableList.of(
              await db.musicDao.findMusicsWhere(playlist.index)),
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
        stopEnabled: false,
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
        stopEnabled: false,
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
        stopEnabled: false,
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
  modifyPosition(int newIndex, int oldIndex) {
    final music = assetsAudioPlayer.playlist.removeAtIndex(oldIndex);
    assetsAudioPlayer.playlist.insert(newIndex, music);
    atualMusic = assetsAudioPlayer.current.value.audio;
  }

  @action
  nextMusic(AssetsAudioPlayer player) async {
    await player.next();
    atualMusic = assetsAudioPlayer.current.value.audio;
  }

  @action
  previousMusic(AssetsAudioPlayer player) async {
    await player.previous();
    atualMusic = assetsAudioPlayer.current.value.audio;
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
    var returned = "nada";
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
  }*/
}
