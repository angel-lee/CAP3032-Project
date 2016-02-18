class Cell {
  int cellType;
  String cellTypeName;
  float x, y;
  float w, h;
  float temp;
  color baseColor;
  color hoverColor;
  boolean hovering;
  boolean selected;
  boolean animatingIn;
  int identifier;

  Cell(float x_, float y_, float w_, float h_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    cellType = round(random(0, 4));
    switch (cellType) {
    case 0:
      identifier = 1;
      cellTypeName = "circle";
      baseColor = color(248, 155, 255);
      hoverColor = color(161, 101, 166);
      break;
    case 1:
      identifier = 2;
      cellTypeName = "square";
      baseColor = color(255, 187, 140);
      hoverColor = color(181, 133, 99);
      break;
    case 2:
      identifier = 3;
      cellTypeName = "triangle";
      baseColor = color(142, 239, 255);
      hoverColor = color(102, 172, 184);
      break;
    case 3:
      identifier = 4;
      cellTypeName = "diamond";
      baseColor = color(255, 255, 255);
      hoverColor = color(176, 176, 176);
      break;
    case 4:
      identifier = 5;
      cellTypeName = "oval";
      baseColor = color(159, 219, 132);
      hoverColor = color(102, 140, 84);
      break;
    case 5:
      cellTypeName = "rowBlank";
      break;
    case 6:
      cellTypeName = "columnBlank";
      break;
    default:
      println("Error: shape without type.");
      break;
    }
  }



  void display() {
    detectHover();
    noStroke();
    if (hovering) {
      fill(hoverColor);
    }
    else {
      fill(baseColor);
    }

    switch (cellType) {
    case 0:
      drawCircle();
      break;
    case 1:
      drawSquare();
      break;
    case 2:
      drawTriangle();
      break;
    case 3:
      drawDiamond();
      break;
    case 4:
      drawOval();
      break;
    default:
      println("Trying to draw non-shape!");
      break;
    }

    if (selected) {
      drawHighlightBox();
    }
    
    if (animatingIn) {
      animateIn();
    }
  }

  void detectHover() {
    int dist = (int) dist(mouseX, mouseY, x, y);
    if (dist < w/2) {
      hovering = true;
    }
    else {
      hovering = false;
    }
  }

  void select() {
    selected = true;
  }

  void deselect() {
    selected = false;
  }

  // DRAWING METHODS //

  void drawCircle() {
    ellipse(x, y, w, w);
  }

  void drawSquare() {
    rect(x, y, w * .9, w * .9);
  }

  void drawTriangle() {
    float x2 = x;
    float y2 = y - w/2 + 10;
    float x3 = x + w/2;
    float y3 = y + w/2;
    triangle(x-w/2, y+w/2, x2, y2, x3, y3);
  }

  void drawDiamond() {
    float x2 = x + (w/2);
    float y2 = y;
    float x3 = x;
    float y3 = y + w/2;
    float x4 = x - (w/2);
    float y4 = y;
    quad(x, y - w/2, x2, y2, x3, y3, x4, y4);
  }

  void drawOval() {
    ellipse(x, y, w/2, w);
  }

  void drawHighlightBox() {
    noFill();
    stroke(255, 255, 255);
    rect(x, y, 55, 55);
  }

  void setCellType(int newCellType) {
    cellType = newCellType;
    switch(newCellType) {
    case 0:
      cellTypeName = "circle";
      baseColor = color(248, 155, 255);
      hoverColor = color(161, 101, 166);
      break;
    case 1:
      cellTypeName = "square";
      baseColor = color(255, 187, 140);
      hoverColor = color(181, 133, 99);
      break;
    case 2:
      cellTypeName = "triangle";
      baseColor = color(142, 239, 255);
      hoverColor = color(102, 172, 184);
      break;
    case 3:
      cellTypeName = "diamond";
      baseColor = color(255, 255, 255);
      hoverColor = color(176, 176, 176);
      break;
    case 4:
      cellTypeName = "oval";
      baseColor = color(159, 219, 132);
      hoverColor = color(102, 140, 84);
      break;
    default:
      println("Error: shape without type.");
      break;
    }
  }
  
  void animateIn() {
    if (w < 50) {
      w+=2;
      h+=2;
    } else {
      animatingIn = false;
    }
  }
}

