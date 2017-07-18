class Particle{
  PVector location;
  PVector velocity;
  PVector gravity;
  color c = color(random(255), random(255), random(255));

  Particle(float x, float y) {
    location = new PVector(x, y);
    velocity = PVector.random2D();
    gravity = new PVector(0, 0.02);
  }

  void display() {
    noStroke();
    fill(c, 200);
    ellipse(location.x, location.y, 2, 2);
    fill(c, 150);
    ellipse(location.x, location.y, 4, 4);
    fill(c, 110);
    ellipse(location.x, location.y, 8, 8);
    fill(c, 30);
    ellipse(location.x, location.y, 16, 16);
  }

  void update() {
    velocity.add(gravity);
    location.add(velocity);
  }

  boolean isOutsideWindow() {
    if (location.x < 0 || location.x > width || location.y < 0 || location.y > height) {
      return true;
    }
    return false;
  }
}


ArrayList<Particle> particles = new ArrayList<Particle>();


void setup() {
  size(1200, 400);
}

void draw() {
  background(51);
  // if (frameCount % 60 == 0) {
  //   particles.add(new Particle(mouseX, mouseY));
  // }
  particles.add(new Particle(mouseX, mouseY));
  for (int i = particles.size() - 1; i >= 0; i--) {
    Particle p = particles.get(i);
    p.display();
    p.update();
    if (p.isOutsideWindow()) {
      particles.remove(i);
    }
  }

}
