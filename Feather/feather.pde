class Feather {
  PVector location;
  PVector velocity;
  PVector acceleration;

  Feather(float x , float y) {
    location = new PVector(x, y);
    // already with gravity as a constant velocity
    velocity = new PVector(0, 0.5);
    acceleration = new PVector(0, 0);
  }

  void display() {
    noStroke();
    fill(255);
    ellipse(location.x, location.y, 32, 32);
  }

  void update() {
    applyForces();
    velocity.add(acceleration);
    checkForFloor();
    location.add(velocity);
    acceleration.mult(0);
  }

  void applyForces() {
    // PVector gravity = new PVector(0, 0.01);
    // acceleration.add(gravity);

    float distance = location.x - width/2;
    PVector swingForce = new PVector(0.2, 0);
    if (distance > 0) {
      swingForce.mult(-1);
    }
    acceleration.add(swingForce);

    if (location.x <= width/2 + 3 && location.x >= width/2 - 3) {
      PVector upward = new PVector(0, -0.01);
      acceleration.add(upward);
    }
  }

  void checkForFloor() {
    if (location.y >= height - 16) {
      velocity.mult(0);
    }
  }
}


Feather f;


void setup() {
  size(400, 400);
  f = new Feather(100, 50);
}

void draw() {
  background(51);
  f.display();
  f.update();
}
