import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';

import '../db/database_helper.dart';
import '../models/book_details_arguments.dart';
import '../models/deichman_bok.dart';

class BookDetailsScreen extends StatefulWidget {
  const BookDetailsScreen({super.key});

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final args =
        ModalRoute.of(context)?.settings.arguments as BookDetailsArguments;
    DeichmanBok book = args.book;

    return Scaffold(
      appBar: AppBar(title: Text(book.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (book.imageLink != '')
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Image.network(
                  "https://deichman.no/api/images/resize/250${book.imageLink}",
                  fit: BoxFit.cover,
                ),
              ),
            Center(
              child: Column(
                children: [
                  Text(book.title, style: theme.textTheme.headlineSmall),
                  Text(
                      book.author.isNotEmpty
                          ? book.author.first
                          : "Forfatter er ikke oppgitt",
                      style: theme.textTheme.bodyMedium),
                  Text("Utgivelsesår: ${book.publishedYear}",
                      style: theme.textTheme.bodySmall),
                  Text("Record ID: ${book.recordId}",
                      style: theme.textTheme.bodyMedium),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            try {
                              int savedInt =
                                  await DatabaseHelper.instance.insert(book);
                              SnackBar snackBar = SnackBar(
                                  content: Text("Lagret bok $savedInt"));
                              if (context.mounted) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            } catch (e) {
                              // Hvis det er DatabaseException(UNIQUE constraint failed: books.id
                              // Så er det bare fint, det betyr at bok med samme id finnes allerede..
                              // Kan evt vise en melding om det
                              if (e is DatabaseException &&
                                  e.isUniqueConstraintError()) {
                                SnackBar snackBar = const SnackBar(
                                    content: Text("Boken er allerede lagret"));
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              }
                            }
                          },
                          child: const Text('Lagre')),
                      // ElevatedButton.icon(
                      //     onPressed: () async {
                      //       try {
                      //         await DatabaseHelper.instance
                      //             .readAllBooks()
                      //             .then((books) => {
                      //                   for (var book in books) {print(book)}
                      //                 });
                      //       } catch (e) {
                      //         print("Error: $e");
                      //       }
                      //     },
                      //     icon: const Icon(Icons.shelves),
                      //     label: const Text('Plassering')),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                    width: double.infinity,
                  ),
                  Text("Beskrivelse", style: theme.textTheme.titleMedium),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: theme.colorScheme.secondary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: theme.colorScheme.secondary)),
                    child: Text(book.plot),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
