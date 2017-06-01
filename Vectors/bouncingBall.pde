int x = width / 2;
int y = height / 2;
int stepX = 2;
int stepY = -3;
int radius = 16;


// bouncing ball without vectors
void bounceCircle() {
  if (y < radius || y > height - radius) {
    stepY *= -1;
  }
  if (x < radius) {
    stepX = 2;
  }
  else if (x > width - radius) {
    stepX = -2;
  }
  x += stepX;
  y += stepY;
  ellipse(x, y, radius * 2, radius * 2);
}

void setup() {
  size(800, 300);
  background(255);
  stroke(0);
  fill(120);
  ellipse(x, y, 16, 16);
}

void draw() {
  background(255);
  bounceCircle();
}
