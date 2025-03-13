import 'package:flutter/material.dart';

import '../models/book_details_arguments.dart';
import '../models/deichman_bok.dart';

class GridViewWidget extends StatelessWidget {
  const GridViewWidget({
    super.key,
    required List<DeichmanBok> books,
  }) : _books = books;

  final List<DeichmanBok> _books;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
          itemCount: _books.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 0.6),
          itemBuilder: (context, index) {
            DeichmanBok book = _books[index];
            return Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHigh,
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/details',
                      arguments: BookDetailsArguments(book: book));
                },
                child: Column(
                  children: [
                    Text(book.mediaType,
                        style: Theme.of(context).textTheme.bodySmall),
                    Padding(
                      padding: const EdgeInsets.all(18),
                      child: (book.imageLink != '')
                          ? Image.network(
                              "https://deichman.no/api/images/resize/100${book.imageLink}")
                          : const Text("Fant ikke bilde"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(book.title,
                          style: Theme.of(context).textTheme.bodyMedium,
                          overflow: TextOverflow.ellipsis),
                    ),
                    Text(
                      book.author.isNotEmpty
                          ? book.author.first
                          : "(ingen forfatter)",
                      style: Theme.of(context).textTheme.titleSmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (book.status == "Utlånt") const Text("Utlånt nå"),
                  ],
                ),
              ),
            );
          }),
      // child: SizedBox(
      //   width: double.infinity,
      //   child: ListView.builder(
      //       itemCount: _books.length,
      //       itemBuilder: (context, index) {
      //         DeichmanBok book = _books[index];
      //         return ListTile(
      //             subtitle: Text(book.author.first),
      //             title: Text(book.title));
      //       }),
    );
  }
}
