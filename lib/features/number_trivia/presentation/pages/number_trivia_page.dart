import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tdd/features/number_trivia/presentation/bloc/bloc.dart';

import '../../../../injection_container.dart';
import '../../domain/entities/number_trivia.dart';

class NumberTriviaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Trivia'),
      ),
      body: buildBody(context),
    );
  }
}

BlocProvider<NumberTriviaBloc> buildBody(BuildContext context) {
  return BlocProvider(
    // builder: (_) => sl<NumberTriviaBloc>(),
    create: (BuildContext context) {
      return sl<NumberTriviaBloc>();
    },
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            // Top half
            BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                builder: (context, state) {
              if (state is Empty) {
                return MessageDispley(
                  message: "Start seaching",
                );
              } else if (state is Loading) {

              } else if (state is Loaded) {
              } else if (state is Error) {
                return MessageDispley(message: state.message);
              }
            }),

            SizedBox(height: 20),
            // Bottom half
            Column(
              children: <Widget>[
                // TextField
                Placeholder(fallbackHeight: 40),
                SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Expanded(
                      // Search concrete button
                      child: Placeholder(fallbackHeight: 30),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      // Random button
                      child: Placeholder(fallbackHeight: 30),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    ),
  );
}

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


class LoadingWidget extends StatelessWidget {
  const LoadingWidget({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Text('$message'),
    );
  }
}

class TriviaDispley extends StatelessWidget {
  const TriviaDispley({required this.numberTrivia});
  final NumberTrivia numberTrivia;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Text('$numberTrivia'),
    );
  }
}