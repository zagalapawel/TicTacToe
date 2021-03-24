import 'package:flutter/material.dart';
import 'package:tictactoe/screens/start_screen.dart';

import './screens/game_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: StartScreen(),
      routes: {
        GameScreen.routeName: (ctx) => GameScreen(),
        StartScreen.routeName: (ctx) => StartScreen(),
      },
    );
  }
}
