import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:music_player/app/app_controller.dart';

class PlayingMusicsDetails extends StatefulWidget {
  @override
  _PlayingMusicsDetailsState createState() => _PlayingMusicsDetailsState();
}

class _PlayingMusicsDetailsState extends State<PlayingMusicsDetails> {
  final controller = Modular.get<AppController>();
  final ScrollController myScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Observer(
        builder: (_) {
          return ImplicitlyAnimatedReorderableList<Audio>(
            items: controller.assetsAudioPlayer.playlist.audios,
            areItemsTheSame: (oldItem, newItem) => oldItem.path == newItem.path,
            onReorderFinished: (item, from, to, newItems) {
              controller.modifyPosition(to, from);
            },
            itemBuilder: (context, itemAnimation, item, index) {
              return Reorderable(
                key: ValueKey(item),
                builder: (context, dragAnimation, inDrag) {
                  final t = dragAnimation.value;
                  final elevation = lerpDouble(0, 8, t);
                  final color = Color.lerp(Colors.white, Colors.white, t);
                  return SizeFadeTransition(
                    sizeFraction: 0.7,
                    curve: Curves.easeInOut,
                    animation: itemAnimation,
                    child: Material(
                      color: color,
                      elevation: elevation,
                      child: ListTile(
                        title: Text(item.metas.title),
                        trailing: Handle(
                          delay: const Duration(milliseconds: 100),
                          child: Icon(
                            Icons.list,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      /*ListView.builder(
          controller: myScrollController,
          itemCount: controller.assetsAudioPlayer.playlist.audios.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: RichText(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                strutStyle: StrutStyle(fontSize: 17.0),
                text: TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 17),
                    text: controller
                        .assetsAudioPlayer.playlist.audios[index].metas.title),
              ),
              subtitle: RichText(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                strutStyle: StrutStyle(fontSize: 12.0),
                text: TextSpan(
                  style: TextStyle(color: Colors.grey),
                  text: controller.assetsAudioPlayer.playlist.audios[index]
                              .metas.artist ==
                          "<unknown>"
                      ? "Artista Desconhecido"
                      : controller.assetsAudioPlayer.playlist.audios[index]
                          .metas.artist,
                ),
              ),
              onTap: () => controller.playMusicOnPlaylist(index),
            );
          },
        ),*/
    );
  }
}
