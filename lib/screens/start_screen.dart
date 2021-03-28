import 'package:flutter/material.dart';
import './game_screen.dart';

class StartScreen extends StatelessWidget {
  static const routeName = '/start-screen';
  static const poolX = AssetImage('assets/images/X1000.png');
  static const poolO = AssetImage('assets/images/O1000.png');

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
                  'X or O?\n     Who start',
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
                    Navigator.of(context).pushNamed(GameScreen.routeName);
                  },
                  child: Image(
                    image: poolX,
                    width: 150,
                    height: 150,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(GameScreen.routeName);
                  },
                  child: Image(
                    image: poolO,
                    width: 150,
                    height: 150,
                  ),
                ),
                Spacer(),
              ],
            )
          ],
        ));
  }
}
