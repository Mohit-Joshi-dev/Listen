class Music {
  final String name;
  final String url;
  final bool isLocked;
  final String image;

  Music({
    this.name,
    this.url,
    this.isLocked,
    this.image,
  });

  Music.fromJson(Map<String, dynamic> parsedJson)
      : name = parsedJson['song_name'],
        url = parsedJson['song_url'],
        image = parsedJson['image'],
        isLocked = parsedJson['locked'];
}
