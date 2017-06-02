class Mover {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float speed = 0.01;
  float limit = 5;

  Mover() {
    location = new PVector(random(width), random(height));
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
  }

  void update() {
    keyInput();
    velocity.add(acceleration);
    velocity.limit(limit);
    location.add(velocity);
    mover.checkEdges();
  }

  void display() {
    stroke(0);
    fill(150);
    ellipse(location.x, location.y, radius * 2, radius * 2);
  }

  void checkEdges() {
    if (location.x > width + radius) {
      location.x = 0 - radius;
    } else if (location.x < 0 - radius) {
      location.x = width + radius;
    }

    if (location.y > height + radius) {
      location.y = 0 - radius;
    } else if (location.y < 0 - radius) {
      location.y = height + radius;
    }
  }

  void keyInput() {
    if (key == CODED) {
      if (keyCode == LEFT) {
        acceleration.x = - speed;
      }
      else if (keyCode == RIGHT) {
        acceleration.x = speed;
      }
      else if (keyCode == UP) {
        acceleration.y = - speed;
      }
      else if (keyCode == DOWN) {
        acceleration.y = speed;
      }
      else {
        acceleration.x = 0;
      }
    }
  }
}

Mover mover;
int radius = 16;

void setup() {
  size(720, 360);
  mover = new Mover();
}

void draw() {
  background(255);
  mover.update();
  mover.display();
}
