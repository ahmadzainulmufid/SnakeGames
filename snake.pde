class Snake {
  PVector pos;
  PVector vel;
  ArrayList<PVector> hist;
  int len;
  int moveX = 0;
  int moveY = 0;

  Snake() {
    pos = new PVector(0, 0);
    vel = new PVector();
    hist = new ArrayList<PVector>();
    len = 0;
  }

  void update() {
    hist.add(pos.copy());

    float easing = 0.1;
    pos.x += vel.x * grid;
    pos.y += vel.y * grid;
    moveX = int(vel.x);
    moveY = int(vel.y);

    // Apply wrapping to the snake's position
    pos.x = (pos.x + width) % width;
    pos.y = (pos.y + height) % height;

    if (hist.size() > len) {
      hist.remove(0);
    }

    for (PVector p : hist) {
      if (p.x == pos.x && p.y == pos.y) {
        // Handle collision logic
        dead = true;
        
              // Play game over sound
      gameOverSound.rewind();
      gameOverSound.play();
      
        if (len > highscore) highscore = len;
      }
    }
  }


  void eat() {
  if (pos.x == food.x && pos.y == food.y) {
    len++;
    if (speed > 5) speed--;
    newFood();
  }
}


void show() {
    noStroke();

    // Animate the head of the snake with a colorful gradient
    float headSize = map(frameCount % 30, 0, 29, grid, grid * 1.5);
    fill(255, 150, 150);
    rect(pos.x, pos.y, headSize, headSize, 10);

    // Animate the body of the snake with rounded corners
    for (PVector p : hist) {
      float bodySize = map(frameCount % 30, 0, 29, grid, grid * 1.5);
      fill(150, 255, 150);
      rect(p.x, p.y, bodySize, bodySize, 10);
    }
  }
}

void mouseMoved() {
  float dx = mouseX - snake.pos.x;
  float dy = mouseY - snake.pos.y;

  // Menentukan apakah perubahan x atau y yang lebih besar
  if (abs(dx) > abs(dy)) {
    // Bergerak kiri atau kanan, tetapi hanya jika sedang tidak bergerak ke kiri atau kanan
    if (dx > 0 && snake.vel.x != -1) {
      snake.vel.set(1, 0, 0);
    } else if (dx < 0 && snake.vel.x != 1) {
      snake.vel.set(-1, 0, 0);
    }
  } else {
    // Bergerak atas atau bawah, tetapi hanya jika sedang tidak bergerak ke atas atau bawah
    if (dy > 0 && snake.vel.y != -1) {
      snake.vel.set(0, 1, 0);
    } else if (dy < 0 && snake.vel.y != 1) {
      snake.vel.set(0, -1, 0);
    }
  }
}
