import 'package:flutter/material.dart';

class DeichmanScreen extends StatefulWidget {
  const DeichmanScreen({super.key});

  @override
  State<DeichmanScreen> createState() => _DeichmanScreenState();
}

class _DeichmanScreenState extends State<DeichmanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Boken på Deichman')));
  }
}
