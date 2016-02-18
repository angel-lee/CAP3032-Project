class GameManager{
  PFont title;
  int stage;
  int moves;
  Board gameBoard;
  float theta = 0;

  GameManager(){
  }

  void setGame(int x, int y) {
    size(x, y);
    rectMode(CENTER);
    frameRate(60);
    title = loadFont("font.vlw");
    textFont(title);
    gameBoard = new Board();
    stage = 1;
    moves = 15;
    }

  void drawGame() {
    if (stage == 1) {
      background(75);
      float x = (cos(theta+1))*250;
      theta += .05;

      textAlign(CENTER);
      fill(200, x, 255);
      textSize(70);
      text("MATCH IT", 250, 170);
      textSize(18);
      text("Press any key to start the game", 250, 200);
      //fill(248, 155, 255);
      fill(255);
      textSize(14);
      text("Switch game pieces to make horizontal or vertical matches of 3 or more", 250, 240);
      text("Reach a score of 250 to win", 250, 255);

      if (keyPressed == true) {
        stage = 2;
      }
    }

    if (stage == 2) {
      background(80);

      gameBoard.display();
      gameBoard.rowMatches(moves);
      gameBoard.columnMatches(moves);

      fill(255);
      textSize(30);
      text("MOVES", 430, 50);
      text(moves, 430, 80);
      text("SCORE", 430, 200);
      text(gameBoard.score, 430, 230);
    
      if(gameBoard.score == 250) {
       stage = 4; 
      }

      if (moves == 0) {
        stage = 3;
      }
    }

    if (stage == 3) {
      background(0);

      fill(255);
      textSize(50);
      text("GAME OVER", 250, 170);
      textSize(16);
      text("Press any key to play again", 250, 200);
    }
  
    if(stage == 4) {
      background(0);

      fill(255);
      textSize(50);
      text("YOU WON!", 250, 170);
      textSize(16);
      text("Press any key to play again", 250, 200);
    }
  }

 void mousePressedOnce() {
   if (mouseX < gameBoard.w) {
     gameBoard.clicked();
   } 
 }

  void mouseClickedOnce() {
    if (mouseX < gameBoard.getWidth() && mouseY < gameBoard.getWidth() && stage == 2) {
      if (gameBoard.isSwapped() == true) {
        moves--;
      }
    }
  }

  void keyPressedOnce() {
    if (stage == 3) {
      reset();
    }
    else if(stage == 4) {
     reset(); 
    }
  }

  void reset() {
    gameBoard = new Board();
    stage = 1;
    moves = 15;
  }
}
