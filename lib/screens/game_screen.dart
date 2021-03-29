import 'package:flutter/material.dart';

import '../widgets/field_item.dart';
import '../data/board.dart';

class GameScreen extends StatefulWidget {
  static const routeName = '/game-screen';

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  Board board = Board();

  alert(String text) {
    showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              shape:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
              title: Text('Game Over!'),
              content: Text('$text'),
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 1000),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool compInPlay = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text('${board.insertPool}\'s turn'),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.yellow,
              Colors.blue,
              Colors.green,
            ],
          ),
        ),
        alignment: Alignment.center,
        child: GridView(
          padding: const EdgeInsets.all(10),
          children: board.boardFields.keys
              .map(
                (key) => FieldItem(
                  board.boardFields[key].id,
                  board.boardFields[key].pool,
                  () {
                    if (board.boardFields[key].pool.isEmpty) {
                      setState(
                        () {
                          board.boardFields[key].poolSetter(board.insertPool);
                          board.checkWin();
                          board.showAlertAndClearBoard(alert);
                          board.changeTurn();

                          if (compInPlay == true) {
                            board.runComp();
                            board.checkWin();
                            board.showAlertAndClearBoard(alert);
                            board.changeTurn();
                          }
                        },
                      );
                    }
                  },
                ),
              )
              .toList(),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 150,
            childAspectRatio: 3 / 3,
          ),
        ),
      ),
    );
  }
}
