class Node {
  Node next;
  float x;
  float y;
  Raindrop drop;

  Node(PVector loc) {
    x = loc.x;
    y = loc.y
    next = null;
  }

  Node(Raindrop rd) {
    drop = rd;
    next = null;
  }
}


class Queue {
  Node front;
  Node back;
  int length;

  Queue() {
    front = null;
    back = null;
    length = 0;
  }

  void add(PVector location) {
    Node newNode = new Node(location);
    if(front == null) {
      front = newNode;
      back = newNode;
      length++;
    }
    else {
      back.next = newNode;
      back = newNode;
      length++;
      checkLength();
    }
  }

  void add(Raindrop drop) {
    Node newNode = new Node(drop);
    if(front == null) {
      front = newNode;
      back = newNode;
      length++;
    }
    else {
      back.next = newNode;
      back = newNode;
      length++;
      checkLength();
    }
  }

  void checkLength() {
    if (length > 10) {
      front = front.next;
      length--;
    }
  }
}


class Raindrop {
  PVector location;
  PVector veloctiy;
  Queue trail;


  Raindrop() {
    location = new PVector(random(0, width), random(-50, -10));
    velocity = new PVector(0, 6);
    trail = new Queue();
  }

  void update() {
    trail.add(location);
    location.add(velocity);
  }

  void display() {
    noStroke();
    fill(0);
    ellipse(location.x, location.y, 6, 8);
    Node current = trail.front;
    while (current != null) {
      ellipse(current.x, current.y, 2, 3);
      current = current.next;
    }
  }
}

Queue drops;


void setup() {
  size(720, 480);
  drops = new Queue();
  for(int i = 0; i < 10; i++) {
    drops.add(new Raindrop())
  }
}

void draw() {
  background(190, 190, 170);
  int chance = random(0, 1000);
  if (chance > 990) {
    for(int i = 0; i < 10; i++) {
      drops.add(new Raindrop())
    }
  }
  Raindrop current = drops.front;
  while (current != null) {
    current.drop.display();
    current.drop.update();
    current = current.next;
  }
}
