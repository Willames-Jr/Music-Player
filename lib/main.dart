import 'package:flutter/material.dart';
import 'package:music_player/app/app_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:music_player/app/db/app_database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ModularApp(
      module: AppModule(
        db: await $FloorDataBase.databaseBuilder('app_database.db').build(),
      ),
    ),
  );
}
