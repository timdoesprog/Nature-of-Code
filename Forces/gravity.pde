class Attractor {
  float mass;
  PVector location;
  float G = 1;

  Attractor(float mass_) {
    location = new PVector(width/2, height/2);
    mass = mass_;
  }

  void display() {
    stroke(0);
    fill(120);
    ellipse(location.x, location.y, mass * 4, mass * 4);
  }

  PVector attract(Mover mover) {
    PVector force = PVector.sub(location, mover.location);
    float distance = force.mag();
    distance = constrain(distance, 5.0, 25.0);
    force.normalize();
    float strength = (G * mass * mover.mass) / (distance * distance);

    force.mult(strength);
    return force;
  }
}


class Mover {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  float radius;


  Mover(float _radius, float x, float y) {
    location = new PVector(x, y);
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
    acceleration.mult(0);
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

  PVector attract(Mover mover) {
    PVector force = PVector.sub(location, mover.location);
    float distance = force.mag();
    distance = constrain(distance, 5.0, 25.0);
    force.normalize();
    float strength = (G * mass * mover.mass) / (distance * distance);

    force.mult(strength);
    return force;
  }
}


Mover[] movers;
// Attractor attractor;


void setup() {
  size(640, 480);
  movers = new Mover[10];
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover(random(8, 16), random(60, 400), random(60, 400));
  }
  // attractor = new Attractor(20);
}

void draw() {
  background(255);

  for (int i = 0; i < movers.length; i++) {
    // PVector force = attractor.attract(movers[i]);
    for (int j = 0; j < movers.length; j++) {
      if (j != i) {
        PVector force = movers[j].attract(movers[i]);
        movers[i].applyForce(force);
      }
    }
    movers[i].update();
    movers[i].display();
  }
  // attractor.display();
}
