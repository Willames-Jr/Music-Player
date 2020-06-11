// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorDataBase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$DataBaseBuilder databaseBuilder(String name) =>
      _$DataBaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$DataBaseBuilder inMemoryDatabaseBuilder() => _$DataBaseBuilder(null);
}

class _$DataBaseBuilder {
  _$DataBaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$DataBaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$DataBaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<DataBase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$DataBase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$DataBase extends DataBase {
  _$DataBase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  PlaylistDao _playlistDaoInstance;

  MusicDao _musicDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Playlists` (`index` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT, `image` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Musics` (`index` INTEGER PRIMARY KEY AUTOINCREMENT, `path` TEXT, `indexOfPlaylist` INTEGER)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  PlaylistDao get playlistDao {
    return _playlistDaoInstance ??= _$PlaylistDao(database, changeListener);
  }

  @override
  MusicDao get musicDao {
    return _musicDaoInstance ??= _$MusicDao(database, changeListener);
  }
}

class _$PlaylistDao extends PlaylistDao {
  _$PlaylistDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _playlistEntityInsertionAdapter = InsertionAdapter(
            database,
            'Playlists',
            (PlaylistEntity item) => <String, dynamic>{
                  'index': item.index,
                  'name': item.name,
                  'image': item.image
                },
            changeListener),
        _playlistEntityDeletionAdapter = DeletionAdapter(
            database,
            'Playlists',
            ['index'],
            (PlaylistEntity item) => <String, dynamic>{
                  'index': item.index,
                  'name': item.name,
                  'image': item.image
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _playlistsMapper = (Map<String, dynamic> row) => PlaylistEntity(
      index: row['index'] as int,
      name: row['name'] as String,
      image: row['image'] as String);

  final InsertionAdapter<PlaylistEntity> _playlistEntityInsertionAdapter;

  final DeletionAdapter<PlaylistEntity> _playlistEntityDeletionAdapter;

  @override
  Future<List<PlaylistEntity>> findAllPlaylists() async {
    return _queryAdapter.queryList('SELECT * FROM Playlists',
        mapper: _playlistsMapper);
  }

  @override
  Stream<PlaylistEntity> findPlaylistByIndex(int index) {
    return _queryAdapter.queryStream('SELECT * FROM Playlists WHERE index = ?',
        arguments: <dynamic>[index],
        queryableName: 'Playlists',
        isView: false,
        mapper: _playlistsMapper);
  }

  @override
  Future<void> deletePlaylistWhereName(String name) async {
    await _queryAdapter.queryNoReturn('DELETE FROM Playlists WHERE name = ?',
        arguments: <dynamic>[name]);
  }

  @override
  Future<int> insertPlaylist(PlaylistEntity playlist) {
    return _playlistEntityInsertionAdapter.insertAndReturnId(
        playlist, OnConflictStrategy.abort);
  }

  @override
  Future<int> deletePlaylist(PlaylistEntity playlist) {
    return _playlistEntityDeletionAdapter.deleteAndReturnChangedRows(playlist);
  }
}

class _$MusicDao extends MusicDao {
  _$MusicDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _musicEntityInsertionAdapter = InsertionAdapter(
            database,
            'Musics',
            (MusicEntity item) => <String, dynamic>{
                  'index': item.index,
                  'path': item.path,
                  'indexOfPlaylist': item.indexOfPlaylist
                },
            changeListener),
        _musicEntityDeletionAdapter = DeletionAdapter(
            database,
            'Musics',
            ['index'],
            (MusicEntity item) => <String, dynamic>{
                  'index': item.index,
                  'path': item.path,
                  'indexOfPlaylist': item.indexOfPlaylist
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _musicsMapper = (Map<String, dynamic> row) => MusicEntity(
      index: row['index'] as int,
      path: row['path'] as String,
      indexOfPlaylist: row['indexOfPlaylist'] as int);

  final InsertionAdapter<MusicEntity> _musicEntityInsertionAdapter;

  final DeletionAdapter<MusicEntity> _musicEntityDeletionAdapter;

  @override
  Future<List<MusicEntity>> findAllMusics() async {
    return _queryAdapter.queryList('SELECT * FROM Musics',
        mapper: _musicsMapper);
  }

  @override
  Stream<MusicEntity> findMusicByIndex(int index) {
    return _queryAdapter.queryStream('SELECT * FROM Musics WHERE index = ?',
        arguments: <dynamic>[index],
        queryableName: 'Musics',
        isView: false,
        mapper: _musicsMapper);
  }

  @override
  Future<List<MusicEntity>> findMusicsWhere(int indexOfPlaylist) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Musics WHERE indexOfPlaylist = ?',
        arguments: <dynamic>[indexOfPlaylist],
        mapper: _musicsMapper);
  }

  @override
  Future<void> deleteMusicWhere(int indexOfPlaylist, String path) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM Musics WHERE indexOfPlaylist = ? AND path = ?',
        arguments: <dynamic>[indexOfPlaylist, path]);
  }

  @override
  Future<MusicEntity> deleteAllMusicsOfPlaylist(int indexOfPlaylist) async {
    return _queryAdapter.query('DELETE FROM Musics WHERE indexOfPlaylist = ?',
        arguments: <dynamic>[indexOfPlaylist], mapper: _musicsMapper);
  }

  @override
  Future<void> insertMusic(MusicEntity music) async {
    await _musicEntityInsertionAdapter.insert(music, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteMusic(MusicEntity music) async {
    await _musicEntityDeletionAdapter.delete(music);
  }
}
