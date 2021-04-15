import 'dart:math';

import 'field_data.dart';

class Board {
  bool turn = false;
  String currentPlayer = 'X';
  String compPool = 'O';
  String playerPool = 'X';
  String winner;
  int maxCompWinDepth = 0;
  List compWinsArray = [];

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
    winner = null;
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
    if (boardFields[1].pool == '' &&
        boardFields[2].pool == '' &&
        boardFields[3].pool == '' &&
        boardFields[4].pool == '' &&
        boardFields[5].pool == '' &&
        boardFields[6].pool == '' &&
        boardFields[7].pool == '' &&
        boardFields[8].pool == '' &&
        boardFields[9].pool == '') {
      Random rnd = new Random();
      boardFields[1 + rnd.nextInt(9 - 1)].pool = compPool;
    } else {
      bestMove();
    }

    changeTurn();
  }

  var scores = {
    'X': -1,
    'O': 1,
    'tie': 0,
  };

  int pickBestPool(List pools) {
    print(pools);

    var move = pools[0];
    int highestScore = pools[0][1];
    int lowestDepth = pools[0][2];
    int currentDepth;
    var bestMove = [];

    for (int i = 0; i < pools.length; i++) {
      print(pools[i]);
      if (highestScore <= pools[i][1]) {
        move = pools[i];
        highestScore = pools[i][1];
        currentDepth = pools[i][2];

        if (pools[i][1] == highestScore || currentDepth < lowestDepth) {
          lowestDepth = currentDepth;
          bestMove = pools[i];
        }
      }
    }
    print('bestPoolMove: ${move[0]}');
    print('bestMove: ${bestMove[0]}');
    print('return: ${(bestMove != null) ? bestMove[0] : move[0]}');
    return bestMove != null ? bestMove[0] : move[0];
  }

  void bestMove() {
    int move = 0;
    int minDepth = 10;
    compWinsArray = [];

    for (int i = 1; i <= 9; i++) {
      if (boardFields[i].pool == '') {
        maxCompWinDepth = 0;
        boardFields[i].pool = compPool;
        int score = minimax(boardFields, false);
        winner = null;
        boardFields[i].pool = '';
        print('i: $i + score: $score + maxCompWinDepth: $maxCompWinDepth');
        if (score == 1 && maxCompWinDepth < minDepth) {
          minDepth = maxCompWinDepth;
        }
        compWinsArray.add([i, score, maxCompWinDepth]);
      }
    }

    move = pickBestPool(compWinsArray);
    boardFields[move].pool = compPool;
    print('ruch : $move');
  }

  int minimax(board, isMaximizing) {
    String result = checkWin();

    if (result != null) {
      return scores[result];
    }

    if (isMaximizing) {
      maxCompWinDepth++;
      int bestScore = -10;
      for (int i = 1; i <= 9; i++) {
        if (board[i].pool == '') {
          board[i].pool = compPool;
          var score = minimax(board, false);
          board[i].pool = '';
          bestScore = max(score, bestScore);
        }
      }
      return bestScore;
    } else {
      int bestScore = 10;
      for (int i = 1; i <= 9; i++) {
        if (board[i].pool == '') {
          board[i].pool = playerPool;
          var score = minimax(board, true);
          board[i].pool = '';
          bestScore = min(score, bestScore);
        }
      }
      return bestScore;
    }
  }
}
