class Block {
  PVector location;
  PVector midPoint;
  float shade = 120;
  float length = 30;

  Block(float x, float y) {
    location = new PVector(x, y);
    midPoint = new PVector(location.x + length/2, location.y + length/2);
  }

  void display() {
    noStroke();
    fill(shade);
    rect(location.x, location.y, length, length);
  }
}


// distance from the middle
float r;
// angle
float theta = 0;
Block[] blocks = new Block[4];
float[] distances = new float[4];
float length = 30;


void setup() {
  size(500, 500);
  r = width/2 - 30;

  // left upper
  blocks[0] = new Block(width/2 - length, height/2 - length);
  // right upper
  blocks[1] = new Block(width/2, height/2 - length);
  // left down
  blocks[2] = new Block(width/2 - length, height/2);
  // right down
  blocks[3] = new Block(width/2, height/2);
}

void draw() {
  background(51);
  float x = r * cos(theta);
  float y = r * sin(theta);
  noStroke();
  fill(255);
  ellipse(x + width/2, y + height/2, 40, 40);
  theta += 0.01;

  for (int i = 0; i < blocks.length; i++) {
    // compute distance between sun and all squares
    PVector distance = PVector.sub(new PVector(x + width/2, y+height/2), blocks[i].midPoint);
    distances[i] = distance.mag();
  }
  // get the shortest distance and adjust shade
  int index = 0;
  for (int i = 1; i < distances.length; i++) {
    if (distances[i] < distances[index]) {
      index = i;
    }
  }
  blocks[index].shade = 255;

  for (Block b : blocks) {
    b.display();
  }
  blocks[index].shade = 120;
}
