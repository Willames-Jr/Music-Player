import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:music_player/app/app_controller.dart';
import 'package:music_player/app/consts/app_const.dart';
import 'package:music_player/app/entitys/music_entity.dart';
import 'package:music_player/app/entitys/playlist_entity.dart';

// Each function displays Dialog so that the user can make/confirm a choice

class ShowDialogs {
  final controller = Modular.get<AppController>();
  final _listOfImages = [
    AppConsts.electicGuitar,
    AppConsts.guitar,
    AppConsts.headphone,
    AppConsts.piano,
    AppConsts.people
  ];
  var _actualImage = 0;

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
            controller.audioManager.deleteMusicFromPlaylist(
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
          title: Text("Remove music from playlist"),
          content: Container(
            child: Text("Do you want to remove this song from the playlist ?"),
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
            "New playlist",
            style: TextStyle(fontSize: 17),
          ),
          onPressed: () async {
            if (textController.text.isNotEmpty) {
              await controller.audioManager.createNewPlaylist(
                playlist: PlaylistEntity(
                    image: _listOfImages[_actualImage],
                    name: textController.text),
                music: MusicEntity(
                  path: controller
                      .audioManager.musicList.value[indexOfMusic].path,
                ),
              );
            }
            Navigator.of(context).pop();
          },
        );
        Widget cancelButton = FlatButton(
          child: Text(
            "Cancel",
            style: TextStyle(fontSize: 17),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        );

        return SingleChildScrollView(
          child: AlertDialog(
            title: Text("New Playlist"),
            content: Column(
              children: <Widget>[
                Text(
                  "Select a image: ",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 10,
                ),
                CarouselSlider.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          _listOfImages[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                  itemCount: 5,
                  options: CarouselOptions(
                    height: 150.0,
                    onPageChanged: (index, reason) {
                      _actualImage = index;
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: textController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Name",
                  ),
                ),
              ],
            ),
            actions: <Widget>[cancelButton, createPlaylistButton],
          ),
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
            "New playlist",
            style: TextStyle(fontSize: 17),
          ),
          onPressed: () {
            Navigator.of(context).pop();
            _showCreateNewPlaylist(context, indexOfMusic);
          },
        );
        Widget cancelButton = FlatButton(
          child: Text(
            "Cancel",
            style: TextStyle(fontSize: 17),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        );
        return AlertDialog(
          title: Text("Add to playlist"),
          content: Container(
            child: ListView.builder(
              itemCount: controller.audioManager.playlists.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  child: FlatButton(
                    onPressed: () async {
                      await controller.audioManager.addMusicOnPlaylist(
                        music: MusicEntity(
                          path: controller
                              .audioManager.musicList.value[indexOfMusic].path,
                          indexOfPlaylist:
                              controller.audioManager.playlists[index].index,
                        ),
                        indexOfPlaylist: index,
                      );
                      Navigator.of(context).pop();
                    },
                    child: RichText(
                      overflow: TextOverflow.ellipsis,
                      strutStyle: StrutStyle(fontSize: 20.0),
                      text: TextSpan(
                        style: TextStyle(color: Colors.black, fontSize: 20),
                        text: controller.audioManager.playlists[index].name,
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
