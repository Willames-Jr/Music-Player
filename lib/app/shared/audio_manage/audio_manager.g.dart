// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_manager.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AudioManager on _AudioManagerBase, Store {
  final _$playlistsAtom = Atom(name: '_AudioManagerBase.playlists');

  @override
  ObservableList<Playlistmodel> get playlists {
    _$playlistsAtom.reportRead();
    return super.playlists;
  }

  @override
  set playlists(ObservableList<Playlistmodel> value) {
    _$playlistsAtom.reportWrite(value, super.playlists, () {
      super.playlists = value;
    });
  }

  final _$assetsAudioPlayerAtom =
      Atom(name: '_AudioManagerBase.assetsAudioPlayer');

  @override
  AssetsAudioPlayer get assetsAudioPlayer {
    _$assetsAudioPlayerAtom.reportRead();
    return super.assetsAudioPlayer;
  }

  @override
  set assetsAudioPlayer(AssetsAudioPlayer value) {
    _$assetsAudioPlayerAtom.reportWrite(value, super.assetsAudioPlayer, () {
      super.assetsAudioPlayer = value;
    });
  }

  final _$atualMusicAtom = Atom(name: '_AudioManagerBase.atualMusic');

  @override
  PlayingAudio get atualMusic {
    _$atualMusicAtom.reportRead();
    return super.atualMusic;
  }

  @override
  set atualMusic(PlayingAudio value) {
    _$atualMusicAtom.reportWrite(value, super.atualMusic, () {
      super.atualMusic = value;
    });
  }

  final _$musicListAtom = Atom(name: '_AudioManagerBase.musicList');

  @override
  ObservableFuture<List<Files>> get musicList {
    _$musicListAtom.reportRead();
    return super.musicList;
  }

  @override
  set musicList(ObservableFuture<List<Files>> value) {
    _$musicListAtom.reportWrite(value, super.musicList, () {
      super.musicList = value;
    });
  }

  final _$createNewPlaylistAsyncAction =
      AsyncAction('_AudioManagerBase.createNewPlaylist');

  @override
  Future createNewPlaylist({PlaylistEntity playlist, MusicEntity music}) {
    return _$createNewPlaylistAsyncAction
        .run(() => super.createNewPlaylist(playlist: playlist, music: music));
  }

  final _$addMusicOnPlaylistAsyncAction =
      AsyncAction('_AudioManagerBase.addMusicOnPlaylist');

  @override
  Future addMusicOnPlaylist({MusicEntity music, int indexOfPlaylist}) {
    return _$addMusicOnPlaylistAsyncAction.run(() => super
        .addMusicOnPlaylist(music: music, indexOfPlaylist: indexOfPlaylist));
  }

  final _$deletePlaylistAsyncAction =
      AsyncAction('_AudioManagerBase.deletePlaylist');

  @override
  Future deletePlaylist({PlaylistEntity playlist}) {
    return _$deletePlaylistAsyncAction
        .run(() => super.deletePlaylist(playlist: playlist));
  }

  final _$deleteMusicFromPlaylistAsyncAction =
      AsyncAction('_AudioManagerBase.deleteMusicFromPlaylist');

  @override
  Future deleteMusicFromPlaylist({int indexOfPlaylist, String path}) {
    return _$deleteMusicFromPlaylistAsyncAction.run(() => super
        .deleteMusicFromPlaylist(indexOfPlaylist: indexOfPlaylist, path: path));
  }

  final _$_initPlaylistsAsyncAction =
      AsyncAction('_AudioManagerBase._initPlaylists');

  @override
  Future _initPlaylists() {
    return _$_initPlaylistsAsyncAction.run(() => super._initPlaylists());
  }

  final _$playPlaylistAsyncAction =
      AsyncAction('_AudioManagerBase.playPlaylist');

  @override
  Future playPlaylist({int indexOfPlaylist, bool shuffle, int startIndex}) {
    return _$playPlaylistAsyncAction.run(() => super.playPlaylist(
        indexOfPlaylist: indexOfPlaylist,
        shuffle: shuffle,
        startIndex: startIndex));
  }

  final _$playMusicAsyncAction = AsyncAction('_AudioManagerBase.playMusic');

  @override
  Future playMusic({Files musicFile, bool shuffle}) {
    return _$playMusicAsyncAction
        .run(() => super.playMusic(musicFile: musicFile, shuffle: shuffle));
  }

  final _$playMusicOnActualPlaylistAsyncAction =
      AsyncAction('_AudioManagerBase.playMusicOnActualPlaylist');

  @override
  Future playMusicOnActualPlaylist({int indexOfMusic}) {
    return _$playMusicOnActualPlaylistAsyncAction
        .run(() => super.playMusicOnActualPlaylist(indexOfMusic: indexOfMusic));
  }

  final _$modifyPositionAsyncAction =
      AsyncAction('_AudioManagerBase.modifyPosition');

  @override
  Future modifyPosition({int newIndex, int oldIndex}) {
    return _$modifyPositionAsyncAction.run(
        () => super.modifyPosition(newIndex: newIndex, oldIndex: oldIndex));
  }

  final _$nextMusicAsyncAction = AsyncAction('_AudioManagerBase.nextMusic');

  @override
  Future nextMusic(AssetsAudioPlayer player) {
    return _$nextMusicAsyncAction.run(() => super.nextMusic(player));
  }

  final _$previousMusicAsyncAction =
      AsyncAction('_AudioManagerBase.previousMusic');

  @override
  Future previousMusic(AssetsAudioPlayer player) {
    return _$previousMusicAsyncAction.run(() => super.previousMusic(player));
  }

  final _$stopMusicAsyncAction = AsyncAction('_AudioManagerBase.stopMusic');

  @override
  Future stopMusic(AssetsAudioPlayer player) {
    return _$stopMusicAsyncAction.run(() => super.stopMusic(player));
  }

  final _$playOrPauseMusicAsyncAction =
      AsyncAction('_AudioManagerBase.playOrPauseMusic');

  @override
  Future playOrPauseMusic() {
    return _$playOrPauseMusicAsyncAction.run(() => super.playOrPauseMusic());
  }

  final _$_AudioManagerBaseActionController =
      ActionController(name: '_AudioManagerBase');

  @override
  dynamic addAsNextMusic({Audio music}) {
    final _$actionInfo = _$_AudioManagerBaseActionController.startAction(
        name: '_AudioManagerBase.addAsNextMusic');
    try {
      return super.addAsNextMusic(music: music);
    } finally {
      _$_AudioManagerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addAtTheEndOfQueue({Audio music}) {
    final _$actionInfo = _$_AudioManagerBaseActionController.startAction(
        name: '_AudioManagerBase.addAtTheEndOfQueue');
    try {
      return super.addAtTheEndOfQueue(music: music);
    } finally {
      _$_AudioManagerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
playlists: ${playlists},
assetsAudioPlayer: ${assetsAudioPlayer},
atualMusic: ${atualMusic},
musicList: ${musicList}
    ''';
  }
}
