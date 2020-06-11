import 'dart:convert';

import 'package:music_player/app/shared/models/audio_model.dart';
import 'package:storage_path/storage_path.dart';

class PathsManager {
  Future<List<Files>> initializeList() async {
    List<Files> musicList = [];
    try {
      String audioPath = await StoragePath.audioPath;
      var response = jsonDecode(audioPath);
      var audioList = response as List;
      List<AudioModel> list = audioList
          .map<AudioModel>((json) => AudioModel.fromJson(json))
          .toList();

      for (int l = 0; l < list.length; l++) {
        for (int f = 0; f < list[l].files.length; f++) {
          musicList.add(list[l].files[f]);
        }
      }
    } catch (e) {
      print("Erro ao tentar acessar o arquivo: " + e);
    }
    return musicList;
  }
}
