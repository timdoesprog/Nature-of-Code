class Star {

  PVector loc = new PVector(random(width), random(height));
  float base = random(1, 3);
  float size = random(2, 8);
  int brightness;
  // boolean brightening = true;
  // float changeRate = random(2, 8);
  int period = int(random(75, 150));

  void display() {
    stroke(brightness);
    fill(brightness);
    // upward triangle
    triangle(loc.x - base, loc.y, loc.x, loc.y - size, loc.x + base, loc.y);
    // left triangle
    triangle(loc.x, loc.y - base, loc.x + size, loc.y, loc.x, loc.y + base);
    // right triangle
    triangle(loc.x, loc.y - base, loc.x - size, loc.y, loc.x, loc.y + base);
    // downward triangle
    triangle(loc.x - base, loc.y, loc.x, loc.y + size, loc.x + base, loc.y);
  }

  void update() {
    // if (brightening) {
    //   brightness += changeRate;
    //   if (brightness >= 255 - changeRate) {
    //     brightening = false;
    //   }
    // }
    // else {
    //   brightness -= changeRate;
    //   if (brightness <= 0 + changeRate) {
    //     brightening = true;
    //   }
    // }

    // new brightness change with sine
    brightness = int(abs(sin(TWO_PI * frameCount/period)) * 255);
  }
}


Star[] stars;

void setup() {
  size(480, 480);
  stars = new Star[50];
  for (int i = 0; i < stars.length; i++) {
    stars[i] = new Star();
  }
}

void draw() {
  background(0);
  for (int i = 0; i < stars.length; i++) {
    stars[i].update();
    stars[i].display();
  }
}
