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

class Firework {
  PVector location;
  PVector velocity;
  PVector gravity;
  ArrayList<Particle> particles;
  boolean exploded = false;

  Firework(float x, float y) {
    location = new PVector(x, y);
    velocity = new PVector(0, random(-3, -4));
    gravity = new PVector(0, 0.02);
  }

  void display() {
    if (!exploded) {
      noStroke();
      fill(255);
      ellipse(location.x, location.y, 16, 16);
    }
    else {
      for (Particle p : particles) {
        p.display();
        p.update();
      }
    }
  }

  void explode() {
    exploded = true;
    particles = new ArrayList<Particle>();
    for (int i = 0; i < 20; i++) {
      particles.add(new Particle(location.x, location.y));
    }
  }

  void update() {
    velocity.add(gravity);
    location.add(velocity);
  }

  boolean peak() {
    return velocity.y >= 0;
  }
}


ArrayList<Firework> fireworks;


void setup() {
  size(1200, 400);
  fireworks = new ArrayList<Firework>();
}

void draw() {
  background(51);
  if (frameCount % 30 == 0) {
    fireworks.add(new Firework(random(width), height));
  }
  for (Firework f : fireworks) {
    f.display();
    f.update();
    if (f.peak() && !f.exploded) {
      f.explode();
    }
  }
}
