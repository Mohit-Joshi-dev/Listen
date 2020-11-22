import 'dart:async';

import 'package:Alarm/Const/const.dart';
import 'package:Alarm/Models/loops.dart';
import 'package:Alarm/Models/music.dart';
import 'package:Alarm/Providers/nowplaying_provider.dart';
import 'package:Alarm/Widgets/gridviews.dart';
import 'package:Alarm/Widgets/loopsgrid.dart';
import 'package:Alarm/Widgets/offline.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

class SecondMusic extends StatefulWidget {
  @override
  _SecondMusicState createState() => _SecondMusicState();
}

class _SecondMusicState extends State<SecondMusic>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;
  AnimationController _controller;
  // ignore: unused_field
  double _height;
  AudioPlayer player;
  // bool isPlaying = false;
  Duration duration;

  void show() {
    _animationController.forward();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    show();
    player = AudioPlayer();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
    player.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    var musics = Provider.of<List<Music>>(context);
    var loops = Provider.of<List<Loops>>(context);
    var provider = Provider.of<NowPlayingProvider>(context);

    if (provider.url != null) {
      player.setUrl(provider.url);
      player.setLoopMode(LoopMode.one);
      Timer(Duration(hours: 1), () {
        player.stop();
        _controller.reverse();
        print('Player Stoped');
      });
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        backgroundColor: kBackgroundColor,
        body: ConnectivityWidgetWrapper(
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, 50 * (1 - _animation.value)),
                child: Opacity(
                  opacity: _animation.value,
                  child: buildColumn(_height, context, _width, provider.name,
                      provider.url, musics, provider, loops),
                ),
              );
            },
          ),
          disableInteraction: true,
          offlineWidget: OfflineWidget(),
        ));
  }

  Stack buildColumn(
      double _height,
      BuildContext context,
      double _width,
      String name,
      String url,
      List<Music> musics,
      dynamic provider,
      List<Loops> loops) {
    return Stack(children: [
      Column(children: [
        SizedBox(
          height: _height / 15,
        ),
        Center(
          child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                TextSpan(
                    text: 'I\'M READY TO \n',
                    style: GoogleFonts.montserrat(
                        fontSize: 28,
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w200)),
                TextSpan(
                    text: 'SLEEP ',
                    style: GoogleFonts.montserrat(
                        fontSize: 53,
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w700)),
              ])),
        ),
        SizedBox(height: _height / 12),
        GestureDetector(
            onTap: () {
              onMusicButtonTap(context, musics, provider);
            },
            child: buildButton('MUSIC')),
        SizedBox(height: _height / 12),
        GestureDetector(
          onTap: () {
            onLoopsbuttonTap(context, loops, provider);
          },
          child: buildButton('LOOPS'),
        ),
      ]),
      Positioned(
        child: name != null ? buildNowplaying(_width, name) : Container(),
        bottom: 0,
      )
    ]);
  }

  onMusicButtonTap(
      BuildContext context, List<Music> musics, dynamic provider) async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            // height: 400,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            ),
            child: Column(
              children: [
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: IconButton(
                          icon: Icon(Icons.close),
                          iconSize: 28,
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    )
                  ],
                ),
                Expanded(
                    child: musics == null
                        ? Center(child: CircularProgressIndicator())
                        : GridViews(musics: musics, provider: provider)),
              ],
            ),
          );
        },
        enableDrag: true,
        backgroundColor: Colors.transparent,
        isScrollControlled: true);
  }

  onLoopsbuttonTap(
      BuildContext context, List<Loops> loops, dynamic provider) async {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            // height: 400,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            ),
            child: Column(
              children: [
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: IconButton(
                          icon: Icon(Icons.close),
                          iconSize: 28,
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    )
                  ],
                ),
                Expanded(
                    child: loops == null
                        ? Center(child: CircularProgressIndicator())
                        : GridViewsLoops(loops: loops, provider: provider)),
              ],
            ),
          );
        },
        enableDrag: true,
        backgroundColor: Colors.transparent,
        isScrollControlled: true);
  }

  Container buildNowplaying(double _width, String name) {
    return Container(
        width: _width,
        height: 70,
        decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            boxShadow: [
              BoxShadow(
                  blurRadius: 25, color: Colors.black54, offset: Offset(5, 5))
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                name,
                style: TextStyle(
                    color: kBackgroundColor,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Mon',
                    fontSize: 15),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(right: 10),
                child: GestureDetector(
                  child: Container(
                    height: 50,
                    width: 50,
                    child: Center(
                      child: AnimatedIcon(
                        icon: AnimatedIcons.play_pause,
                        progress: _controller,
                      ),
                    ),
                  ),
                  onTap: () {
                    if (player.playing) {
                      player.pause();
                      _controller.reverse();
                    } else {
                      player.play();
                      _controller.forward();
                    }
                  },
                ))
          ],
        ));
  }

  Container buildButton(String text) {
    return Container(
        width: 150,
        height: 50,
        decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                  blurRadius: 25, color: Colors.black54, offset: Offset(5, 5))
            ]),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: kBackgroundColor,
                fontWeight: FontWeight.w600,
                fontFamily: 'Mon',
                fontSize: 15),
          ),
        ));
  }

  ListTile listTile(String text, Function ontap) {
    return ListTile(
        title: Text(text,
            style: TextStyle(
                color: kBackgroundColor,
                fontWeight: FontWeight.bold,
                fontFamily: 'Mon',
                fontSize: 15)),
        contentPadding: EdgeInsets.symmetric(horizontal: 25),
        onTap: ontap);
  }
}
