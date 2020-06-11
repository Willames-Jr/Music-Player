import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
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
      child: DraggableScrollbar.rrect(
        controller: myScrollController,
        child: ListView.builder(
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
        ),
      ),
    );
  }
}
