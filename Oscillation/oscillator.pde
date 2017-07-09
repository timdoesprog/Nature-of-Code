class  Oscillator {
  PVector angle;
  PVector velocity;
  PVector acceleration;
  PVector amplitude;

  Oscillator() {
    angle = new PVector();
    velocity = new PVector();
    acceleration = new PVector(random(-0.0001, 0.0001), random(-0.0001, 0.0001));
    amplitude = new PVector(width/2, height/2);
  }

  void oscillate() {
    velocity.add(acceleration);
    velocity.limit(2);
    angle.add(velocity);
  }

  void display() {
    float x = sin(angle.x) * amplitude.x;
    float y = sin(angle.y) * amplitude.y;

    pushMatrix();
    translate(width/2, height/2);
    stroke(0);
    fill(255);
    line(0, 0, x, y);
    ellipse(x, y, 16, 16);
    popMatrix();
  }
}


Oscillator o;


void setup() {
  size(640, 480);
  o = new Oscillator();
}

void draw() {
  background(51);
  o.oscillate();
  o.display();
}
