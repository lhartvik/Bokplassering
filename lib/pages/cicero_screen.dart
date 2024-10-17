import 'package:flutter/material.dart';

class CiceroScreen extends StatefulWidget {
  const CiceroScreen({super.key});

  @override
  State<CiceroScreen> createState() => _CiceroScreenState();
}

class _CiceroScreenState extends State<CiceroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Boken på Cicero')));
  }
}
