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
        title: Text('Number Trivia'),
      ),
      body: SingleChildScrollView(child: Screen()),
    );
  }
}

class Screen extends StatelessWidget{

  
  @override
  Widget build(BuildContext context) {
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
                    return LoadingWidget(message: 'loaading');
                  } else if (state is Loaded) {
                    return TriviaDisplay(numberTrivia: state.trivia);
                  } else if (state is Error) {
                    return MessageDispley(message: state.message);
                  } else {
                    return MessageDispley(message: "bruh");
                  }
                },
              ),

              SizedBox(height: 20),
              // Bottom half
              TriviaControls()
            ],
          ),
        ),
      ),
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
                  return LoadingWidget(message: 'loaading');
                } else if (state is Loaded) {
                  return TriviaDisplay(numberTrivia: state.trivia);
                } else if (state is Error) {
                  return MessageDispley(message: state.message);
                } else {
                  return MessageDispley(message: "bruh");
                }
              },
            ),

            SizedBox(height: 20),
            // Bottom half
            TriviaControls()
          ],
        ),
      ),
    ),
  );
}

