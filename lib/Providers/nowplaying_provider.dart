import 'package:flutter/material.dart';

class NowPlayingProvider with ChangeNotifier {
  String _name, _url;

  // Getters
  String get name => _name;
  String get url => _url;

  //Setters
  void setMusic(dynamic music) {
    _name = music.name;
    _url = music.url;
    notifyListeners();
  }
}
