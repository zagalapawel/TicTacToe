import './fields_data.dart';

class Board {
  bool gameEnd = false;
  bool turn = false;
  String insertPool = 'X';
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

  void groupFunc(Function alert, int i) {
    i == 30 ? alert('tie') : alert('${boardFields[i].pool} wins!');
    clearBoard();
    return;
  }

  bool checkEquals(String pool1, String pool2, String pool3) {
    return pool1 == pool2 && pool2 == pool3 && pool1 != '';
  }

  void checkWin(Function alert) {
    // ->
    for (int i = 1; i <= 7; i += 3) {
      if (!checkEquals(
        boardFields[i].pool,
        boardFields[i + 1].pool,
        boardFields[i + 2].pool,
      )) continue;

      groupFunc(alert, i);
    }
    // \/
    for (int i = 1; i <= 3; i++) {
      if (!checkEquals(
        boardFields[i].pool,
        boardFields[i + 3].pool,
        boardFields[i + 6].pool,
      )) continue;

      groupFunc(alert, i);
    }
    // >\
    if (checkEquals(
      boardFields[1].pool,
      boardFields[5].pool,
      boardFields[9].pool,
    )) {
      groupFunc(alert, 1);
    }
    // /<
    if (checkEquals(
      boardFields[7].pool,
      boardFields[5].pool,
      boardFields[3].pool,
    )) {
      groupFunc(alert, 7);
    }

    if (checkDraw == 9) {
      groupFunc(alert, 30);
    }
  }

  void changeTurn() {
    checkDraw++;
    insertPool = turn ? insertPool = 'X' : insertPool = 'O';
    turn = !turn;
  }
}
