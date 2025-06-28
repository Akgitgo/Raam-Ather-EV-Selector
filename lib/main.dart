import 'package:flutter/material.dart';
import 'package:ev_selector/pages/home_page.dart';

void main() {
  runApp(const EVSelectorApp());
}

class EVSelectorApp extends StatelessWidget {
  const EVSelectorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Raam Ather EV Selector',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}
