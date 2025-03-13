import 'dart:convert';

class DeichmanBok {
  final String id;
  final String recordId;
  final String title;
  final String mediaType;
  final List<String> author;
  final int publishedYear;
  final String imageLink;
  final String plot;
  String status = "";

  DeichmanBok(
      {required this.id,
      required this.recordId,
      required this.title,
      required this.mediaType,
      required this.author,
      required this.publishedYear,
      required this.imageLink,
      required this.plot});

  factory DeichmanBok.fromJson(Map<String, dynamic> json) {
    var bok = DeichmanBok(
        id: json['id'],
        recordId: json['recordId'],
        title: json['fullTitle'],
        mediaType: json['mediaType'] ?? '',
        author: (json['author'] as List<dynamic>? ?? [])
            .map((author) => author.toString())
            .toList(),
        publishedYear: json['publicationYear'] ?? 0,
        imageLink: json['coverImage'] ?? '',
        plot: json['various']?[0] ?? '');
    return bok;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'recordId': recordId,
      'title': title,
      'mediaType': mediaType,
      'author': json.encode(author),
      'publishedYear': publishedYear,
      'coverImage': imageLink,
      'plot': plot
    };
  }

  factory DeichmanBok.fromJsonDatabase(Map<String, dynamic> jsonObject) {
    return DeichmanBok(
        id: jsonObject['id'] as String,
        recordId: jsonObject['recordId'] as String,
        title: jsonObject['title'] as String,
        mediaType: jsonObject['mediaType'] as String,
        author: jsonObject['author'] is String
            ? (json.decode(jsonObject['author']) as List)
                .map((e) => e as String)
                .toList()
            : [],
        publishedYear: jsonObject['publishedYear'] as int,
        imageLink: jsonObject['coverImage'] as String,
        plot: jsonObject['plot'] as String);
  }

  @override
  String toString() {
    return "$mediaType, $title av ${author.isNotEmpty ? author.first : "(mangler forfatter)"}, image: $imageLink";
  }
}
