
import 'package:flutter/material.dart';

class MessageDispley extends StatelessWidget {
  const MessageDispley({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Text('$message'),
    );
  }
}