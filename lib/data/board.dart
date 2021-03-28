import 'dart:math';

import './fields_data.dart';

class Board {
  bool gameEnd = false;
  bool turn = false;
  String insertPool = 'X';
  String compPool = 'O';
  String winner;
  Map boardFields = new Map();
  int checkDraw = 0;

  Board() {
    clearBoard();
  }

  void clearBoard() {
    checkDraw = 0;
    for (int i = 1; i <= 9; i++) {
      this.boardFields[i] = FieldData(id: i, pool: '');
    }
  }

  void showAlertAndClearBoard(Function alert) {
    winner == 'tie' ? alert('tie') : alert('$winner wins!');
    clearBoard();
    return;
  }

  bool checkIfPoolsAreEquals(String pool1, String pool2, String pool3) {
    return pool1 == pool2 && pool2 == pool3 && pool1 != '';
  }

  void checkWin(Function alert) {
    // ->
    for (int i = 1; i <= 7; i += 3) {
      if (!checkIfPoolsAreEquals(
        boardFields[i].pool,
        boardFields[i + 1].pool,
        boardFields[i + 2].pool,
      )) continue;
      winner = boardFields[i].pool;
      showAlertAndClearBoard(alert);
    }
    // \/
    for (int i = 1; i <= 3; i++) {
      if (!checkIfPoolsAreEquals(
        boardFields[i].pool,
        boardFields[i + 3].pool,
        boardFields[i + 6].pool,
      )) continue;
      winner = boardFields[i].pool;
      showAlertAndClearBoard(alert);
    }
    // >\
    if (checkIfPoolsAreEquals(
      boardFields[1].pool,
      boardFields[5].pool,
      boardFields[9].pool,
    )) {
      winner = boardFields[1].pool;
      showAlertAndClearBoard(alert);
    }
    // /<
    if (checkIfPoolsAreEquals(
      boardFields[7].pool,
      boardFields[5].pool,
      boardFields[3].pool,
    )) {
      winner = boardFields[7].pool;
      showAlertAndClearBoard(alert);
    }

    if (checkDraw == 9) {
      winner = 'tie';
      showAlertAndClearBoard(alert);
    }
  }

  void changeTurn() {
    checkDraw++;
    insertPool = turn ? insertPool = 'X' : insertPool = 'O';
    turn = !turn;
  }

  // COMPUTER
  // var scores = {
  //   'X': 10,
  //   'O': -10,
  //   'tie': 0,
  // };

  // void bestMove() {
  //   var bestScore = -double.infinity;
  //   var move;

  //   for (int i = 0; i <= 9; i++) {
  //     if (boardFields[i].pool == '') {
  //       boardFields[i].pool = compPool;
  //       double score = minimax(boardFields, 0, false);
  //       boardFields[i].pool = '';
  //       if (score > bestScore) {
  //         bestScore = score;
  //         move = i;
  //       }
  //     }
  //   }
  //   boardFields[move] = compPool;
  // }

  // double minimax(board, depth, isMaximizing) {
  //   String result = winner;
  //   if (result != '') {
  //     return scores;
  //   }
  // }
}
