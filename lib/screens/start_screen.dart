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
                    Navigator.of(context).pushNamed(
                      GameScreen.routeName,
                      arguments: 'X',
                    );
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
                    Navigator.of(context).pushNamed(
                      GameScreen.routeName,
                      arguments: 'O',
                    );
                    // Navigator.of(context).push(_createRoute());
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

// Route _createRoute() {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) => GameScreen(),
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       var begin = Offset(0.0, 1.0);
//       var end = Offset.zero;
//       var curve = Curves.ease;

//       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

//       return SlideTransition(
//         position: animation.drive(tween),
//         child: child,
//       );
//     },
//   );
// }
