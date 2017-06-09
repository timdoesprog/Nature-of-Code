class Raindrop {
  PVector location;
  PVector veloctiy;

  Raindrop() {
    location = new PVector(random(0, width), random(-50, -10));
    velocity = new PVector(0, 6);
  }

  void update() {
    location.add(velocity);
  }

  void display() {
    noStroke();
    fill(0);
    ellipse(location.x, location.y, 6, 8);
  }
}


Raindrop[] drops;


void setup() {
  size(720, 480);
  drops = new Raindrop[20];
  for (int i = 0; i < drops.length; i++) {
    drops[i] = new Raindrop();
  }
}

void draw() {
  background(190, 190, 170);
  for (int i = 0; i < drops.length; i++) {
    drops[i].display();
    drops[i].update();
  }
}
