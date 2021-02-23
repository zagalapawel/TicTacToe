import './fields_data.dart';

class Board {
  bool turn = false;
  String insertPool = 'X';
  Map boardFields = new Map();

  Board() {
    clearBoard();
  }

  void getBoard() {
    for (int i = 1; i <= 9; i++) {
      this.boardFields[i] = FieldData(id: i, pool: '');
      //yield FieldData(id: i, pool: '');
    }
  }

  bool checkEquals(String pool1, String pool2, String pool3) {
    return pool1 == pool2 && pool2 == pool3 && pool1 != '';
  }

  String checkWIn() {
    String winner;

    for (int i = 1; i <= 9; i += 3) {
      if (checkEquals(boardFields[i].pool, boardFields[i + 1].pool,
          boardFields[i + 2].pool)) {
        // winner=boardFields[i].pool;
        return winner = boardFields[i].pool;
      }
    }
  }

  void changeTurn() {
    insertPool = turn ? insertPool = 'X' : insertPool = 'O';
    turn = !turn;
  }

  void clearBoard() {
    getBoard();
  }
}
