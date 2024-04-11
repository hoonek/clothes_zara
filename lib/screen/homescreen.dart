import 'package:flutter/material.dart';

import '../menu/inner.dart';
import '../menu/outer.dart';
import 'drawer_menu.dart';

class HomeScreen extends StatelessWidget {
  final String ID;
  final String PW;

  const HomeScreen({Key? key, required this.ID, required this.PW}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      drawer: DrawerMenu(),
      body: const Center(
        child: const Text('Welcome'),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => HomeScreen(ID: 'user_id', PW: 'user_password'),
      '/outer': (context) => Outer(),
      '/inner': (context) => Inner(),
    },
  ));
}
