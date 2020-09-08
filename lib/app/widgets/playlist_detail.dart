import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:music_player/app/app_controller.dart';
import 'package:music_player/app/widgets/show_dialogs.dart';

/* Show the selected playlist informed by "playlistIndex" details and allows the user to
  play it from the beginning or select a song to play from it
*/

class PlaylistDetails extends StatefulWidget {
  final int playlistIndex;

  const PlaylistDetails({Key key, this.playlistIndex}) : super(key: key);
  @override
  _PlaylistDetailsState createState() => _PlaylistDetailsState();
}

class _PlaylistDetailsState extends State<PlaylistDetails> {
  final controller = Modular.get<AppController>();
  final myScrollController = ScrollController();
  var musics;

  @override
  Widget build(BuildContext context) {
    musics = controller.audioManager.playlists[widget.playlistIndex].musics;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                  controller.audioManager.playlists[widget.playlistIndex].name),
              centerTitle: true,
              background: Image.asset(
                controller.audioManager.playlists[widget.playlistIndex].image,
                fit: BoxFit.cover,
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.play_arrow),
                iconSize: 40,
                onPressed: () => controller.audioManager.playPlaylist(
                    indexOfPlaylist: widget.playlistIndex,
                    shuffle: false,
                    startIndex: 0),
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
                    var list = controller.audioManager.getMusicsOfPlaylist(
                        indexOfPlaylist: widget.playlistIndex);

                    return ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: Image.asset(
                          controller.audioManager
                              .playlists[widget.playlistIndex].image,
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
                            ShowDialogs().deleteMusicFromPlaylistDialog(context,
                                widget.playlistIndex, list[index].path);
                          }
                        },
                        itemBuilder: (_) {
                          return <PopupMenuEntry>[
                            PopupMenuItem(
                              child: Text("Remove from playlist"),
                              value: "delete",
                            ),
                          ];
                        },
                      ),
                      subtitle: Text(list[index].metas.artist == "<unknown>"
                          ? "Unknown artist"
                          : list[index].metas.artist),
                      onTap: () {
                        controller.audioManager.playPlaylist(
                            indexOfPlaylist: widget.playlistIndex,
                            shuffle: false,
                            startIndex: index);
                      },
                    );
                  },
                  childCount: controller.audioManager
                      .playlists[widget.playlistIndex].musics.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
