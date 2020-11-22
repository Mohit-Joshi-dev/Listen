class Loops {
  final String name;
  final String url;
  final bool isLocked;

  Loops({
    this.name,
    this.url,
    this.isLocked,
  });

  Loops.fromJson(Map<String, dynamic> parsedJson)
      : name = parsedJson['name'],
        url = parsedJson['url'],
        isLocked = parsedJson['locked'];
}
