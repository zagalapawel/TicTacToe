import 'dart:math';

import 'field_data.dart';

class Board {
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
    winner = null;
    for (int i = 1; i <= 9; i++) {
      boardFields[i] = FieldData(id: i, pool: '');
    }
  }

  void showAlertAndClearBoard(Function alert) {
    if (winner != null) {
      winner == 'tie' ? alert('tie') : alert('$winner wins!');
      clearBoard();
      return;
    }
  }

  bool checkIfPoolsAreEquals(String pool1, String pool2, String pool3) {
    return pool1 == pool2 && pool2 == pool3 && pool1 != '';
  }

  void checkWin() {
    // ->
    for (int i = 1; i <= 7; i += 3) {
      if (!checkIfPoolsAreEquals(
        boardFields[i].pool,
        boardFields[i + 1].pool,
        boardFields[i + 2].pool,
      )) continue;
      winner = boardFields[i].pool;
    }
    // \/
    for (int i = 1; i <= 3; i++) {
      if (!checkIfPoolsAreEquals(
        boardFields[i].pool,
        boardFields[i + 3].pool,
        boardFields[i + 6].pool,
      )) continue;
      winner = boardFields[i].pool;
    }
    // >\
    if (checkIfPoolsAreEquals(
      boardFields[1].pool,
      boardFields[5].pool,
      boardFields[9].pool,
    )) {
      winner = boardFields[1].pool;
    }
    // /<
    if (checkIfPoolsAreEquals(
      boardFields[7].pool,
      boardFields[5].pool,
      boardFields[3].pool,
    )) {
      winner = boardFields[7].pool;
    }
    // tie
    if (checkDraw == 9) {
      winner = 'tie';
    }
  }

  String getWinner() {
    return winner;
  }

  void changeTurn() {
    checkDraw++;
    insertPool = turn ? insertPool = 'X' : insertPool = 'O';
    turn = !turn;
  }

  // COMPUTER ////////////////////////////////////////////////

  void runComp() {
    if (checkDraw != 9) {
      if (insertPool == 'O') {
        bestMove();
      }
    }
  }

  var scores = {
    'X': 10,
    'O': -10,
    'tie': 0,
  };

  void bestMove() {
    int bestScore = -1000;
    var move;

    for (int i = 1; i <= 9; i++) {
      if (boardFields[i].pool == '') {
        boardFields[i].pool = compPool;
        int score = minimax(boardFields, 0, false);
        boardFields[i].pool = '';
        if (score > bestScore || bestScore != null) {
          bestScore = score;
          move = i;
        }
      }
    }
    boardFields[move].pool = compPool;
  }

  int minimax(board, depth, isMaximizing) {
    String result = getWinner();
    if (result != null) {
      return scores[result];
    }

    if (isMaximizing) {
      int bestScore = -100;
      for (int i = 1; i <= 9; i++) {
        if (board[i].pool == '') {
          board[i].pool = compPool;
          var score = minimax(board, depth + 1, false);
          board[i].pool = '';
          bestScore = max(score, bestScore);
        }
      }
      return bestScore;
    } else {
      int bestScore = 100;
      for (int i = 1; i <= 9; i++) {
        if (board[i] == '') {
          board[i].pool = insertPool;
          var score = minimax(board, depth + 1, true);
          board[i].pool = '';
          bestScore = min(score, bestScore);
        }
      }
      return bestScore;
    }
  }
}
