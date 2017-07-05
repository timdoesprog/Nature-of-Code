class Drop {
  float x = random(width);
  float y = random(-500, -100);
  // higher z value == closer to the screen
  float z = random(0, 20);
  // closer to the screen == faster
  float yspeed = map(z, 0, 20, 2, 10);
  // closer to the screen == longer raindrop
  float length = map(z, 0, 20, 5, 10);
  boolean visible = true;

  void fall() {
    y = y + yspeed;
    if (y > height) {
      visible = true;
      y = random(-200, -100);
    }
  }

  void show() {
    if (visible) {
      float thick = map(z, 0, 20, .5, 1.5);
      strokeWeight(thick);
      stroke(20, 20, 70);
      line(x, y, x, y + length);
    }
  }
}


Drop[] drops = new Drop[500];

void setup() {
  size(640, 360);
  for (int i = 0; i < drops.length; i++) {
    drops[i] = new Drop();
  }
}

void draw() {
  background(200, 200, 200);
  for (int i = 0; i < drops.length; i++) {
    PVector mousePos = new PVector(mouseX, mouseY);
    PVector dropLocation = new PVector(drops[i].x, drops[i].y);
    PVector distance = PVector.sub(dropLocation, mousePos);
    if (distance.mag() < 50) {
      drops[i].visible = false;
    }
    drops[i].fall();
    drops[i].show();
  }
}
