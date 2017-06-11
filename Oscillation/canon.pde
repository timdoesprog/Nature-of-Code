class Ball {
  PVector location = new PVector(0, height/2);
  PVector velocity = new PVector(10, -0.5);
  PVector gravity = new PVector(0, 0.1);

  void display() {
    stroke(0);
    fill(125);
    ellipse(location.x, location.y, 20, 20);
  }

  void update() {
    velocity.add(gravity);
    // checkEdges();
    location.add(velocity);
  }

  // void checkEdges() {
  //   if (location.x > width  || location.x < 0) {
  //     velocity.x *= -1;
  //   }
  //   if (location.y > height || location.y < 0) {
  //     velocity.y *= -1;
  //   }
  // }
}


Ball ball = new Ball();

void setup() {
  size(720, 360);
}

void draw() {
  background(255);
  ball.display();
  ball.update();
}
