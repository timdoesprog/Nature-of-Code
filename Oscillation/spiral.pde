float r = 0;
float theta = 0;

void setup() {
  size(400, 400);
  background(51);
}

void draw() {
  float x = r * cos(theta);
  float y = r * sin(theta);
  noStroke();
  fill(255);
  ellipse(x + width/2, y + height/2, 4, 4);
  theta += 0.01;
  r += 0.01;
}
