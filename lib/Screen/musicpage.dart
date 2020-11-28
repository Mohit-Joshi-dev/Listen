import 'package:Alarm/Const/const.dart';
import 'package:Alarm/Screen/screens.dart';
import 'package:Alarm/Widgets/offline.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PageOne extends StatefulWidget {
  @override
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;
  double _height;

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
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    show();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: ConnectivityWidgetWrapper(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, 50 * (1 - _animation.value)),
              child: Opacity(
                opacity: _animation.value,
                child: buildColumn(),
              ),
            );
          },
        ),
        disableInteraction: true,
        offlineWidget: OfflineWidget(),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      children: [
        SizedBox(
          height: _height / 6,
        ),
        Container(
            child: Column(
          children: [
            Center(
              child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(
                        text: 'READY TO \n',
                        style: TextStyle(
                            fontSize: 35,
                            fontFamily: 'Mon',
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w100)),
                    TextSpan(
                        text: 'SLEEP ?',
                        style: GoogleFonts.montserrat(
                            fontSize: 45,
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w700)),
                  ])),
            ),
          ],
        )),
        SizedBox(
          height: _height / 4,
        ),
        Center(
          child: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => SecondMusic()));
            },
            child: Container(
                width: 100,
                height: 50,
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 25,
                          color: Colors.black54,
                          offset: Offset(5, 5))
                    ]),
                child: Center(
                  child: Text(
                    'YES',
                    style: TextStyle(
                        color: kBackgroundColor,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Mon',
                        fontSize: 15),
                  ),
                )),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text('I\'m ready to sleep ',
            style: TextStyle(color: kPrimaryColor, fontFamily: 'Mon')),
      ],
    );
  }
}
