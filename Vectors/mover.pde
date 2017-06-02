class Mover {
  PVector location;
  PVector velocity;
  PVector acceleration;
  PVector mouse;
  PVector direction;


  Mover() {
    location = new PVector(random(width), random(height));
    velocity = new PVector(0, 0);
  }

  void update() {
    mouse = new PVector(mouseX, mouseY);
    direction = PVector.sub(mouse, location);
    direction.normalize();
    acceleration = PVector.mult(direction, 0.03);
    velocity.add(acceleration);
    velocity.limit(10);
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
