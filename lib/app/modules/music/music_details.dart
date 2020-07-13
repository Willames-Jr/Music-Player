import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:music_player/app/app_controller.dart';
import 'package:music_player/app/consts/app_const.dart';
import 'package:music_player/app/widgets/playing_musics_details.dart';

class MusicDetails extends StatefulWidget {
  @override
  _MusicDetailsState createState() => _MusicDetailsState();
}

class _MusicDetailsState extends State<MusicDetails> {
  final controller = Modular.get<AppController>();
  bool _playlistVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Música atual"),
        actions: <Widget>[
          IconButton(
              iconSize: 30,
              icon: Icon(Icons.queue_music),
              onPressed: () {
                setState(() {
                  _playlistVisible = !_playlistVisible;
                });
              }),
          SizedBox(
            width: 10.0,
          ),
        ],
      ),
      body: _playlistVisible
          ? PlayingMusicsDetails()
          : Container(
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0X46000000),
                            offset: Offset(0, 20),
                            spreadRadius: 0,
                            blurRadius: 30,
                          ),
                          BoxShadow(
                            color: Color(0X99000000),
                            offset: Offset(0, 10),
                            spreadRadius: 0,
                            blurRadius: 30,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          AppConsts.vinil,
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: MediaQuery.of(context).size.width * 0.7,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Observer(
                      builder: (_) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: RichText(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            strutStyle: StrutStyle(fontSize: 18.0),
                            text: TextSpan(
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                              text: controller
                                  .audioManager.atualMusic.audio.metas.title,
                            ),
                          ),
                        );
                      },
                    ),
                    Observer(
                      builder: (_) {
                        return RichText(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          strutStyle: StrutStyle(fontSize: 12.0),
                          text: TextSpan(
                            style: TextStyle(color: Colors.grey),
                            text: controller.audioManager.atualMusic.audio.metas
                                        .artist ==
                                    "<unknown>"
                                ? "Artista Desconhecido"
                                : controller
                                    .audioManager.atualMusic.audio.metas.artist,
                          ),
                        );
                      },
                    ),
                    Observer(
                      builder: (_) {
                        return PlayerBuilder.currentPosition(
                          player: controller.audioManager.assetsAudioPlayer,
                          builder: (context, duration) {
                            return Slider(
                              onChanged: (v) {
                                controller.audioManager.assetsAudioPlayer
                                    .seek(Duration(seconds: v.toInt()));
                              },
                              value: duration.inSeconds.toDouble(),
                              max: controller.audioManager.assetsAudioPlayer
                                      .current.value?.audio?.duration?.inSeconds
                                      ?.toDouble() ??
                                  100,
                              min: 0,
                              activeColor: Color(0XFF5E35B1),
                            );
                          },
                        );
                      },
                    ),
                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              width: 35,
                            ),
                            Observer(
                              builder: (_) {
                                return PlayerBuilder.currentPosition(
                                  player:
                                      controller.audioManager.assetsAudioPlayer,
                                  builder: (context, duration) {
                                    var atualDuration = controller.audioManager
                                        .getAtualDuration(duration.inSeconds,
                                            duration.inMinutes);
                                    return Text(atualDuration);
                                  },
                                );
                              },
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7,
                            ),
                            Observer(builder: (_) {
                              return controller.audioManager.assetsAudioPlayer
                                          .current.value ==
                                      null
                                  ? Text("00:00")
                                  : PlayerBuilder.currentPosition(
                                      player: controller
                                          .audioManager.assetsAudioPlayer,
                                      builder: (context, duration) {
                                        return Text(controller.audioManager
                                            .getTotalDuration(controller
                                                .audioManager
                                                .assetsAudioPlayer));
                                      });
                            }),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            IconButton(
                              iconSize: 30,
                              icon: Icon(Icons.skip_previous),
                              onPressed: () {
                                controller.audioManager.previousMusic(
                                    controller.audioManager.assetsAudioPlayer);
                              },
                            ),
                            PlayerBuilder.isPlaying(
                              player: controller.audioManager.assetsAudioPlayer,
                              builder: (context, isPlaying) {
                                return IconButton(
                                  iconSize: 50,
                                  icon: Icon(!isPlaying
                                      ? Icons.play_arrow
                                      : Icons.pause),
                                  onPressed: () {
                                    controller.audioManager.playOrPauseMusic();
                                  },
                                );
                              },
                            ),
                            IconButton(
                              iconSize: 30,
                              icon: Icon(Icons.skip_next),
                              onPressed: () {
                                controller.audioManager.nextMusic(
                                    controller.audioManager.assetsAudioPlayer);
                              },
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
