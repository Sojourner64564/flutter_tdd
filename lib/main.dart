import 'package:flutter/material.dart';
import 'package:flutter_tdd/injection_container.dart' as di;

void main() async {
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

@override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
      ),
      body: const Center(

      ),
    );
  }
}
