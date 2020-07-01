import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:music_player/app/app_controller.dart';
import 'package:music_player/app/consts/app_const.dart';

class BottomDetail extends StatefulWidget {
  @override
  _BottomDetailState createState() => _BottomDetailState();
}

class _BottomDetailState extends State<BottomDetail> {
  final controller = Modular.get<AppController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: MediaQuery.of(context).size.width,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 1),
              offset: Offset(0, 0),
              blurRadius: 5,
              spreadRadius: 0,
            )
          ],
        ),
        child: Stack(
          children: <Widget>[
            Observer(
              builder: (_) {
                return FlatButton(
                  onPressed:
                      controller.audioManager.atualMusic.audio.path == null
                          ? null
                          : () {
                              Navigator.pushNamed(context, "/musicDetails");
                            },
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 8,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: Image.asset(
                            AppConsts.vinil,
                            fit: BoxFit.cover,
                            height: 55,
                            width: 55,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 78,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Observer(builder: (_) {
                              return SizedBox(
                                width: 180,
                                child: RichText(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  strutStyle: StrutStyle(fontSize: 18.0),
                                  text: TextSpan(
                                    style: TextStyle(color: Colors.black),
                                    text: controller.audioManager.atualMusic
                                        .audio.metas.title,
                                  ),
                                ),
                              );
                            }),
                            SizedBox(
                              height: 5,
                            ),
                            Observer(builder: (_) {
                              return Text(
                                controller.audioManager.atualMusic.audio.metas
                                            .artist ==
                                        "<unknown>"
                                    ? "Artista Desconhecido"
                                    : controller.audioManager.atualMusic.audio
                                        .metas.artist,
                                style: TextStyle(fontSize: 14),
                                textAlign: TextAlign.left,
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Positioned(
              right: 0.1,
              child: SizedBox(
                height: 60,
                child: PlayerBuilder.isPlaying(
                  player: controller.audioManager.assetsAudioPlayer,
                  builder: (context, isPlaying) {
                    return FlatButton(
                      color: Colors.white,
                      onPressed: () {
                        controller.audioManager.playOrPauseMusic();
                      },
                      child: Icon(!isPlaying ? Icons.play_arrow : Icons.pause),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
