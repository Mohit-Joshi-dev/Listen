import 'package:Alarm/Widgets/container.dart';
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
  bool isLocked;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          return ContainerAd(provider: widget.provider, loop: loop);
        });
  }
}
