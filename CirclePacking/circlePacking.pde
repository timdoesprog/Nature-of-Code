class Circle {
  PVector location;
  float radius;
  boolean growing = true;
  int red = int(random(0, 255));
  int green = int(random(0, 255));
  int blue = int(random(0, 255));

  Circle(float x, float y) {
    location = new PVector(x, y);
    radius = 0;
  }

  void grow() {
    if (growing) {
      radius++;
    }
  }

  boolean hit() {
    return (location.x + radius > width || location.x - radius < 0 ||
       location.y + radius > height || location.y - radius < 0);
  }

  void display() {
    stroke(red, green, blue);
    strokeWeight(2);
    noFill();
    ellipse(location.x, location.y, radius * 2, radius * 2);
  }
}


ArrayList<Circle> circles;
boolean finished = false;


void setup() {
  size(640, 360);
  circles = new ArrayList<Circle>();
  circles.add(new Circle(random(width), random(height)));
}

void draw() {
  if (!finished) {
    background(51);
    int circleCounter = 0;
    for (int i = 0; i < 30; i++) {
      if (circleCounter < 5) {
        if (createCircle()) {
        circleCounter++;
        }
      }
    }
    if (circleCounter == 0) {
      finished = true;
    }
    for (Circle c : circles) {
      if (c.growing) {
        if (c.hit()) {
          c.growing = false;
        }
        for (Circles c2 : circles) {
          if (c2 != c) {
            PVector distance = PVector.sub(c.location, c2.location);
            if (distance.mag() - 2 < c.radius + c2.radius) {
              c.growing = false;
              c2.growing = false;
              break;
            }
          }
        }
      }
      c.display();
      c.grow();
    }
  }
}

boolean createCircle() {
  float x = random(width);
  float y = random(height);

  for (Cirlce c : circles) {
    PVector distance = PVector.sub(new PVector(x, y), c.location);
    if (distance.mag() < c.radius) {
      return false;
    }
  }

  circles.add(new Circle(x, y));
  return true;
}
