import 'package:bokplasseringer/models/book_details_arguments.dart';
import 'package:bokplasseringer/models/deichman_bok.dart';
import 'package:flutter/material.dart';

class BookDetailsScreen extends StatefulWidget {
  const BookDetailsScreen({super.key});

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as BookDetailsArguments;
    DeichmanBok book = args.book;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title)
        ),
    );
  }
}
