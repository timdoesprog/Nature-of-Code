class Walker {
  float x = width/2;
  float y = height/2;

  void step() {
    int xStep = round(random(-1, 1));
    int yStep = round(random(-1, 1));
    x += xStep;
    y += yStep;
  }

  void display() {
    stroke(255);
    point(x, y);
  }
}


int steps = 100;
int trials = 1000;
int currentStep = 0;
Walker w;


void setup() {
  size(500, 500);
  background(51);
  w = new Walker();
  stroke(255);
  noFill();
  rect(width/2 - 100, height/2 - 100, 200, 200);
}

void draw() {
  while (currentStep <= steps && trials > 0) {
    w.display();
    w.step();
    currentStep++;
  }
  w = new Walker();
  currentStep = 0;
  trials--;
  if (trials < 0) {
    println("finished");
  }
}
