import 'package:flutter_modular/flutter_modular.dart';
import 'package:music_player/app/modules/home/home_page.dart';
import 'package:music_player/app/modules/music/music_details.dart';
import 'package:music_player/app/modules/splash/splash_screen.dart';
import 'package:music_player/app/widgets/playlist_detail.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [];

  @override
  List<Router> get routers => [
        Router('/', child: (_, args) => SplashScreen()),
        Router('/musicDetails', child: (_, args) => MusicDetails()),
        Router('/playlistDetails/:index',
            child: (_, args) =>
                PlaylistDetails(index: int.parse(args.params['index']))),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
