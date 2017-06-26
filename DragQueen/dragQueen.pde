class Circle {
  private PVector location = new PVector(random(32, width - 64), random(-200, -50));
  private PVector velocity = new PVector(0, random(0.5, 1.5));
  private boolean selected = false;

  public void display() {
    stroke(0);
    fill(255,20,147);
    ellipse(location.x, location.y, 32, 32);
  }

  public void update() {
    draggable();
    location.add(velocity);
    checkBottom();
  }

  private void checkBottom() {
    if (location.y > height + 64) {
      location.y = random(-200, -50);
      location.x = random(32, width - 64);
      lifePoints--;
    }
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

Circle[] circles;
boolean dragging = false;
boolean playing = true;
PVector goal;
int counter = 0;
int lifePoints = 100;

void setup() {
  size(320, 520);
  goal = new PVector(width - 32, height - 32);
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
      if (circles[i].isInside(goal)) {
        circles[i] = new Circle();
        counter++;
      }
      if (lifePoints <= 0) {
        playing = false;
        break;
      }
    }
    stroke(199,21,133);
    fill(199,21,133);
    ellipse(goal.x, goal.y, 32, 32);
    textSize(32);
    fill(255);
    text(counter, 5, 32);
    text(lifePoints, 5, height - 10);
  }
  else {
    textSize(32);
    fill(255);
    text(counter, width/2, height/2);
  }
}
