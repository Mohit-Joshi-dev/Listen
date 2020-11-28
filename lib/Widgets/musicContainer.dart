import 'package:Alarm/Const/const.dart';
import 'package:Alarm/Models/music.dart';
import 'package:Alarm/Providers/nowplaying_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MusicContainer extends StatefulWidget {
  const MusicContainer({
    Key key,
    @required this.music,
  }) : super(key: key);

  final Music music;

  @override
  _MusicContainerState createState() => _MusicContainerState();
}

class _MusicContainerState extends State<MusicContainer> {
  InterstitialAd interstitialAd = InterstitialAd(
    adUnitId: 'ca-app-pub-8300119033769700/3227436599',
    targetingInfo: targetingInfo,
    listener: (MobileAdEvent event) {
      print("InterstitialAd event is $event");
    },
  );
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
      testDevices: ['testDevices'],
      childDirected: false,
      keywords: ['Books', 'Games']);

  @override
  void initState() {
    super.initState();
    // FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
    // interstitialAd.load();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<NowPlayingProvider>(context);
    return GestureDetector(
      onTap: () {
        if (widget.music.isLocked) {
          try {
            interstitialAd
              ..load()
              ..show(
                  anchorType: AnchorType.bottom,
                  anchorOffset: 0.0,
                  horizontalCenterOffset: 0.0);
          } catch (e) {
            print('Errorrrrrrrrrrrrrrrrrrrrr $e');
          }
          provider.setMusic(widget.music);
          Navigator.pop(context);
        } else {
          provider.setMusic(widget.music);
          Navigator.pop(context);
        }
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(
                          widget.music.image ??
                              "https://media.tarkett-image.com/large/TH_24567081_24594081_24596081_24601081_24563081_24565081_24588081_001.jpg",
                        ),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                  BoxShadow(
                      blurRadius: 30,
                      color: Colors.black26,
                      offset: Offset(5, 15))
                ])),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white60,
                    Colors.white24,
                    Colors.transparent,
                    Colors.transparent
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),
          Positioned(
              bottom: 18,
              left: 18,
              child: Text(
                widget.music.name,
                // 'Name',
                style: TextStyle(
                    color: kBackgroundColor,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Mon',
                    fontSize: 15),
              ))
        ],
      ),
    );
  }
}
