class Mover {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  int radius;


  Mover(int _radius) {
    location = new PVector(random(width), random(height) + 20);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    radius = _radius;
    mass = radius / 16;
  }

  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);
  }

  void display() {
    stroke(0);
    fill(150);
    ellipse(location.x, location.y, radius * 2, radius * 2);
  }

  void checkEdges() {
    if (location.x > width - radius) {
      location.x = width - radius;
      velocity.x *= -1;
    } else if (location.x < 0 + radius) {
      velocity.x *= -1;
      location.x = 0 + radius;
    }

    if (location.y > height - radius) {
      velocity.y *= -1;
      location.y = height - radius;
    }
  }
}


Mover[] movers = new Mover[100];


void setup() {
  size(720, 360);
  PVector wind = new PVector(0.01,0);
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover(random(5, 30));
    // to make lighter objects fall as fast as heavier ones
    float m = movers[i].mass;
    PVector gravity = new PVector(0, 0.1 * m);
    movers[i].applyForce(wind);
    movers[i].applyForce(gravity);
  }
}

void draw() {
  background(255);
  for (int i = 0; i < movers.length; i++) {
    movers[i].update();
    movers[i].checkEdges();
    movers[i].display();
  }
}
