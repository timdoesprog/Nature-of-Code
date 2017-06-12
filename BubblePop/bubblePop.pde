class Bubble {
  PVector location;
  float radius;
  float red;
  float green;
  float blue;

  Bubble() {
    changeColor();
    radius = random(16, 32);
    randomLocation();
  }

  void display() {
    stroke(0);
    fill(red, green, blue);
    ellipse(location.x, location.y, radius * 2, radius * 2);
  }

  void changeColor() {
    red = random(0, 255);
    green = random(0, 255);
    blue = random(0, 255);
  }

  void randomLocation() {
    location = new PVector(random(0 + radius, width - radius),
      random(0 + radius, height - radius));
  }

  boolean isHit() {
    if (mousePressed && (mouseButton == LEFT)) {
      PVector mousePos = new PVector(mouseX, mouseY);
      PVector dist = PVector.sub(mousePos, location);
      return dist.mag() < radius;
    }
    return false;
  }
}

int count = 0;
Bubble[] bubbles = new Bubble[10];

void setup() {
  size(480, 320);
  for (int i = 0; i < bubbles.length; i++) {
    bubbles[i] = new Bubble();
  }
}

void draw() {
  background(233);
  if (random(0, 100) < 3) {
    for (int i = 0; i < bubbles.length; i++) {
      if (!bubbles[i]) {
        bubbles[i] = new Bubble();
        break;
      }
    }
  }
  for (int i = 0; i < bubbles.length; i++) {
    if (bubbles[i]) {
      bubbles[i].display();
    }
  }
  for (int i = 0; i < bubbles.length; i++) {
    if (bubbles[i]) {
      if (bubbles[i].isHit()) {
        bubbles[i] = null;
        count++;
      }
    }
  }
  println(count);
  // bub.display();
  // if (bub.isHit()) {
  //   bub.randomLocation();
  //   bub.changeColor();
  //   count++;
  // }
}
