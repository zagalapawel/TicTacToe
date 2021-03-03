import 'package:flutter/material.dart';
import './fields_data.dart';

class Board {
  bool gameEnd = false;
  bool turn = false;
  String insertPool = 'X';
  Map boardFields = new Map();

  Board() {
    clearBoard();
  }

  void clearBoard() {
    for (int i = 1; i <= 9; i++) {
      this.boardFields[i] = FieldData(id: i, pool: '');
    }
  }

  bool checkEquals(String pool1, String pool2, String pool3) {
    return pool1 == pool2 && pool2 == pool3 && pool1 != '';
  }

  void checkWin(Function alert) {
    // ->
    for (int i = 1; i <= 7; i += 3) {
      if (!checkEquals(boardFields[i].pool, boardFields[i + 1].pool,
          boardFields[i + 2].pool)) continue;

      alert(boardFields[i].pool);
      clearBoard();
      return;
    }
    // \/
    for (int i = 1; i <= 3; i++) {
      if (!checkEquals(boardFields[i].pool, boardFields[i + 3].pool,
          boardFields[i + 6].pool)) continue;

      alert(boardFields[i].pool);
      clearBoard();
      return;
    }
    // >\
    if (checkEquals(
        boardFields[1].pool, boardFields[5].pool, boardFields[9].pool)) {
      alert(boardFields[1].pool);
      clearBoard();
      return;
    }
    // /<
    if (checkEquals(
        boardFields[7].pool, boardFields[5].pool, boardFields[3].pool)) {
      alert(boardFields[7].pool);
      clearBoard();
      return;
    }
    // if (winner == null) {
    //   winner = 'tie!';
    // }
    // print(winner);

    // alert();
  }

  void changeTurn() {
    insertPool = turn ? insertPool = 'X' : insertPool = 'O';
    turn = !turn;
  }
}
