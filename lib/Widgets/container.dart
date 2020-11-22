import 'package:Alarm/Const/const.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

class ContainerAd extends StatefulWidget {
  final provider;
  final loop;

  const ContainerAd({Key key, this.provider, this.loop}) : super(key: key);
  @override
  _ContainerAdState createState() => _ContainerAdState();
}

class _ContainerAdState extends State<ContainerAd> {
  int coins;
  RewardedVideoAd videoAd = RewardedVideoAd.instance;
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
      testDevices: ['testDevices'],
      childDirected: false,
      keywords: ['Books', 'Games']);

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
    videoAd.load(
        adUnitId: RewardedVideoAd.testAdUnitId, targetingInfo: targetingInfo);
  }

  @override
  Widget build(BuildContext context) {
    print('Coinsssssssssss === $coins');
    return Container(
      child: GestureDetector(
        onTap: () {
          try {
            if (coins == null) {
              videoAd.show();
              RewardedVideoAd.instance.listener = (RewardedVideoAdEvent event,
                  {String rewardType, int rewardAmount}) {
                if (event == RewardedVideoAdEvent.rewarded) {
                  setState(() {
                    // Here, apps should update state to reflect the reward.
                    coins = 10;
                  });
                }
              };
            } else {
              widget.provider.setMusic(widget.loop);
              Navigator.pop(context);
            }
          } catch (e) {
            print('Errorrrrrrrrrrrrrrrrrrrrr $e');
          }
        },
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
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
                      Colors.white10,
                      Colors.black12,
                      Colors.black45
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
                  widget.loop.name,
                  // 'Name',
                  style: TextStyle(
                      color: kBackgroundColor,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Mon',
                      fontSize: 15),
                )),
            coins == null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black38,
                          backgroundBlendMode: BlendMode.darken,
                          borderRadius: BorderRadius.circular(24)),
                      child: Center(
                        child: Icon(Icons.lock),
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
