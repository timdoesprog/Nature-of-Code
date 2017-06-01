float time = 0;
Walker w;

class Walker {
  float x, y;
  float tx, ty;

  Walker() {
    x = width / 2;
    y = height / 2;
    tx = 0;
    ty = 1000;
  }

  void step() {
    // mapped directly to coordinates
    // x = map(noise(tx), 0, 1, 0, width);
    // y = map(noise(ty), 0, 1, 0, height);
    // mapped to step size
    float stepX  = map(noise(tx), 0, 1, -1, 1) * 4;
    float stepY  = map(noise(ty), 0, 1, -1, 1) * 4;
    x += stepX;
    y += stepY;
    tx += 0.01;
    ty += 0.01;
  }

  void display() {
    stroke(0);
    fill(0);
    ellipse(x, y, 16, 16);
  }
}


int posx = 0;
void drawGraph() {
  float y = noise(time) * 100;
  stroke(0);
  point(posx, y);
  time += 0.01;
  x++;
}

void perlinCircle() {
  background(255);
  float n = noise(time);
  float x = map(n, 0, 1, 0, width);
  ellipse(x, height / 2, 16, 16);
  time += 0.01;
}

void perlinWalker() {
  background(255);
  w.step();
  w.display();
}


void setup() {
  size(320, 160);
  background(255);
  w = new Walker();
}

void draw() {
  perlinWalker();
}
