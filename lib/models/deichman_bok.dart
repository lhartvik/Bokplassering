class DeichmanBok {
  final String id;
  final String recordId;
  final String title;
  final String mediaType;
  final List<String> author;
  final int publishedYear;
  final String imageLink;

  DeichmanBok(
      {required this.id,
      required this.recordId,
      required this.title,
      required this.mediaType,
      required this.author,
      required this.publishedYear,
      required this.imageLink});

  factory DeichmanBok.fromJson(Map<String, dynamic> json) {
    print("serialiserer ${json['recordId']}");
    var bok = DeichmanBok(
        id: json['id'],
        recordId: json['recordId'],
        title: json['fullTitle'],
        mediaType: json['mediaType'] ?? '',
        author: (json['author'] as List<dynamic>? ?? [])
            .map((author) => author.toString())
            .toList(),
        publishedYear: json['publicationYear'] ?? 0,
        imageLink: json['coverImage'] ?? '');
    print(bok);
    return bok;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'recordId': recordId,
      'fullTitle': title,
      'mediaType': mediaType,
      'author': author,
      'publishedYear': publishedYear,
      'coverImage': imageLink,
    };
  }

  factory DeichmanBok.fromJsonDatabase(Map<String, dynamic> jsonObject) {
    return DeichmanBok(
        id: jsonObject['id'] as String,
        recordId: jsonObject['recordId'] as String,
        title: jsonObject['fullTitle'] as String,
        mediaType: jsonObject['mediaType'] as String,
        author: jsonObject['author'] as List<String>,
        publishedYear: jsonObject['publishedYear'] as int,
        imageLink: jsonObject['coverImage'] as String);
  }

  @override
  String toString() {
    return "$mediaType, $title av ${author.length > 0 ? author.first : "(mangler forfatter)"}, image: $imageLink";
  }
}
