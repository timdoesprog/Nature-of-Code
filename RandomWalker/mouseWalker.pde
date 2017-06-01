class Node {
  int x;
  int y;
  Node next;

  Node(int posX, int posY, Node nextN) {
    x = posX;
    y = posY;
    next = nextN;
  }
}


class Queue {
  Node front;
  Node back;
  int length;

  Queue() {
    length = 0;
    front = null;
    back = null;
  }

  void add(int x, int y) {
    Node node = new Node(x, y, null);
    // empty queue
    if (front == null && back == null) {
      front = node;
      back = node;
    }
    else {
      back.next = node;
      back = back.next;
    }
    length++;
  }

  Node pop() {
    Node result = front;
    front = front.next;
    length--;
    return result;
  }
}


class Walker {
  int x;
  int y;
  Queue trail = new Queue();

  Walker(int posX, int posY) {
    x = posX;
    y = posY;
    trail.add(posX, posY);
  }

  void display() {
    stroke(0);
    point(x, y);
    if (trail.length == 100) {
      Node node = trail.pop();
      stroke(255);
      point(node.x, node.y);
    }
  }

  void step() {
    if (mouseX < x) {
      x--;
    }
    else if (mouseX > x) {
      x++;
    }
    if (mouseY < y) {
      y--;
    }
    else if (mouseY > y) {
      y++;
    }
    trail.add(x, y);
  }
}

Walker[] walkers;
int count = 1;


void setup() {
  size(700, 400);
  walkers = new Walker[count];
  for(int i = 0; i < walkers.length; i++) {
    walkers[i] = new Walker(int(random(width)), int(random(height)));
  }
  background(255);
}

void draw() {
  for(int i = 0; i < walkers.length; i++) {
    walkers[i].display();
    walkers[i].step();
  }
}
