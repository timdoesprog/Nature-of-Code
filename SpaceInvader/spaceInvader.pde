class Player {
  private PVector location = new PVector(320, 430);
  private float height = 25;
  private float base = 12;
  private float velocity = 4;

  public void display() {
    stroke(250,2,60);
    fill(250,2,60);
    triangle(location.x - base, location.y, location.x, location.y - height,
      location.x + base, location.y);
  }

  public void update() {
    getInput();
    checkEdges();
  }

  private void getInput() {
    if (key == CODED) {
      move();
      shoot();
    }
  }

  private void shoot() {
    if (keyCode == UP) {
      
    }
  }

  private void move() {
    if (keyCode == LEFT) {
      location.add(new PVector(-velocity, 0));
    }
    else if (keyCode == RIGHT) {
      location.add(new PVector(velocity, 0));
    }
  }

  private void checkEdges() {
    if (location.x <= base + 10) {
      location.x = base + 10;
    }
    else if (location.x >= width - base - 10) {
      location.x = width - base - 10;
    }
  }
}


Player player;


void setup() {
  size(640, 480);
  player = new Player();
}

void draw() {
  background(4,0,4);
  player.display();
  player.update();
}


// Colors
// black = 4,0,4 => background
// gray = 65,61,61
// lime-light = 200,255,0
// pink = 250,2,60 => Player
// red = 75,0,15
