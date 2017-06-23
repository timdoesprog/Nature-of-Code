class Food {
  PVector location = new PVector(random(width), random(height));

  void display() {
    stroke(0);
    fill(0);
    ellipse(location.x, location.y, 2, 2);
  }
}



class Eater {
  PVector location;
  PVector velocity = new PVector(random(-1, 1) + 2, random(-1, 1) + 2);
  float radius = random(4, 8);
  float lifePoints = 1000;
  boolean alive = true;
  float red = random(255);
  float green = random(255);
  float blue = random(255);

  Eater(PVector loc) {
    location = loc;
  }


  void display() {
    if (alive) {
      stroke(red, green, blue);
      fill(red, green, blue);
      ellipse(location.x, location.y, radius * 2, radius * 2);
    }
  }

  void update() {
    checkEdges();
    location.add(velocity);
    lifePoints -= 1;
    if (lifePoints < 0) {
      alive = false;
    }
    radius -= 0.001;
  }

  void checkEdges() {
    if (location.x > width - radius || location.x < 0 + radius) {
      velocity.x *= -1;
    }
    if (location.y > height - radius || location.y < 0 + radius) {
      velocity.y *= -1;
    }
  }

  boolean collidedWith(Food food) {
    PVector distanceVector = PVector.sub(food.location, location);
    return distanceVector.mag() < radius;
  }
}


ArrayList<Eater> eaters = new ArrayList<Eater>();
Food[] food = new Food[75];

void setup() {
  size(820, 560);
  for (int i = 0; i < food.length; i++) {
    food[i] = new Food();
  }
  for (int i = 0; i < 5; i++) {
    eaters.add(new Eater(new PVector(random(width), random(height))));
  }
}

void draw() {
  background(233);
  for (int i = 0; i < eaters.size(); i++) {
    Eater current = eaters.get(i);
    current.display();
    current.update();
    for (int j = 0; j < food.length; j++) {
      if (current.collidedWith(food[j])) {
        food[j] = new Food();
        current.lifePoints += 200;
        current.radius += 0.3;
        break;
      }
    }
  }
  for (int i = 0; i < food.length; i++) {
    food[i].display();
  }
}
