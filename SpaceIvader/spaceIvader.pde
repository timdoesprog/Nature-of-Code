class Obstacle {
  PVector location = new PVector(random(width), random(-500, -20));
  PVector velocity = new PVector(0, random(1, 2) + counter);
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
    // hit detection for the tip of the ship
    if (ship.location.x > location.x && ship.location.x < location.x + size) {
      if (ship.location.y - ship.size * 2 > location.y - ship.size * 2 &&
          ship.location.y - ship.size * 2 < location.y + size) {
        return true;
      }
    }
    // hit detection for the left point of the ship
    if (ship.location.x - ship.size > location.x &&
        ship.location.x - ship.size < location.x + size) {
      if (ship.location.y > location.y && ship.location.y < location.y + size) {
        return true;
      }
    }
    // hit detection for the right point of the ship
    if (ship.location.x + ship.size > location.x &&
        ship.location.x + ship.size < location.x + size) {
      if (ship.location.y > location.y && ship.location.y < location.y + size) {
        return true;
      }
    }
    return false;
  }

  boolean isHit(ArrayList<Missile> missiles) {
    for (int i = missiles.size() - 1; i >= 0; i--) {
      Missile m = missiles.get(i);
      if (m.location.x > location.x && m.location.x < location.x + size) {
        if (m.location.y > location.y && m.location.y < location.y + size) {
          ship.missiles.remove(i);
          return true;
        }
      }
    }
    return false;
  }
}


class Missile {
  PVector location;
  PVector velocity = new PVector(0, -3);
  float size = 2;

  Missile(PVector loc) {
    location = loc;
  }

  void display() {
    stroke(255);
    fill(255);
    ellipse(location.x, location.y, size, size);
  }

  void update() {
    location.add(velocity);
  }
}


class Spaceship {
  PVector location = new PVector(160, 530);
  float velocity = 4;
  float size = 8;
  boolean alive = true;
  boolean reloaded = true;
  ArrayList<Missile> missiles = new ArrayList<Missile>();

  void display() {
    if (alive) {
      stroke(219, 40, 20);
      fill(219, 40, 20);
      triangle(location.x - size, location.y, location.x, location.y - size * 2,
        location.x + size, location.y);
      for (Missile m : missiles) {
        m.display();
        m.update();
      }
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
    checkMissiles();
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

  void shoot() {
    missiles.add(new Missile(new PVector(location.x, location.y - size * 2)));
  }

  void checkMissiles() {
    for (int i = missiles.size() - 1; i >= 0; i--) {
      Missile m = missiles.get(i);
      if (m.location.y < -10) {
        missiles.remove(i);
      }
    }
  }
}


Spaceship ship;
Obstacle[] obstacles;
float counter = 0;


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
    if (obstacles[i]) {
      obstacles[i].display();
      if (obstacles[i].collided(ship)) {
        ship.alive = false;
      }
      obstacles[i].update();
      if (obstacles[i].location.y > height + 10) {
        obstacles[i] = new Obstacle();
      }
      if (obstacles[i].isHit(ship.missiles)) {
        obstacles[i] = null;
      }
    }
    else {
      obstacles[i] = new Obstacle();
    }
  }
  if (mousePressed && (mouseButton == LEFT) && ship.reloaded) {
    ship.shoot();
    ship.reloaded = false;
  }
  else if (!mousePressed) {
    ship.reloaded = true;
  }
  if (ship.alive) {
    counter += 0.0002;
  }
  else {
    textSize(32);
    fill(255);
    text(round(counter * 1000), width/3, height/2);
  }
}
