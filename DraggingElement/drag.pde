class Circle {
  PVector location = new PVector(random(width), random(height));
  boolean selected = false;

  void display() {
    stroke(0);
    fill(125);
    ellipse(location.x, location.y, 32, 32);
  }

  void update() {
    if (mousePressed && (mouseButton == LEFT)) {
      PVector mousePos = new PVector(mouseX, mouseY);
      if (selected) {
        location = mousePos;
      }
      else if (clicked(mousePos) && mousePressed) {
        selected = true;
      }
    }
    if (!mousePressed) {
      selected = false;
    }
    if (!selected) {
      snapToGrid();
    }
  }

  void snapToGrid() {
    // get x and y cell number
    int xGrid = floor(location.x / cellSize) + 1;
    int yGrid = floor(location.y / cellSize) + 1;
    // snap the circle to the middle of the cell
    location.x = xGrid * cellSize - cellSize / 2;
    location.y = yGrid * cellSize - cellSize / 2;
  }

  boolean clicked(PVector mouse) {
    PVector distanceV = PVector.sub(mouse, location);
    return distanceV.mag() < 16;
  }
}

Circle circle;
float cellSize = 80;

void setup() {
  size(480, 480);
  circle = new Circle();
}

void draw() {
  background(255);
  for (int i = 0; i < width / cellSize; i++) {
    stroke(0);
    line(i * cellSize, 0, i * cellSize, height);
    line(0, i * cellSize, width, i * cellSize);
  }
  circle.display();
  circle.update();
}
