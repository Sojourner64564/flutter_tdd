import 'package:flutter/material.dart';
import 'package:flutter_tdd/injection_container.dart' as di;

import 'features/number_trivia/presentation/pages/number_trivia_page.dart';

void main() async {
  await di.init();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Trivia',
      theme: ThemeData(
        primaryColor: Colors.green.shade800,
       // accentColor: Colors.green.shade600,
      ),
      home: NumberTriviaPage(),
    );
  }
}