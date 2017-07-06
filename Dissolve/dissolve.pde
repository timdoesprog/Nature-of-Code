class Particle {
  PVector location;
  PVector velocity = new PVector(0, 0);
  PVector acceleration = new PVector(0, 0.02);

  Particle(PVector v) {
    location = v;
  }

  void display() {
    stroke(255);
    point(location.x, location.y);
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);
  }
}


int length = 50;
int xOffset = 200;
int yOffset = 200;
PVector[][] cube = new PVector[length][length + 1];
ArrayList<Particle> particles = new ArrayList<Particle>();


void setup() {
  size(640, 480);
  for (int i = 0; i < length; i++) {
    for (int j = 0; j < length + 1; j++) {
      // null for empty spot
      if (j >= length) {
        cube[i][j] = null;
      }
      else {
        cube[i][j] = new PVector(i + xOffset, j + yOffset);
      }
    }
  }
}

void draw() {
  background(51);
  // draw cube with remaining points
  for (int i = 0; i < length; i++) {
    for (int j = 0; j < length + 1; j++) {
      if (cube[i][j]) {
        stroke(255);
        point(cube[i][j].x, cube[i][j].y);
      }
    }
  }
  // generate particles from these points with random chance
  for (int i = 0; i < length; i++) {
    for (int j = 0; j < length; j++) {
      if (cube[i][j] && (!cube[i][j + 1])) {
        int choice = int(random(0, 20));
        if (choice == 1) {
          Particle p = new Particle(cube[i][j]);
          cube[i][j] = null;
          particles.add(p);
          break;
        }
      }
    }
  }
  // display and update the falling particles
  for (Particle p : particles) {
    if (p) {
      p.display();
      p.update();
      if (p.location.y > height) {
        p = null;
      }
    }
  }
}
