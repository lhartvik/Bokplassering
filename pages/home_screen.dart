import 'package:flutter/material.dart';

import '../components/grid_view_widget.dart';
import '../models/deichman_bok.dart';
import '../network/network.dart';

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
      List<DeichmanBok> books = await network.searchDeichmanBooks(query);
      setState(() {
        _books = books;
      });
    } catch (e) {
      // Vi ignorerer
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
            GridViewWidget(books: _books),
          ],
        ),
      ),
    );
  }
}
