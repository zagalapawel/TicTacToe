import 'dart:math';

import 'field_data.dart';

class Board {
  bool turn = false;
  String currentPlayer = 'X';
  String compPool = 'O';
  String playerPool = 'X';
  String winner;

  Map boardFields = new Map();

  Board() {
    clearBoard();
  }

  void clearBoard() {
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
      // return;
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
      return winner;
    }
    // \/
    for (int i = 1; i <= 3; i++) {
      if (!checkIfPoolsAreEquals(
        boardFields[i].pool,
        boardFields[i + 3].pool,
        boardFields[i + 6].pool,
      )) continue;
      winner = boardFields[i].pool;
      return winner;
    }
    // >\
    if (checkIfPoolsAreEquals(
      boardFields[1].pool,
      boardFields[5].pool,
      boardFields[9].pool,
    )) {
      winner = boardFields[1].pool;
      return winner;
    }
    // /<
    if (checkIfPoolsAreEquals(
      boardFields[7].pool,
      boardFields[5].pool,
      boardFields[3].pool,
    )) {
      winner = boardFields[7].pool;
      return winner;
    }
    // tie
    if (boardFields[1].pool != '' &&
        boardFields[2].pool != '' &&
        boardFields[3].pool != '' &&
        boardFields[4].pool != '' &&
        boardFields[5].pool != '' &&
        boardFields[6].pool != '' &&
        boardFields[7].pool != '' &&
        boardFields[8].pool != '' &&
        boardFields[9].pool != '') {
      winner = 'tie';
      return winner;
    }
    return winner;
  }

  void changeTurn() {
    currentPlayer == 'X' ? currentPlayer = 'O' : currentPlayer = 'X';
  }

  // COMPUTER ////////////////////////////////////////////////

  void runComp() {
    if (currentPlayer == 'O') {
      bestMove();
      changeTurn();
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
        int score = minimax(boardFields, 0, false);
        winner = null;
        print('i: $i + score: $score');
        boardFields[i].pool = '';
        if (score > bestScore) {
          bestScore = score;
          move = i;
        }
      }
    }
    boardFields[move].pool = compPool;
    print('ruch : $move');
  }

  int minimax(board, depth, isMaximizing) {
    depth++;
    String result = checkWin();
    if (result != null) {
      return scores[result];
    }

    if (isMaximizing) {
      int bestScore = -100;
      for (int i = 1; i <= 9; i++) {
        if (board[i].pool == '') {
          board[i].pool = compPool;
          var score = minimax(board, depth, false);
          board[i].pool = '';
          bestScore = max(score, bestScore);
        }
      }
      return bestScore;
    } else {
      int bestScore = 100;
      for (int i = 1; i <= 9; i++) {
        if (board[i].pool == '') {
          board[i].pool = playerPool;
          var score = minimax(board, depth, true);
          board[i].pool = '';
          bestScore = min(score, bestScore);
        }
      }
      return bestScore;
    }
  }
}
