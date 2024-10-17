import 'dart:ffi';

class DeichmanBok {
  final String id;
  final String recordId;
  final String title;
  final List<String> author;
  final List<String> publishedBy;
  final int publishedYear;
  final Map<String, String> imageLinks;

  DeichmanBok(
      {required this.id,
      required this.recordId,
      required this.title,
      required this.author,
      required this.publishedBy,
      required this.publishedYear,
      required this.imageLinks});

  factory DeichmanBok.fromJson(Map<String, dynamic> json) {
    var bok = DeichmanBok(
        id: json['id'],
        recordId: json['recordId'],
        title: json['fullTitle'],
        author: (json['author'] as List<dynamic>? ?? [])
            .map((author) => author.toString())
            .toList(),
        publishedBy: (json['publishedBy'] as List<dynamic>? ?? [])
            .map((publisher) => publisher.toString())
            .toList(),
        publishedYear: json['publicationYear'] ?? 0,
        imageLinks: (json['images'] as Map<String, dynamic>? ?? {})
            .map((key, value) => MapEntry(key, value.toString())));

    return bok;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'recordId': recordId,
      'fullTitle': title,
      'author': author,
      'publishedBy': publishedBy,
      'publishedYear': publishedYear,
      'images': imageLinks,
    };
  }

  factory DeichmanBok.fromJsonDatabase(Map<String, dynamic> jsonObject) {
    return DeichmanBok(
        id: jsonObject['id'] as String,
        recordId: jsonObject['recordId'] as String,
        title: jsonObject['fullTitle'] as String,
        author: jsonObject['author'] as List<String>,
        publishedBy: jsonObject['publishedBy'] as List<String>,
        publishedYear: jsonObject['publishedYear'] as int,
        imageLinks: jsonObject['images'] as Map<String, String>);
  }

  @override
  String toString() {
    // TODO: implement toString
    return title;
  }
}
