import 'package:flutter/material.dart';

import '../db/database_helper.dart';
import '../models/deichman_bok.dart';

class DeichmanScreen extends StatefulWidget {
  const DeichmanScreen({super.key});

  @override
  State<DeichmanScreen> createState() => _DeichmanScreenState();
}

class _DeichmanScreenState extends State<DeichmanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<DeichmanBok>>(
          future: DatabaseHelper.instance.readAllBooks(),
          builder: (context, snapshot) => snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    DeichmanBok book = snapshot.data![index];
                    return ListTile(
                      title: Text(book.title),
                      subtitle: book.author.isNotEmpty
                          ? Text(book.author.first)
                          : const Text("Ingen forfatter"),
                      trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            DatabaseHelper.instance.deleteBook(book.recordId);
                            setState(() {});
                          }),
                      leading: book.imageLink != ''
                          ? Image.network(
                              "https://deichman.no/api/images/resize/32${book.imageLink}")
                          : const Icon(Icons.book),
                    );
                  })
              : const CircularProgressIndicator()),
    );
  }
}
