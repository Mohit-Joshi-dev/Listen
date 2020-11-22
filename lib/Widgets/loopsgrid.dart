import 'package:Alarm/Const/const.dart';
import 'package:Alarm/Widgets/container.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

class GridViewsLoops extends StatefulWidget {
  final loops;
  final provider;

  const GridViewsLoops({
    Key key,
    this.loops,
    this.provider,
  }) : super(key: key);

  @override
  _GridViewsLoopsState createState() => _GridViewsLoopsState();
}

class _GridViewsLoopsState extends State<GridViewsLoops> {
  // RewardedVideoAd videoAd = RewardedVideoAd.instance;
  // static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  //     testDevices: ['testDevices'],
  //     childDirected: false,
  //     keywords: ['Books', 'Games']);

  bool isLocked;
  @override
  void initState() {
    super.initState();
    // FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
    // videoAd.load(
    //     adUnitId: RewardedVideoAd.testAdUnitId, targetingInfo: targetingInfo);
  }

  @override
  Widget build(BuildContext context) {
    print('BuildContext $isLocked');
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 1),
        itemCount: widget.loops?.length,
        // 2,
        itemBuilder: (context, i) {
          var loop = widget.loops[i];
          isLocked = loop.isLocked;

          print(isLocked);
          return isLocked
              ? ContainerAd(provider: widget.provider, loop: loop)
              : buildGestureDetector(loop);
        });
  }

  Container buildGestureDetector(loop) {
    return Container(
      child: GestureDetector(
        onTap: () {
          widget.provider.setMusic(loop);
          Navigator.pop(context);
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
                  loop.name,
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

  Container buildConatiner(loop, bool isLock) {
    return isLock
        ? ContainerAd(
            provider: widget.provider,
            loop: widget.loops,
          )
        // ? Container(
        //     child: GestureDetector(
        //       onTap: () {
        //         try {
        //           if (coins == null) {
        //             videoAd.show();
        //             RewardedVideoAd.instance.listener =
        //                 (RewardedVideoAdEvent event,
        //                     {String rewardType, int rewardAmount}) {
        //               if (event == RewardedVideoAdEvent.rewarded) {
        //                 setState(() {
        //                   // Here, apps should update state to reflect the reward.
        //                   coins += rewardAmount;
        //                 });
        //                 print(coins);
        //               }
        //             };
        //           } else {
        //             widget.provider.setMusic(loop);
        //             Navigator.pop(context);
        //           }
        //         } catch (e) {
        //           print('Errorrrrrrrrrrrrrrrrrrrrr $e');
        //         }
        //       },
        //       child: Stack(
        //         children: [
        //           Padding(
        //             padding: const EdgeInsets.all(8.0),
        //             child: Container(
        //                 decoration: BoxDecoration(
        //                     color: kPrimaryColor,
        //                     borderRadius: BorderRadius.circular(24),
        //                     boxShadow: [
        //                   BoxShadow(
        //                       blurRadius: 30,
        //                       color: Colors.black26,
        //                       offset: Offset(5, 15))
        //                 ])),
        //           ),
        //           Padding(
        //             padding: const EdgeInsets.all(8.0),
        //             child: Container(
        //               decoration: BoxDecoration(
        //                 gradient: LinearGradient(
        //                   colors: [
        //                     Colors.white60,
        //                     Colors.white10,
        //                     Colors.black12,
        //                     Colors.black45
        //                   ],
        //                   begin: Alignment.bottomCenter,
        //                   end: Alignment.topCenter,
        //                 ),
        //                 borderRadius: BorderRadius.circular(24),
        //               ),
        //             ),
        //           ),
        //           Positioned(
        //               bottom: 18,
        //               left: 18,
        //               child: Text(
        //                 loop.name,
        //                 // 'Name',
        //                 style: TextStyle(
        //                     color: kBackgroundColor,
        //                     fontWeight: FontWeight.w600,
        //                     fontFamily: 'Mon',
        //                     fontSize: 15),
        //               )),
        //           coins == null
        //               ? Padding(
        //                   padding: const EdgeInsets.all(8.0),
        //                   child: Container(
        //                     decoration: BoxDecoration(
        //                         color: Colors.black38,
        //                         backgroundBlendMode: BlendMode.darken,
        //                         borderRadius: BorderRadius.circular(24)),
        //                     child: Center(
        //                       child: Icon(Icons.lock),
        //                     ),
        //                   ),
        //                 )
        //               : Container()
        //         ],
        //       ),
        //     ),
        //   )
        : Container();
  }
}
