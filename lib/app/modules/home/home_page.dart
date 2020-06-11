import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';
import 'package:music_player/app/app_controller.dart';
import 'package:music_player/app/consts/app_const.dart';
import 'package:music_player/app/widgets/all_musics.dart';
import 'package:music_player/app/widgets/all_playLists.dart';
import 'package:music_player/app/widgets/bottom_detail.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final controller = Modular.get<AppController>();

  TabController _tabController;

  int _currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Music Player")),
        bottom: TabBar(
          onTap: (value) {
            setState(() {
              _currentIndex = value;
            });
          },
          labelStyle: TextStyle(
              //up to your taste
              fontWeight: FontWeight.w700),
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.label, //makes it better
          labelColor: Colors.white, //Google's sweet blue
          unselectedLabelColor: Colors.white, //niceish grey
          isScrollable: true, //up to your taste
          indicator: MD2Indicator(
              //it begins here
              indicatorHeight: 3,
              indicatorColor: Colors.white,
              indicatorSize:
                  MD2IndicatorSize.full //3 different modes tiny-normal-full
              ),
          tabs: <Widget>[
            Tab(
              text: "Playlists",
            ),
            Tab(
              text: "Músicas",
            )
          ],
        ),
      ),
      bottomSheet: BottomDetail(),
      backgroundColor: Color(0xffD7DBDD),
      body: Observer(
        builder: (_) {
          if (controller.musicList.value == null) {
            return Center(child: CircularProgressIndicator());
          }
          if (_currentIndex == 0) {
            return AllPlaylists();
          }

          return AllMusics();
        },
      ),
    );
  }
}
