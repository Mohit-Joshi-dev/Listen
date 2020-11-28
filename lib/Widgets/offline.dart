import 'package:Alarm/Const/const.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class OfflineWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
        child: Stack(
          children: [
            Center(
                child: Container(
              height: _height / 2,
              width: _width / 1.1,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      height: _height / 5,
                      child: FlareActor('assets/animations/NoNetwork.flr',
                          animation: 'no_netwrok',
                          alignment: Alignment.center)),
                  SizedBox(height: 20),
                  Text(
                    'Ooops ! ',
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Slow or no internet connection. \n Please check your internet settings.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'Mon'),
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
