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
