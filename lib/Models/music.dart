class Music {
  final String name;
  final String url;
  final String image;

  Music({this.name, this.url, this.image});

  Music.fromJson(Map<String, dynamic> parsedJson)
      : name = parsedJson['song_name'],
        url = parsedJson['song_url'],
        image = parsedJson['image'];
}
