import java.util.*;

class Board {
  Cell[][] board;
  int rows = 6;
  int columns = 6;
  float w = 370;
  int firstRow = 0;
  int firstCol = 0;
  int secondRow = 0;
  int secondCol = 0;
  int score = 0;
  boolean swapped;

  boolean rowMatch = false;
  boolean columnMatch = false;


  Board() {
    board = new Cell[columns][rows];
    for (int i = 0; i < columns; i++) {
      for (int j = 0; j < rows; j++) {
        board[i][j] = new Cell((i*60) + 30, (j*60) + 35, 50, 50);
      }
    }
  }

  void rowMatches(int moves) {
    for (int i = 0; i < rows-2; i++) {
      for (int j = 0; j < columns; j++) {
        if (board[i][j].cellTypeName == board[i+1][j].cellTypeName && board[i][j].cellTypeName == board[i+2][j].cellTypeName) {
          rowMatch = true;
          board[i][j].cellType = 5;
          board[i+1][j].cellType = 5;
          board[i+2][j].cellType = 5;
        }
      }
    }
    for (int j = 0; j < rows; j++) {
      for (int i = 0; i < columns; i++) {
        if (board[j][i].cellType == 5) {
          // Animate the new shape in
          board[j][i] = new Cell((j*60) + 30, (i*60)+ 35, 0, 0);
          board[j][i].animatingIn = true;
        }
      }
    }
    if (rowMatch) {
      if(moves < 15){
        score+=10;
        println("Row match detected.");
        rowMatch = false;
      }
    }
  } 

  void columnMatches(int moves) {
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < columns-2; j++) {
        if (board[i][j].cellTypeName == board[i][j+1].cellTypeName && board[i][j].cellTypeName == board[i][j+2].cellTypeName) {
          columnMatch = true;
          board[i][j].cellType = 6;
          board[i][j+1].cellType = 6;
          board[i][j+2].cellType = 6;
        }
      }
    }   
    for (int j = 0; j< rows; j++) {
      for (int i = 0; i < columns; i++) {
        if (board[j][i].cellType == 6) {
          board[j][i] = new Cell((j*60) + 30, (i*60)+ 35, 0, 0);
          board[j][i].animatingIn = true;
        }
      }
    }
    if (columnMatch) {
      if(moves < 15){
        score+=10;
        println("Column match detected.");
        columnMatch = false;
      }
    }
  }

  float getWidth() {
    return w;
  }

  boolean isSwapped() {
    return swapped;
  }

  void display() {
    for (int i = 0; i < columns; i++) {
      for (int j = 0; j < rows; j++) {
        board[i][j].display();
      }
    }
  }

  void clicked() {
    int col = (int) map(mouseX, 0, w, 0, 6);
    int row = (int) map(mouseY, 0, height, 0, 6);
    println("you clicked the board. col: "+(col+1)+", row: "+(row+1));
    swapped = false;
    // there is no first selection, so highlight the click
    if (firstCol == 0 && firstRow == 0) {
      // store the first row/col combo
      firstCol = col;
      firstRow = row;
      // highlight first square
      board[col][row].select();
    } 

    // they have clicked the one that already was highlighted!
    else if (firstCol == col && firstRow == row) {
      // reset first row/col combo
      firstCol = 0;
      firstRow = 0;
      // un-highligh first square
      board[col][row].deselect();
    }

    else if ( (col == firstCol && row == firstRow+1) || (col == firstCol && row == firstRow-1) || (row == firstRow && col == firstCol+1) || (row == firstRow && col == firstCol-1) ) {
      // store the second row/col combo
      secondCol = col;
      secondRow = row;
      // highlight the second square
      board[col][row].select();

      // now we need to swap the shapes
      int cellType1 = board[firstCol][firstRow].cellType;
      int cellType2 = board[secondCol][secondRow].cellType;
      board[firstCol][firstRow].setCellType(cellType2);
      board[secondCol][secondRow].setCellType(cellType1);
      swapped = true;

      // and deselect both
      board[firstCol][firstRow].deselect();
      board[secondCol][secondRow].deselect();

      // and clear both of our selections
      firstRow = firstCol = secondRow = secondCol = 0;
    }
  }
}

