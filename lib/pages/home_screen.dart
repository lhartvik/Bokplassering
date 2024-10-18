import 'package:bokplasseringer/network/network.dart';
import 'package:bokplasseringer/pages/book_details_screen.dart';
import 'package:flutter/material.dart';

import '../models/book_details_arguments.dart';
import '../models/deichman_bok.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Network network = Network();
  List<DeichmanBok> _books = [];
  Future<void> _searchBooks(String query) async {
    try {
      print("_searchBooks: $query");
      List<DeichmanBok> books = await network.searchDeichmanBooks(query);
      setState(() {
        _books = books;
      });
    } catch (e) {
      print("Error");
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                  hintText: 'Søk på tittel eller id',
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  )),
              onSubmitted: (query) => _searchBooks(query),
            ),
            Expanded(
              child: GridView.builder(
                  itemCount: _books.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 0.6),
                  itemBuilder: (context, index) {
                    DeichmanBok book = _books[index];
                    return Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .surfaceContainerHigh,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/details',
                              arguments: BookDetailsArguments(book: book));
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) =>
                          //             const BooksDetailsScreen()));
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
                            Text(book.title,
                                style: Theme.of(context).textTheme.bodyMedium,
                                overflow: TextOverflow.ellipsis),
                            Text(
                              book.author.length > 0
                                  ? book.author.first
                                  : "(ingen forfatter)",
                              style: Theme.of(context).textTheme.titleSmall,
                              overflow: TextOverflow.ellipsis,
                            )
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
            ),
          ],
        ),
      ),
    );
  }
}
