class PVector {
  float x, y;

  PVector(float x_, float y_) {
    x = x_;
    y = y_;
  }

  void add(PVector vector) {
    x += vector.x;
    y += vector.y;
  }
}

PVector location;
PVector velocity;

void setup() {
  size(800, 300);
  location = new PVector(width / 2, height / 2);
  velocity = new PVector(1.5, 3.3);
}

void draw() {
  background(255);
  if (location.x < 16 || location.x > width - 16) {
    velocity.x *= -1;
  }
  if (location.y < 16 || location.y > height - 16) {
    velocity.y *= -1;
  }
  location.add(velocity);
  stroke(0);
  fill(99);
  ellipse(location.x, location.y, 32, 32);
}
