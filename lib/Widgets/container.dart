import 'package:Alarm/Const/const.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

class ContainerAd extends StatefulWidget {
  final provider;
  final loop;

  const ContainerAd({Key key, this.provider, this.loop}) : super(key: key);
  _ContainerAdState createState() => _ContainerAdState();
}

class _ContainerAdState extends State<ContainerAd> {
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
    // interstitialAd.load();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          if (widget.loop.isLocked) {
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
            widget.provider.setMusic(widget.loop);
            Navigator.pop(context);
          } else {
            widget.provider.setMusic(widget.loop);
            Navigator.pop(context);
          }
        },
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              'https://firebasestorage.googleapis.com/v0/b/alarm-20d95.appspot.com/o/Music%20Files%2FImages%2Floop-logo-vector-ribbon-lettering-260nw-1425991553.png?alt=media&token=cea4277c-a615-4b10-8fa6-90bbd32beaa6'),
                          fit: BoxFit.contain),
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
                      Colors.white54,
                      // Colors.white10,
                      Colors.black26,
                      Colors.black54
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
          ],
        ),
      ),
    );
  }
}
