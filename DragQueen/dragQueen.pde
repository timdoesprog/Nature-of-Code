class Circle {
  private PVector location = new PVector(random(32, width - 64), random(-350, -50));
  private PVector velocity = new PVector(0, random(0.5, 1.0));
  private boolean selected = false;
  public String shade;

  public Circle() {
    int choice = int(random(0, 7));
    if (choice == 0) {
      shade = "PINK";
    }
    else if (choice <= 2) {
      shade = "RED";
    }
    else if (choice <= 4) {
      shade = "GREEN";
    }
    else {
      shade = "BLUE";
    }
  }

  public void display() {
    stroke(0);
    if (shade == "PINK") {
      fill(255,20,147);
    }
    else if (shade == "RED") {
      fill(255, 0, 0);
    }
    else if (shade == "GREEN") {
      fill(0, 255, 0);
    }
    else {
      fill(0, 0, 255);
    }
    ellipse(location.x, location.y, 32, 32);
  }

  public void update() {
    draggable();
    location.add(velocity);
  }

  public boolean hitBottom() {
    return location.y > height + 32;
  }

  private void draggable() {
    if (mousePressed && (mouseButton == LEFT)) {
      PVector mousePos = new PVector(mouseX, mouseY);
      if (selected) {
        location = mousePos;
      }
      else if (isInside(mousePos) && mousePressed && (!dragging)) {
        selected = true;
        dragging = true;
      }
    }
    if (!mousePressed) {
      selected = false;
      dragging = false;
    }
  }

  public boolean isInside(PVector goal) {
    PVector distanceV = PVector.sub(goal, location);
    return distanceV.mag() < 16;
  }
}


void showContainers() {
  float yCoord = height - 30;
  stroke(0);
  // red container
  fill(255, 0, 0);
  rect(0, yCoord, 1/4 * width, 30);
  // green container
  fill(0, 255, 0);
  rect(1/4 * width, yCoord, 1/4 * width, 30);
  // blue container
  fill(0, 0, 255);
  rect(2/4 * width, yCoord, 1/4 * width, 30);
  // pink container
  fill(255,20,147);
  rect(3/4 * width, yCoord, 1/4 * width, 30);
}


void countScore(float x, String shade) {
  if (x <= 1/4 * width && shade == "RED") {
    counter++;
  }
  else if (x > 1/4 * width && x <= 2/4 * width && shade == "GREEN") {
    counter++;
  }
  else if (x > 2/4 * width && x <= 3/4 * width && shade == "BLUE") {
    counter++;
  }
  else if (x > 3/4 * width && x <= width && shade == "PINK") {
    counter += 2;
  }
  else {
    lifePoints--;
  }
}


Circle[] circles;
boolean dragging = false;
boolean playing = true;
int counter = 0;
int lifePoints = 20;

void setup() {
  size(320, 520);
  circles = new Circle[10];
  for (int i = 0; i < circles.length; i++) {
    circles[i] = new Circle()
  }
}

void draw() {
  background(255,192,203);
  if (playing) {
    for (int i = 0; i < circles.length; i++) {
      circles[i].display();
      circles[i].update();
      if (circles[i].hitBottom()) {
        float x = circles[i].location.x;
        countScore(x, circles[i].shade);
        circles[i] = new Circle();
      }
      if (lifePoints <= 0) {
        playing = false;
        break;
      }
    }
    textSize(32);
    fill(255);
    text(counter, 5, 32);
    fill(0);
    text(lifePoints, width - 40, 32);
    showContainers();
  }
  else {
    textSize(32);
    fill(255);
    text(counter, width/2 - 20, height/2);
  }
}
