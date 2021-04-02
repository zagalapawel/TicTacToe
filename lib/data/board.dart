import 'dart:math';

import 'field_data.dart';

class Board {
  bool turn = false;
  String currentPlayer = 'X';
  String compPool = 'O';
  String playerPool = 'X';
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
    checkWin();
    if (winner != null) {
      winner == 'tie' ? alert('tie') : alert('$winner wins!');
      clearBoard();

      return;
    }
  }

  bool checkIfPoolsAreEquals(String pool1, String pool2, String pool3) {
    return pool1 == pool2 && pool2 == pool3 && pool1 != '';
  }

  String checkWin() {
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
    return winner;
  }

  void changeTurn() {
    checkDraw++;
    print(checkDraw);
    if (currentPlayer == 'X') {
      currentPlayer = 'O';
    } else {
      currentPlayer = 'X';
    }
  }

  // COMPUTER ////////////////////////////////////////////////

  void runComp() {
    if (checkDraw < 8) {
      if (currentPlayer == 'O') {
        bestMove();
      }
    }
  }

  var scores = {
    'X': -1,
    'O': 1,
    'tie': 0,
  };

  void bestMove() {
    int bestScore = -100;
    int move;
    for (int i = 1; i <= 9; i++) {
      if (boardFields[i].pool == '') {
        boardFields[i].pool = compPool;
        int score = minimax(boardFields, false);
        print('i: $i + score: $score');
        boardFields[i].pool = '';
        if (score > bestScore) {
          bestScore = score;
          move = i;
        }
      }
    }
    boardFields[move].pool = compPool;
  }

  int minimax(board, isMaximizing) {
    String result = checkWin();
    if (result != null) {
      return scores[result];
    }

    if (isMaximizing) {
      int bestScore = -100;
      for (int i = 1; i <= 9; i++) {
        if (board[i].pool == '') {
          board[i].pool = compPool;
          var score = minimax(board, false);
          board[i].pool = '';
          bestScore = max(score, bestScore);
        }
      }
      winner = null;
      return bestScore;
    } else {
      int bestScore = 100;
      for (int i = 1; i <= 9; i++) {
        if (board[i].pool == '') {
          board[i].pool = playerPool;
          var score = minimax(board, true);
          board[i].pool = '';
          bestScore = min(score, bestScore);
        }
      }
      winner = null;
      return bestScore;
    }
  }
}
