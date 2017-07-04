class Ball {
  PVector location = new PVector(360, 240);
  PVector velocity = new PVector(2, 2);
  float radius = 5;

  void display() {
    stroke(250, 2, 60);
    fill(250, 2, 60);
    ellipse(location.x, location.y, radius * 2, radius * 2);
  }

  void update() {
    checkEdges();
    location.add(velocity);
  }

  void checkEdges() {
    if (location.y < 0 + radius) {
      velocity.y *= -1;
    }
    else if (location.y > height - radius) {
      velocity.y *= -1;
    }
  }

  boolean hitPlayer(Player player) {
    if (location.x < 15) {
      if (location.y > player.location.y && location.y < player.location.y + player.length) {
        player.colorCounter = 30;
        return true;
      }
    }
  }

  boolean hitComputer(Opponent o) {
    if (location.x > width - 15) {
      if (location.y > o.location.y && location.y < o.location.y + o.length) {
        return true;
      }
    }
  }
}


class Opponent {
  PVector location;
  Ball ball;
  float velocity = 2;
  float length = 75;
  float thickness = 5;

  Opponent(PVector loc, Ball b) {
    location = loc;
    ball = b;
  }

  void display() {
    stroke(200, 255, 0);
    fill(200,255,0);
    rect(location.x, location.y, thickness, length, thickness, length);
  }

  void update() {
    float midPoint = location.y + length/2;
    if (ball.location.y > midPoint) {
      location.y += velocity;
    }
    else if (ball.location.y < midPoint) {
      location.y += -velocity;
    }
    checkEdges();
  }

  void checkEdges() {
    if (location.y < 0) {
      location.y = 0;
    }
    else if (location.y > height - length) {
      location.y = height - length;
    }
  }
}



class Player {
  PVector location;
  float velocity = 2;
  float length = 75;
  float thickness = 5;
  float colorCounter = 0;

  Player(PVector loc) {
    location = loc;
  }

  void display() {
    stroke(200, 255, 0);
    if (colorCounter > 0) {
      fill(255, 255, 255);
      colorCounter--;
    }
    else {
      fill(200,255,0);
    }
    rect(location.x, location.y, thickness, length, thickness, length);
  }

  void update() {
    if (key == CODED) {
      if (keyCode == UP) {
        location.y -= velocity;
      }
      else if (keyCode == DOWN) {
        location.y += velocity;
      }
    }
    checkEdges();
  }

  void checkEdges() {
    if (location.y < 0) {
      location.y = 0;
    }
    else if (location.y > height - length) {
      location.y = height - length;
    }
  }
}


Player player;
Opponent computer;
Ball ball;


void setup() {
  size(720, 480);
  ball = new Ball();
  player = new Player(new PVector(5, height/2 - 37));
  computer = new Opponent(new PVector(width - 10, height/2 - 37), ball);
}

void draw() {
  background(4, 0, 4);
  player.display();
  player.update();

  computer.display();
  computer.update();

  ball.display();
  ball.update();

  if (ball.hitPlayer(player)) {
    ball.velocity.x *= -1;
  }

  if (ball.hitComputer(computer)) {
    ball.velocity.x *= -1;
  }
}

void keyReleased() {
  player.velocity = 0;
}

void keyPressed() {
  player.velocity = 2;
}
