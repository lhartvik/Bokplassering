import 'package:bokplasseringer/models/deichman_bok.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Network {
  static const String _deichmanUrl = 'https://deichman.no/api/search';
  static const String _ciceroUrl = 'https://deichman.no/api/cicero/open/copies';

  Future<List<DeichmanBok>> searchDeichmanBooks(String query) async {
    var url = Uri.parse('$_deichmanUrl?query=$query');
    print("searchDeichmanBooks $query - $url");
    var response = await http.get(url);

    print("Statuskode: ${response.statusCode}");

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['hits'] != null && data['hits'] is List) {
        List<DeichmanBok> books = (data['hits'] as List<dynamic>)
            .map((book) => DeichmanBok.fromJson(book as Map<String, dynamic>))
            .toList();
        return books;
      } else {
        return [];
      }
    } else {
      throw Exception("Failed to load books from Deichman");
    }
  }
}
