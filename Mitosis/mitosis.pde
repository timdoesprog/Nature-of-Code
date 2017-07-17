class Cell {
  PVector location;
  PVector velocity;
  float size;
  float tx = 0;
  float ty = random(10000, 15000);
  int time = random(0, 5000);

  Cell(float x, float y, float s) {
    location = new PVector(x, y);
    velocity = new PVector(0, 0);
    size = s;
  }

  void display() {
    noStroke();
    fill(255);
    ellipse(location.x, location.y, size, size);
  }

  void update() {
    if (time >= 150) {
      if (size <= 64) {
        size++;
      }
      time = 0;
    }
    float x = map(noise(tx), 0, 1, -1, 1) * 3;
    float y = map(noise(ty), 0, 1, -1, 1) * 3;
    velocity = new PVector(x, y);
    tx += 0.01;
    ty += 0.01;
    location.add(velocity);
    checkEdges();
    time++;
  }

  void checkEdges() {
    if (location.x >= width) {
      location.x = 0;
    }
    else if (location.x <= 0) {
      location.x = width;
    }
    if (location.y >= height) {
      location.y = 0;
    }
    else if (location.y <= 0) {
      location.y = height;
    }
  }

  boolean isHit() {
    PVector distance = PVector.sub(location, new PVector(mouseX, mouseY));
    return distance.mag() < size/2;
  }
}


ArrayList<Cell> cells = new ArrayList<Cell>();


void setup() {
  size(640, 480);
  for (int i = 0; i < 20; i++) {
    cells.add(new Cell(random(width), random(height), random(8, 32)));
  }
}

void draw() {
  background(51);
  for (int i = cells.size() - 1; i >= 0; i--) {
    Cell cell = cells.get(i);
    cell.display();
    cell.update();
    if (mousePressed && cell.isHit() && cell.size >= 25) {
      cells.add(new Cell(cell.location.x, cell.location.y, cell.size / 2));
      cells.add(new Cell(cell.location.x, cell.location.y, cell.size / 2));
      cells.remove(i);
    }
  }
}
