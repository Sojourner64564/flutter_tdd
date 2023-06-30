import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tdd/features/number_trivia/presentation/bloc/bloc.dart';

import '../../../../injection_container.dart';
import '../widgets/widgets.dart';

class NumberTriviaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Trivia'),
      ),
      body: SingleChildScrollView(child:
      Screen(),
      ),
    );
  }
}

class Screen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<NumberTriviaBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                builder: (context, state) {
                  if (state is Empty) {
                    return const MessageDispley(
                      message: "Start seaching",
                    );
                  } else if (state is Loading) {
                    return const LoadingWidget(message: 'loaading');
                  } else if (state is Loaded) {
                    return TriviaDisplay(numberTrivia: state.trivia);
                  } else if (state is Error) {
                    return MessageDispley(message: state.message);
                  } else {
                    return const MessageDispley(message: "bruh");
                  }
                },
              ),
              const SizedBox(height: 20),
              const TriviaControls()
            ],
          ),
        ),
      ),
    );
  }



}