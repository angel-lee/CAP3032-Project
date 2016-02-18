GameManager game = new GameManager();

void setup() {
  game.setGame(500, 370);
}

void draw() {
  game.drawGame();
}

void mousePressed(){
  game.mousePressedOnce();
}

void mouseClicked(){ 
  game.mouseClickedOnce();
}

void keyPressed(){
  game.keyPressedOnce();
}
