float period = 300;

void setup() {
  size(640, 480);
}

void draw() {
  background(51);
  float shade = abs(sin(TWO_PI * frameCount/period)) * 255;
  noStroke();
  fill(shade);
  ellipse(width/2, height/2, 32, 32);
}
