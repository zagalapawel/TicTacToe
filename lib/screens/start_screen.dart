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
                'X or O?\n     Who do you play with?',
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
                  Navigator.of(context)
                      .pushNamed(GameScreen.routeName, arguments: false);
                },
                child: Column(
                  children: [
                    Text('Player\n',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Image(
                      image: poolX,
                      width: 150,
                      height: 150,
                    ),
                  ],
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(GameScreen.routeName, arguments: true);
                },
                child: Column(
                  children: [
                    Text('Comp\n',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Image(
                      image: poolO,
                      width: 150,
                      height: 150,
                    ),
                  ],
                ),
              ),
              Spacer(),
            ],
          )
        ],
      ),
    );
  }
}
