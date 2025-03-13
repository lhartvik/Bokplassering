import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/cicero_bok.dart';
import '../models/deichman_bok.dart';

class Network {
  static const String _deichmanUrl = 'https://deichman.no/api/search';
  static const String _ciceroUrl = 'https://deichman.no/api/cicero/open/copies';

  Future<List<DeichmanBok>> searchDeichmanBooks(String query) async {
    var url = Uri.parse('$_deichmanUrl?query=$query');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['hits'] != null && data['hits'] is List) {
        List<DeichmanBok> books = (data['hits'] as List<dynamic>)
            .map((book) => DeichmanBok.fromJson(book as Map<String, dynamic>))
            .toList();

        List<Cicerobok> plasseringer = await searchPlasseringer(books).then(
            (plasseringer) => plasseringer
                .where((plassering) => plassering.branchcode == 'bjor')
                .toList());

        return books
            .where((book) => plasseringer
                .any((plassering) => plassering.recordId == book.recordId))
            .map((book) {
          List<String> statuser = plasseringer
              .where((plassering) => plassering.recordId == book.recordId)
              .map((plassering) => plassering.status)
              .toList();
          if (statuser.any((status) => status != "Utlånt")) {
            book.status = "Inne";
          } else {
            book.status = plasseringer
                .firstWhere(
                    (plassering) => plassering.recordId == book.recordId)
                .status;
          }
          return book;
        }).toList();
      } else {
        return [];
      }
    } else {
      throw Exception("Failed to load books from Deichman");
    }
  }

  static Future<List<Cicerobok>> searchPlasseringer(
      List<DeichmanBok> books) async {
    var recordIds = books.map((bok) => bok.recordId).join(',');

    var url = Uri.parse('$_ciceroUrl?id=$recordIds');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<Cicerobok> plasseringer = [];

      var data = jsonDecode(response.body);
      data.forEach((key, value) {
        for (var item in value['items']) {
          var deichmanbok = books.singleWhere((book) => book.recordId == key);

          plasseringer.add(Cicerobok(
              recordId: key,
              title: deichmanbok.title,
              locLabel: item['locLabel'] ?? '',
              locRaw: item['locRaw'] ?? '',
              available: item['available'] ?? 0,
              branchcode: item['branchcode'],
              status: item['status']));
        }
      });
      return plasseringer;
    } else {
      throw Exception("Kunne ikke hente data fra Cicero");
    }
  }
}
