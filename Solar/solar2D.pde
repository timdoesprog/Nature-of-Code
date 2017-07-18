class Planet {
  float radius;
  float angle;
  float distance;
  float orbitSpeed;
  Planet[] planets;

  Planet(float r, float d, float o) {
    radius = r;
    distance = d;
    angle = random(TWO_PI);
    orbitSpeed = o;
  }

  void display() {
    pushMatrix();
    rotate(angle);
    translate(distance, 0);
    noStroke();
    fill(255);
    ellipse(0, 0, radius*2, radius*2);
    if (planets) {
      for (int i = 0; i < planets.length; i++) {
        planets[i].display();
      }
    }
    popMatrix();
  }

  void spawnMoons(int total) {
    if (total <= 0) {
      return;
    }
    planets = new Planet[total];
    for (int i = 0; i < planets.length; i++) {
      float r = radius/2;
      float d = random(75, 200);
      planets[i] = new Planet(r, d, random(0.01, 0.03));
      planets[i].spawnMoons(total-2);
    }
  }

  void orbit() {
    angle += orbitSpeed;
    if (planets) {
      for (int i = 0; i < planets.length; i++) {
        planets[i].orbit();
      }
    }
  }
}


Planet sun;


void setup() {
  size(600, 600);
  sun = new Planet(40, 0, 0);
  sun.spawnMoons(3);
}

void draw() {
  background(51);
  translate(width/2, height/2);
  sun.display();
  sun.orbit();
}
