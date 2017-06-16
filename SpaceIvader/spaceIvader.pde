class Obstacle {
  PVector location = new PVector(random(width), random(-500, -20));
  PVector velocity = new PVector(0, random(1, 2));
  float size = random(10, 20);

  void display() {
    stroke(255);
    fill(222);
    rect(location.x, location.y, size, size);
  }

  void update() {
    location.add(velocity);
  }

  boolean collided(Spaceship ship) {
    if (ship.location.x > location.x && ship.location.x < location.x + size) {
      if (ship.location.y > location.y && ship.location.y < location.y + size) {
        return true;
      }
    }
    return false;
  }
}


class Spaceship {
  PVector location = new PVector(160, 530);
  float velocity = 3;
  float size = 8;
  boolean alive = true;

  void display() {
    if (alive) {
      stroke(219, 40, 20);
      fill(219, 40, 20);
      triangle(location.x - size, location.y, location.x, location.y - size * 2,
        location.x + size, location.y);
    }
  }

  void update() {
    PVector mouse = new PVector(mouseX, mouseY);
    PVector dist = PVector.sub(mouse, location);
    if (dist.mag() > 1) {
      dist.normalize();
      dist.mult(velocity);
      location.add(dist);
      checkEdges();
    }
  }

  void checkEdges() {
    if (location.x > width - size) {
      location.x = width - size;
    }
    else if (location.x < 0 + size) {
      location.x = size;
    }
    if (location.y > height - size) {
      location.y = height - size;
    }
    else if (location.y < 0 + size) {
      location.y = size;
    }
  }

}


Spaceship ship;
Obstacle[] obstacles;


void setup() {
  size(320, 560);
  ship = new Spaceship();
  obstacles = new Obstacle[30];
  for (int i = 0; i < obstacles.length; i++) {
    obstacles[i] = new Obstacle();
  }
}

void draw() {
  background(0);
  ship.display();
  ship.update();
  for (int i = 0; i < obstacles.length; i++) {
    obstacles[i].display();
    if (obstacles[i].collided(ship)) {
      ship.alive = false;
    }
    obstacles[i].update();
    if (obstacles[i].location.y > height + 10) {
      obstacles[i] = new Obstacle();
    }
  }
}
