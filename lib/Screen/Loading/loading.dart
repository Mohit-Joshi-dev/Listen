import 'dart:async';

import 'package:Alarm/Const/const.dart';
import 'package:Alarm/Screen/musicpage.dart';
import 'package:Alarm/Widgets/animations.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 5500), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => PageOne()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgroundColor,
        body: Stack(
          children: [
            Container(
                child: FlareActor('assets/animations/Moon.flr',
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    animation: 'go'),
                width: double.infinity,
                height: 400),
            Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Night(
                      child: Text('Night ',
                          style: GoogleFonts.newRocker(
                              fontSize: 30, color: Colors.white)),
                      value: 30),
                  Night(
                      child: Text('Time',
                          style: GoogleFonts.newRocker(
                              fontSize: 30, color: Colors.white)),
                      value: -30),
                ],
              ),
              SizedBox(height: 50),
              // Container(
              //   height: 100,
              //   child: FlareActor(
              //     'assets/animations/pikomit_flr_circle-load.flr',
              //     alignment: Alignment.center,
              //     animation: 'pikomit_flr_circle-load',
              //   ),
              // )
            ]),
          ],
        ));
  }
}
