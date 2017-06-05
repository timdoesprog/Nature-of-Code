class Mover {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  int radius;


  Mover(int _radius) {
    location = new PVector(random(width), 0);
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

  boolean isInside(Liquid liquid) {
    if (location.x > liquid.x && location.x < liquid.x + liquid.w
      && location.y > liquid.y && location.y < liquid.y + liquid.h) {
      return true;
    }
    else {
      return false;
    }
  }

  void drag(Liquid liquid) {
    float speed = velocity.mag();
    float dragMag = liquid.drag * speed * speed;

    PVector drag = velocity.get();
    drag.mult(-1);
    drag.normalize();

    drag.mult(dragMag);
    applyForce(drag);
  }
}


class Liquid {
  float x, y;
  float w, h;
  float drag;

  Liquid(float x_, float y_, float w_, float h_, float drag_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    drag = drag_;
  }

  void display() {
    noStroke();
    fill(175);
    rect(x, y, w, h);
  }
}


Mover[] movers = new Mover[100];
Liquid liquid;


void setup() {
  size(640, 320);
  liquid = new Liquid(0, height/2, width, height/2, 0.1);
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover(random(5, 30));
  }
}

void draw() {
  background(255);
  liquid.display();
  for (int i = 0; i < movers.length; i++) {

    if(movers[i].isInside(liquid)) {
      movers[i].drag(liquid);
    }

    // to make lighter objects fall as fast as heavier ones
    float m = movers[i].mass;
    PVector gravity = new PVector(0, 0.1 * m);
    movers[i].applyForce(gravity);

    movers[i].update();
    movers[i].checkEdges();
    movers[i].display();
  }
}
