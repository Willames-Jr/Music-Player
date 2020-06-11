import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:music_player/app/app_controller.dart';
import 'package:music_player/app/consts/app_const.dart';
import 'package:music_player/app/entitys/music_entity.dart';
import 'package:music_player/app/entitys/playlist_entity.dart';

class ShowDialogs {
  final controller = Modular.get<AppController>();

  deleteMusicFromPlaylistDialog(
      BuildContext context, int indexOfPlaylist, String path) {
    showDialog(
      context: context,
      builder: (context) {
        Widget confirmButton = FlatButton(
          child: Text(
            "Sim",
            style: TextStyle(fontSize: 17),
          ),
          onPressed: () {
            Navigator.of(context).pop();
            controller.deleteMusicFromPlaylist(
                indexOfPlaylist: indexOfPlaylist, path: path);
          },
        );
        Widget cancelButton = FlatButton(
          child: Text(
            "Cancelar",
            style: TextStyle(fontSize: 17),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        );
        return AlertDialog(
          title: Text("Remover música da playlist"),
          content: Container(
            child: Text("Deseja remover essa música da playlist ? "),
          ),
          actions: <Widget>[
            cancelButton,
            confirmButton,
          ],
        );
      },
    );
  }

  _showCreateNewPlaylist(BuildContext context, int indexOfMusic) {
    showDialog(
      context: context,
      builder: (context) {
        var textController = TextEditingController();

        Widget createPlaylistButton = FlatButton(
          child: Text(
            "Nova playlist",
            style: TextStyle(fontSize: 17),
          ),
          onPressed: () async {
            if (textController.text.isNotEmpty) {
              await controller.createNewPlaylist(
                playlist: PlaylistEntity(
                    image: AppConsts.casseteImage, name: textController.text),
                music: MusicEntity(
                  path: controller.musicList.value[indexOfMusic].path,
                ),
              );
            }
            Navigator.of(context).pop();
          },
        );
        Widget cancelButton = FlatButton(
          child: Text(
            "Cancelar",
            style: TextStyle(fontSize: 17),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        );

        return AlertDialog(
          title: Text("Nova Playlist"),
          content: TextField(
            controller: textController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Nome",
            ),
          ),
          actions: <Widget>[cancelButton, createPlaylistButton],
        );
      },
    );
  }

  showAddOnPlaylistDialog(BuildContext context, int indexOfMusic) {
    showDialog(
      context: context,
      builder: (context) {
        Widget createButton = FlatButton(
          child: Text(
            "Nova playlist",
            style: TextStyle(fontSize: 17),
          ),
          onPressed: () {
            Navigator.of(context).pop();
            _showCreateNewPlaylist(context, indexOfMusic);
          },
        );
        Widget cancelButton = FlatButton(
          child: Text(
            "Cancelar",
            style: TextStyle(fontSize: 17),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        );
        return AlertDialog(
          title: Text("Adicionar á playlist"),
          content: Container(
            child: ListView.builder(
              itemCount: controller.playlists.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  child: FlatButton(
                    onPressed: () async {
                      await controller.addMusicOnPlaylist(
                        music: MusicEntity(
                          path: controller.musicList.value[indexOfMusic].path,
                          indexOfPlaylist: controller.playlists[index].index,
                        ),
                        index: index,
                      );
                      Navigator.of(context).pop();
                    },
                    child: RichText(
                      overflow: TextOverflow.ellipsis,
                      strutStyle: StrutStyle(fontSize: 20.0),
                      text: TextSpan(
                        style: TextStyle(color: Colors.black, fontSize: 20),
                        text: controller.playlists[index].name,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          actions: <Widget>[
            cancelButton,
            createButton,
          ],
        );
      },
    );
  }
}
