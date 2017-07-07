float amplitudeX;
float amplitudeY;
float period = 150;

void setup() {
  size(640, 480);
  amplitudeX = width/2;
  amplitudeY = height/2;
}

void draw() {
  background(51);
  float x = sin(TWO_PI * frameCount/period) * amplitudeX + width/2;
  // float y = cos(TWO_PI * frameCount/period) * amplitudeY + height/2;
  float y = height/2;
  noStroke();
  fill(255);
  ellipse(x, y, 32, 32);
}
