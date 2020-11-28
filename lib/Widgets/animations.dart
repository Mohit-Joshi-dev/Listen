import 'dart:async';

import 'package:flutter/material.dart';

class Night extends StatefulWidget {
  final Widget child;
  final double value;

  const Night({
    Key key,
    this.child,
    this.value,
  }) : super(key: key);
  @override
  _NightState createState() => _NightState();
}

class _NightState extends State<Night> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;
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
    Timer(Duration(milliseconds: 4000), () {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, widget.value * (1 - _animation.value)),
            child: Opacity(
              opacity: _animation.value,
              child: widget.child,
            ),
          );
        },
      ),
    );
  }
}
