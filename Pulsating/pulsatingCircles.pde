class Orb {
  PVector location = new PVector(random(width), random(height));
  float size = random(5, 15);
  float saturation = random(0, 255);
  float change = 1;


  void display() {
    stroke(0);
    fill(saturation);
    ellipse(location.x, location.y, size, size);
  }

  void update() {
    if (saturation >= 255 - change) {
      change *= -1;
    }
    else if (saturation <= 0) {
      location = new PVector(random(width), random(height));
      change *= -1;
    }
    saturation += change;
  }
}


Orb[] orbs;

void setup() {
  size(480, 320);
  orbs = new Orb[25];
  for (int i = 0; i < orbs.length; i++) {
    orbs[i] = new Orb();
  }
}

void draw() {
  background(0);
  for (int i = 0; i < orbs.length; i++) {
    orbs[i].display();
    orbs[i].update();
  }
}
