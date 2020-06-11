import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:music_player/app/consts/app_const.dart';
import 'package:music_player/app/widgets/micro_playlist.dart';

import '../app_controller.dart';

class AllPlaylists extends StatefulWidget {
  @override
  _AllPlaylistsState createState() => _AllPlaylistsState();
}

class _AllPlaylistsState extends State<AllPlaylists> {
  final controller = Modular.get<AppController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Observer(builder: (_) {
        return GridView.builder(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(8.0),
          addAutomaticKeepAlives: false,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: controller.playlists.length,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredGrid(
              columnCount: 2,
              position: index,
              duration: const Duration(milliseconds: 375),
              child: ScaleAnimation(
                child: GestureDetector(
                  onTap: () =>
                      Navigator.pushNamed(context, "/playlistDetails/$index"),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Card(
                      elevation: 10,
                      child: MicroPlaylist(
                        index: index,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
