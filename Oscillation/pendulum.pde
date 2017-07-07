float angle = 0;
float aVelocity = 0;
float aAcceleration = 0.0001;

void setup() {
  size(640, 480);
}

void draw() {
  background(255);
  fill(120);
  stroke(0);
  rectMode(CENTER);
  translate(width/2,height/2);
  rotate(angle);
  line(-50,0,50,0);
  ellipse(50,0,8,8);
  ellipse(-50,0,8,8);

  aVelocity += aAcceleration;
  angle += aVelocity;
}
