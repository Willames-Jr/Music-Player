// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppController on _AppBase, Store {
  final _$playlistsAtom = Atom(name: '_AppBase.playlists');

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

  final _$assetsAudioPlayerAtom = Atom(name: '_AppBase.assetsAudioPlayer');

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

  final _$atualMusicAtom = Atom(name: '_AppBase.atualMusic');

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

  final _$musicListAtom = Atom(name: '_AppBase.musicList');

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
      AsyncAction('_AppBase.createNewPlaylist');

  @override
  Future createNewPlaylist({PlaylistEntity playlist, MusicEntity music}) {
    return _$createNewPlaylistAsyncAction
        .run(() => super.createNewPlaylist(playlist: playlist, music: music));
  }

  final _$addMusicOnPlaylistAsyncAction =
      AsyncAction('_AppBase.addMusicOnPlaylist');

  @override
  Future addMusicOnPlaylist({MusicEntity music, int index}) {
    return _$addMusicOnPlaylistAsyncAction
        .run(() => super.addMusicOnPlaylist(music: music, index: index));
  }

  final _$deletePlaylistAsyncAction = AsyncAction('_AppBase.deletePlaylist');

  @override
  Future deletePlaylist({PlaylistEntity playlist}) {
    return _$deletePlaylistAsyncAction
        .run(() => super.deletePlaylist(playlist: playlist));
  }

  final _$deleteMusicFromPlaylistAsyncAction =
      AsyncAction('_AppBase.deleteMusicFromPlaylist');

  @override
  Future deleteMusicFromPlaylist({int indexOfPlaylist, String path}) {
    return _$deleteMusicFromPlaylistAsyncAction.run(() => super
        .deleteMusicFromPlaylist(indexOfPlaylist: indexOfPlaylist, path: path));
  }

  final _$_initPlaylistsAsyncAction = AsyncAction('_AppBase._initPlaylists');

  @override
  Future _initPlaylists() {
    return _$_initPlaylistsAsyncAction.run(() => super._initPlaylists());
  }

  final _$playPlaylistAsyncAction = AsyncAction('_AppBase.playPlaylist');

  @override
  Future playPlaylist(int index, {bool shuffle, int startIndex}) {
    return _$playPlaylistAsyncAction.run(() =>
        super.playPlaylist(index, shuffle: shuffle, startIndex: startIndex));
  }

  final _$playMusicAsyncAction = AsyncAction('_AppBase.playMusic');

  @override
  Future playMusic(Files _file, {bool shuffle}) {
    return _$playMusicAsyncAction
        .run(() => super.playMusic(_file, shuffle: shuffle));
  }

  final _$playMusicOnPlaylistAsyncAction =
      AsyncAction('_AppBase.playMusicOnPlaylist');

  @override
  Future playMusicOnPlaylist(int index) {
    return _$playMusicOnPlaylistAsyncAction
        .run(() => super.playMusicOnPlaylist(index));
  }

  final _$nextMusicAsyncAction = AsyncAction('_AppBase.nextMusic');

  @override
  Future nextMusic(AssetsAudioPlayer player) {
    return _$nextMusicAsyncAction.run(() => super.nextMusic(player));
  }

  final _$previousMusicAsyncAction = AsyncAction('_AppBase.previousMusic');

  @override
  Future previousMusic(AssetsAudioPlayer player) {
    return _$previousMusicAsyncAction.run(() => super.previousMusic(player));
  }

  final _$playOrPauseMusicAsyncAction =
      AsyncAction('_AppBase.playOrPauseMusic');

  @override
  Future playOrPauseMusic() {
    return _$playOrPauseMusicAsyncAction.run(() => super.playOrPauseMusic());
  }

  final _$_AppBaseActionController = ActionController(name: '_AppBase');

  @override
  dynamic addAsNextMusic(Audio audio) {
    final _$actionInfo =
        _$_AppBaseActionController.startAction(name: '_AppBase.addAsNextMusic');
    try {
      return super.addAsNextMusic(audio);
    } finally {
      _$_AppBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addAtTheEndOfQueue(Audio audio) {
    final _$actionInfo = _$_AppBaseActionController.startAction(
        name: '_AppBase.addAtTheEndOfQueue');
    try {
      return super.addAtTheEndOfQueue(audio);
    } finally {
      _$_AppBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic modifyPosition(int newIndex, int oldIndex) {
    final _$actionInfo =
        _$_AppBaseActionController.startAction(name: '_AppBase.modifyPosition');
    try {
      return super.modifyPosition(newIndex, oldIndex);
    } finally {
      _$_AppBaseActionController.endAction(_$actionInfo);
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
