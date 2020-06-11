import 'package:floor/floor.dart';
import 'package:music_player/app/app_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:music_player/app/app_widget.dart';
import 'package:music_player/app/db/app_database.dart';

import 'package:music_player/app/modules/home/home_module.dart';
import 'package:music_player/app/shared/paths_manage/paths_manager.dart';

class AppModule extends MainModule {
  final DataBase db;

  AppModule({this.db});

  @override
  List<Bind> get binds => [
        Bind((i) => AppController(i.get<PathsManager>(), db)),
        Bind((i) => PathsManager()),
      ];

  @override
  List<Router> get routers => [
        Router('/', module: HomeModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
