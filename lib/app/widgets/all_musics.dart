import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:music_player/app/app_controller.dart';
import 'package:music_player/app/consts/app_const.dart';
import 'package:music_player/app/shared/models/audio_model.dart';
import 'package:music_player/app/widgets/show_dialogs.dart';

class AllMusics extends StatefulWidget {
  @override
  _AllMusicsState createState() => _AllMusicsState();
}

class _AllMusicsState extends State<AllMusics> {
  final controller = Modular.get<AppController>();
  final ScrollController myScrollController = ScrollController();

  getShuffleButton(List<Files> list, int index) {
    return Column(
      children: <Widget>[
        Card(
          margin: EdgeInsets.all(0),
          elevation: 5,
          child: FlatButton(
            padding: EdgeInsets.all(0),
            onPressed: () {
              controller.playMusic(list[index], shuffle: true);
            },
            child: const ListTile(
              title: Text(
                "Ordem aleatória",
                style: TextStyle(fontSize: 21, color: Colors.blue),
              ),
              leading: SizedBox(
                height: 50,
                width: 50,
                child: Icon(
                  Icons.shuffle,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ),
        getListTile(list, index),
      ],
    );
  }

  getListTile(List<Files> list, int index) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: Image.asset(
          AppConsts.casseteImage,
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
          text: list[index].displayName,
        ),
      ),
      trailing: PopupMenuButton(
        icon: Icon(Icons.more_vert),
        onSelected: (value) {
          if (value == "create") {
            ShowDialogs().showAddOnPlaylistDialog(context, index);
          } else if (value == "add") {
            if (controller.assetsAudioPlayer.playlist != null) {
              controller.assetsAudioPlayer.playlist.add(
                Audio.file(
                  list[index].path,
                  metas: Metas(
                      album: list[index].album,
                      artist: list[index].artist,
                      title: list[index].displayName),
                ),
              );
            }
          }
        },
        itemBuilder: (_) {
          return <PopupMenuEntry>[
            PopupMenuItem(
              child: Text("Adicionar á Playlist"),
              value: "create",
            ),
            PopupMenuItem(
              child: Text("Adicionar ao final da fila"),
              value: "add",
            ),
          ];
        },
      ),
      subtitle: Text(controller.musicList.value[index].artist == "<unknown>"
          ? "Artista desconhecido"
          : controller.musicList.value[index].artist),
      onTap: () {
        controller.playMusic(list[index], shuffle: false);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 10.0,
        left: 10.0,
        bottom: 60.0,
      ),
      child: Container(
        color: Colors.white,
        child: DraggableScrollbar.rrect(
          controller: myScrollController,
          child: ListView.builder(
            itemCount: controller.musicList.value.length,
            controller: myScrollController,
            itemBuilder: (_, index) {
              var list = controller.musicList.value;
              return index == 0
                  ? getShuffleButton(list, index)
                  : getListTile(list, index);
            },
          ),
        ),
      ),
    );
  }
}
