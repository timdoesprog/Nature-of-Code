class Mover {
  PVector location;
  PVector velocity = new PVector(0, 0);
  PVector acceleration = new PVector(0, 0);

  float mass;
  float length;
  float angle = 0;
  float aVelocity = 0;
  float aAcceleration = 0;

  Mover(float m, PVecor v) {
    mass = m;
    length = mass*16;
    location = v;
  }

  void display() {
    stroke(0);
    fill(255);
    rectMode(CENTER);
    pushMatrix();

    translate(location.x, location.y);
    rotate(angle);
    rect(0, 0, length, length);
    popMatrix();
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);

    aAcceleration = acceleration.x / 10.0;

    aVelocity += aAcceleration;
    aVelocity = constrain(aVelocity,-0.1,0.1);
    angle += aVelocity;

    acceleration.mult(0);
  }

  void applyForce(PVector force) {
    PVector a = PVector.div(force, mass);
    acceleration.add(a);
  }
}



Mover ball;
PVector gravity = new PVector(0, 0.1);

void setup() {
  size(720, 360);
  ball = new Mover(2, new PVector(0, height - 50));
  ball.applyForce(new PVector(10, -10));
}

void draw() {
  background(51);
  ball.applyForce(gravity);
  ball.display();
  ball.update();
}
