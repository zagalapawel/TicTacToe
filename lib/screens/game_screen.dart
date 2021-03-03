import 'package:flutter/material.dart';

import '../widgets/field_item.dart';
import '../data/board.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  Board board = Board();

  alert(String text) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Text(text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
      ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.blue,
        child: GridView(
          padding: const EdgeInsets.all(10),
          children: board.boardFields.keys
              .map((key) => FieldItem(
                    board.boardFields[key].id,
                    board.boardFields[key].pool,
                    () {
                      if (board.boardFields[key].pool.isEmpty) {
                        setState(
                          () {
                            board.boardFields[key].poolSetter(board.insertPool);
                            board.checkWin(alert);
                            board.changeTurn();
                          },
                        );
                      }
                    },
                  ))
              .toList(),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 150,
            childAspectRatio: 3 / 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
        ),
      ),
    );
    // );
  }
}
