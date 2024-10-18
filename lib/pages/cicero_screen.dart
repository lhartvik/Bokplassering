import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import '../db/database_helper.dart';
import '../models/cicero_bok.dart';
import '../network/network.dart';

class CiceroScreen extends StatefulWidget {
  const CiceroScreen({super.key});

  @override
  State<CiceroScreen> createState() => _CiceroScreenState();
}

class _CiceroScreenState extends State<CiceroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Plassering av bøkene(kun Bjørvika)')),
        body: FutureBuilder<List<Cicerobok>>(
            future: DatabaseHelper.instance
                .readAllBooks()
                .then((books) => Network.searchPlasseringer(books))
                .then((cicerobooks) =>
                    groupBy(cicerobooks, (book) => book.branchcode)['bjor'] ??
                    []),
            builder: (context, snapshot) => snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Cicerobok book = snapshot.data![index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainerHigh),
                          child: Stack(children: [
                            SizedBox(
                              width: double.infinity,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(book.title),
                                    Text(book.locLabel),
                                    Text(book.locRaw),
                                    Text(
                                        'Antall tilgjengelig: ${book.available.toString()}')
                                  ]),
                            ),
                            (book.status != "Utlånt")
                                ? const SizedBox(height: 10, width: 10)
                                : Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Center(
                                      child: Text("Utlånt",
                                          style: TextStyle(
                                              fontSize: 50,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onErrorContainer
                                                  .withOpacity(0.3))),
                                    ),
                                  )
                          ]),
                        ),
                      );
                    },
                  )
                : CircularProgressIndicator()));
  }
}
