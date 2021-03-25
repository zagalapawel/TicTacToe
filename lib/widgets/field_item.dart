import 'package:flutter/material.dart';
import '../screens/start_screen.dart';

class FieldItem extends StatelessWidget {
  final int id;
  final String pool;
  final VoidCallback selectHandler;

  FieldItem(this.id, this.pool, this.selectHandler);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: selectHandler,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          border: Border.all(
            width: 2.0,
            color: Colors.yellow,
          ),
        ),
        child: FittedBox(
            child: pool == ''
                ? Text(pool)
                : Image(
                    image: pool == 'X' ? StartScreen.poolX : StartScreen.poolO,
                  )),
      ),
    );
  }
}
