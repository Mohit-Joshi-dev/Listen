import 'package:Alarm/Const/const.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

class GridViews extends StatefulWidget {
  final musics;
  final provider;

  const GridViews({
    Key key,
    this.musics,
    this.provider,
  }) : super(key: key);

  @override
  _GridViewsState createState() => _GridViewsState();
}

class _GridViewsState extends State<GridViews> {
  int coins = 0;
  RewardedVideoAd videoAd = RewardedVideoAd.instance;
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
      testDevices: ['testDevices'],
      childDirected: false,
      keywords: ['Books', 'Games']);

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
    RewardedVideoAd.instance.listener =
        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
      if (event == RewardedVideoAdEvent.rewarded) {
        setState(() {
          // Here, apps should update state to reflect the reward.
          coins += rewardAmount;
        });
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 1),
        itemCount: widget.musics?.length,
        // 2,
        itemBuilder: (context, i) {
          var music = widget.musics[i];
          if (music.image != null) {}
          return GestureDetector(
            onTap: () async {
              // provider.setMusic(music);
              // Navigator.pop(context);
              await videoAd.load(
                  adUnitId: RewardedVideoAd.testAdUnitId,
                  targetingInfo: targetingInfo);
              videoAd.show();
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
                                music.image ??
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
                      music.name,
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
        });
  }
}
