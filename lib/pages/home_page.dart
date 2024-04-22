import 'package:flutter/material.dart';

import 'map_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MapPage(),
    );
  }
}
