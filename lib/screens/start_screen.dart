import 'package:flutter/material.dart';
import 'package:tictactoe/screens/game_screen.dart';

class StartScreen extends StatelessWidget {
  static const routeName = '/start-screen';
  static const poolX = AssetImage('assets/images/X.png');
  static const poolO = AssetImage('assets/images/O.png');
  String player = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Tic! Tac! Toe!'),
        ),
        body: Column(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 50, bottom: 50),
                child: Text(
                  'X or O?\n     Pick now',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Spacer(),
                GestureDetector(
                  onTap: () {
                    player = 'X';
                    Navigator.of(context).pushNamed(GameScreen.routeName);
                  },
                  child: Image(image: poolX),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    player = 'O';
                    Navigator.of(context).pushNamed(GameScreen.routeName);
                  },
                  child: Image(image: poolO),
                ),
                Spacer(),
              ],
            )
          ],
        ));
  }
}
