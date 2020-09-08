import 'dart:async';
import 'package:floor/floor.dart';
import 'package:music_player/app/shared/repositories/interfaces/music_dao.dart';
import 'package:music_player/app/shared/repositories/interfaces/playlist_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:music_player/app/entitys/music_entity.dart';
import 'package:music_player/app/entitys/playlist_entity.dart';

part 'app_database.g.dart';

//Config local DB with Floor

@Database(version: 1, entities: [PlaylistEntity, MusicEntity])
abstract class DataBase extends FloorDatabase {
  PlaylistDao get playlistDao;
  MusicDao get musicDao;
}
