class Attractor {
  float mass;
  PVector location;
  float G = 1;

  Attractor(float m) {
    location = new PVector(width/2, height/2);
    mass = m;
  }

  void display() {
    stroke(0);
    fill(0);
    ellipse(location.x, location.y, mass * 16, mass * 16);
  }

  PVector attract(Mover mover) {
    PVector force = PVector.sub(location, mover.location);
    float distance = force.mag();
    // too close would be to strong, too far away would be too weak
    distance = constrain(distance, 5.0, 25.0);
    force.normalize();
    float strength = (G * mass * mover.mass) / (distance * distance);

    force.mult(strength);
    return force;
  }
}


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

  void checkEdges() {
    if (location.x > width - length) {
      location.x = width - length;
      velocity.x *= -1;
    } else if (location.x < 0 + length) {
      velocity.x *= -1;
      location.x = 0 + length;
    }

    if (location.y > height - length) {
      velocity.y *= -1;
      location.y = height - length;
    }
  }

  void applyForce(PVector force) {
    PVector a = PVector.div(force, mass);
    acceleration.add(a);
  }
}


Mover[] m;
Attractor a;


void setup() {
  size(640, 320);
  m = new Mover[15];
  for (int i = 0; i < m.length; i++) {
    m[i] = new Mover(random(0.5, 2), new PVector(random(width), random(height)));
  }
  a = new Attractor(3);
}

void draw() {
  background(51);
  a.display();
  for (int i = 0; i < m.length; i++) {
    PVector force = a.attract(m[i]);
    m[i].applyForce(force);
    m[i].display();
    m[i].update();
    m[i].checkEdges();
  }
}
