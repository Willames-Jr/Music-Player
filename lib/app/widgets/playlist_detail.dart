import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:music_player/app/app_controller.dart';
import 'package:music_player/app/consts/app_const.dart';
import 'package:music_player/app/widgets/show_dialogs.dart';

class PlaylistDetails extends StatefulWidget {
  final int index;

  const PlaylistDetails({Key key, this.index}) : super(key: key);
  @override
  _PlaylistDetailsState createState() => _PlaylistDetailsState();
}

class _PlaylistDetailsState extends State<PlaylistDetails> {
  final controller = Modular.get<AppController>();
  final myScrollController = ScrollController();
  var musics;

  @override
  Widget build(BuildContext context) {
    musics = controller.audioManager.playlists[widget.index].musics;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(controller.audioManager.playlists[widget.index].name),
              centerTitle: true,
              background: Image.asset(
                controller.audioManager.playlists[widget.index].image,
                fit: BoxFit.cover,
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.play_arrow),
                iconSize: 40,
                onPressed: () => controller.audioManager
                    .playPlaylist(widget.index, shuffle: false, startIndex: 0),
              ),
              SizedBox(
                width: 20,
              )
            ],
          ),
          Observer(
            builder: (_) {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    var list = controller.audioManager
                        .getMusicsOfPlaylist(widget.index);

                    return ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: Image.asset(
                          controller.audioManager.playlists[widget.index].image,
                          fit: BoxFit.cover,
                          height: 50,
                          width: 50,
                        ),
                      ),
                      title: RichText(
                        overflow: TextOverflow.ellipsis,
                        strutStyle: StrutStyle(fontSize: 16.0),
                        text: TextSpan(
                          style: TextStyle(color: Colors.black),
                          text: list[index].metas.title,
                        ),
                      ),
                      trailing: PopupMenuButton(
                        icon: Icon(Icons.more_vert),
                        onSelected: (value) {
                          if (value == "delete") {
                            ShowDialogs().deleteMusicFromPlaylistDialog(
                                context, widget.index, list[index].path);
                          }
                        },
                        itemBuilder: (_) {
                          return <PopupMenuEntry>[
                            PopupMenuItem(
                              child: Text("Remover da playlist"),
                              value: "delete",
                            ),
                          ];
                        },
                      ),
                      subtitle: Text(list[index].metas.artist == "<unknown>"
                          ? "Artista desconhecido"
                          : list[index].metas.artist),
                      onTap: () {
                        controller.audioManager.playPlaylist(widget.index,
                            shuffle: false, startIndex: index);
                      },
                    );
                  },
                  childCount: controller
                      .audioManager.playlists[widget.index].musics.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
