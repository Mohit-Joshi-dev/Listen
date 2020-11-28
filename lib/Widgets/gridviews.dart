import 'package:Alarm/Models/music.dart';
import 'package:Alarm/Widgets/musicContainer.dart';
import 'package:flutter/material.dart';

class GridViews extends StatefulWidget {
  final List<Music> musics;

  const GridViews({
    Key key,
    this.musics,
  }) : super(key: key);

  @override
  _GridViewsState createState() => _GridViewsState();
}

class _GridViewsState extends State<GridViews> {
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
          return MusicContainer(
            music: music,
          );
        });
  }
}
