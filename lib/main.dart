import 'package:flutter/material.dart';

import 'pages/book_details_screen.dart';
import 'pages/cicero_screen.dart';
import 'pages/deichman_screen.dart';
import 'pages/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/home': (context) => const HomeScreen(),
        '/saved': (context) => const DeichmanScreen(),
        '/favorites': (context) => const CiceroScreen(),
        '/details': (context) => const BookDetailsScreen(),
      },
      // debugShowCheckedModeBanner: false,
      home: const Sokeside(),
    );
  }
}

class Sokeside extends StatefulWidget {
  const Sokeside({super.key});

  @override
  State<Sokeside> createState() => _SokesideState();
}

class _SokesideState extends State<Sokeside> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const DeichmanScreen(),
    const CiceroScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text("Bokplassering")),
        body: _screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Søk'),
            BottomNavigationBarItem(icon: Icon(Icons.save), label: 'Lagret'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shelves), label: 'Plasseringer'),
          ],
          selectedItemColor: Theme.of(context).colorScheme.onPrimary,
          unselectedItemColor: Theme.of(context).colorScheme.onSurface,
          onTap: (value) {
            print('Tapped: $value');
            setState(() {
              _currentIndex = value;
            });
          },
        ));
  }
}
