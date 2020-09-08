import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:music_player/app/app_controller.dart';
import 'package:music_player/app/entitys/playlist_entity.dart';

// Shows some playlist details, and allows the user to delete, play or play in random order

class MicroPlaylist extends StatefulWidget {
  final int index;

  const MicroPlaylist({Key key, this.index}) : super(key: key);

  @override
  _MicroPlaylistState createState() => _MicroPlaylistState();
}

class _MicroPlaylistState extends State<MicroPlaylist> {
  final controller = Modular.get<AppController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        height: 52,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Observer(builder: (_) {
                return RichText(
                  overflow: TextOverflow.ellipsis,
                  strutStyle: StrutStyle(fontSize: 16.0),
                  text: TextSpan(
                    style: TextStyle(color: Colors.black),
                    text: controller.audioManager.playlists[widget.index].name,
                  ),
                );
              }),
            ),
            PopupMenuButton(
              icon: Icon(Icons.more_vert),
              onSelected: (value) {
                if (value == "delete") {
                  controller.audioManager.deletePlaylist(
                    playlist: PlaylistEntity(
                        name: controller
                            .audioManager.playlists[widget.index].name),
                  );
                } else if (value == "shuffle") {
                  controller.audioManager.playPlaylist(
                      indexOfPlaylist: widget.index,
                      shuffle: true,
                      startIndex: 0);
                }
              },
              itemBuilder: (_) {
                return <PopupMenuEntry>[
                  PopupMenuItem(
                    child: Text("Delete playlist"),
                    value: "delete",
                  ),
                  PopupMenuItem(
                    child: Text("Random order"),
                    value: "shuffle",
                  ),
                ];
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          Opacity(
            opacity: 0.7,
            child: Image.asset(
              controller.audioManager.playlists[widget.index].image,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            top: 46,
            right: 2,
            child: IconButton(
              icon: Icon(
                Icons.play_circle_filled,
                color: Colors.white,
              ),
              iconSize: 40,
              onPressed: () {
                controller.audioManager.playPlaylist(
                    indexOfPlaylist: widget.index,
                    shuffle: false,
                    startIndex: 0);
              },
            ),
          ),
        ],
      ),
    );
  }
}
