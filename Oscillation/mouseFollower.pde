class Mover {
  PVector location = new PVector(width/2, height/2);
  PVector acceleration = new PVector(0, 0);
  PVector velocity = new PVector(0, 0);


  void display() {
    // float angle =  atan(velocity.y / velocity.x);
    float angle = velocity.heading();
    stroke(255);
    fill(255);
    pushMatrix();
    rectMode(CENTER);
    translate(location.x, location.y);
    rotate(angle);
    rect(0, 0, 30, 10);
  }

  void update() {
    velocity.add(acceleration);
    velocity.limit(5);
    location.add(velocity);

    acceleration.mult(0);
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }
}


Mover m;


void setup() {
  size(640, 480);
  m = new Mover()
}

void draw() {
  background(51);
  PVector mouse = new PVector(mouseX, mouseY);
  PVector direction = PVector.sub(mouse, m.location);
  direction.normalize();
  m.applyForce(direction);
  m.display();
  m.update();
}
