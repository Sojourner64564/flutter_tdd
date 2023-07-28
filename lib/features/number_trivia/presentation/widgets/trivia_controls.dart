import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart';

class TriviaControls extends StatefulWidget {
  const TriviaControls({
    Key? key,
  }) : super(key: key);

  @override
  State<TriviaControls> createState() => _TriviaControlsState();
}

class _TriviaControlsState extends State<TriviaControls> {
  String inputStr = '0';
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Input a number',
          ),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            inputStr = value;
          },
        ),
        const SizedBox(height: 10),
        Row(
          children: <Widget>[
            Expanded(
              // Search concrete button
              child: ElevatedButton(
                child: const Text('Search'),
                onPressed: (){
                  dispatchConcrete(context, inputStr, controller);
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              // Random button
              child: ElevatedButton(
                child: const Text('Random'),
                onPressed: (){
                  dispatchRandom(context, controller);
                },
              ),
            )
          ],
        )
      ],
    );
  }
}

void dispatchConcrete(BuildContext context, String inputStr, TextEditingController controller){
  controller.clear();
  BlocProvider.of<NumberTriviaBloc>(context).add(GetTriviaForConcreteNumber(inputStr));
}

void dispatchRandom(BuildContext context, TextEditingController controller){
  controller.clear();
  BlocProvider.of<NumberTriviaBloc>(context).add(GetTriviaForRandomNumber());
}