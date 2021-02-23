import 'package:flutter/material.dart';

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
          border: Border.all(
            width: 2.0,
            color: Colors.yellow,
          ),
        ),
        child: FittedBox(
          child: Text(pool),
        ),
      ),
    );
  }
}
