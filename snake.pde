<<<<<<< HEAD
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

  float newX = pos.x + vel.x * grid;
  float newY = pos.y + vel.y * grid;

  // Tambahkan batasan tembok
  if (newX >= 0 && newX < width && newY >= 0 && newY < height) {
    pos.x = newX;
    pos.y = newY;
  } else {
    dead = true;
    
    // Play game over sound
    gameOverSound.rewind();
    gameOverSound.play();
    
    if (len > highscore) highscore = len;
  }

  moveX = int(vel.x);
  moveY = int(vel.y);

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

    // Play food sound
    foodSound.rewind();
    foodSound.play();
  }
  if (pos.x == bomb.x && pos.y == bomb.y) {
    len--;
    if (speed > 5) speed--;
    newBomb();
  }
}



void show() {
  noStroke();

  // Animate the head of the snake with a colorful gradient
  float headSize = map(frameCount % 30, 0, 29, grid, grid * 1.5);
  fill(255, 150, 150);

  // Draw elliptical/bullet-shaped head
  ellipse(pos.x + headSize / 2, pos.y + headSize / 2, headSize, headSize);

  // Draw eyes on the head
  float eyeSize = headSize * 0.2; // Adjust eye size
  float eyeOffset = headSize * 0.25; // Adjust eye offset

  fill(0); // Eye color
  ellipse(pos.x + headSize * 0.4, pos.y + headSize * 0.4, eyeSize, eyeSize);
  ellipse(pos.x + headSize * 0.8, pos.y + headSize * 0.4, eyeSize, eyeSize);

  // Draw pupils inside the eyes
  fill(255); // Pupil color (white)
  ellipse(pos.x + headSize * 0.4, pos.y + headSize * 0.4, eyeSize * 0.7, eyeSize * 0.7);
  ellipse(pos.x + headSize * 0.8, pos.y + headSize * 0.4, eyeSize * 0.7, eyeSize * 0.7);

  // Draw mouth
  fill(255); // Mouth color (white)

  // Adjust mouth position and size based on the snake's direction
  float mouthSize = headSize * 0.4;
  float mouthX = pos.x + headSize * 0.5;
  float mouthY = pos.y + headSize * 0.7;

  if (vel.x > 0) {
    arc(mouthX, mouthY, mouthSize, mouthSize, 0, PI / 2);
  } else if (vel.x < 0) {
    arc(mouthX, mouthY, mouthSize, mouthSize, PI / 2, PI);
  } else if (vel.y > 0) {
    arc(mouthX, mouthY, mouthSize, mouthSize, PI, TWO_PI);
  } else if (vel.y < 0) {
    arc(mouthX, mouthY, mouthSize, mouthSize, 0, PI);
  }

  // Animate the body of the snake with rounded corners
  for (PVector p : hist) {
    float bodySize = map(frameCount % 30, 0, 29, grid, grid * 1.5);
    fill(150, 255, 150);

    // Draw elliptical/bullet-shaped body
    ellipse(p.x + bodySize / 2, p.y + bodySize / 2, bodySize, bodySize);
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
=======
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

  float newX = pos.x + vel.x * grid;
  float newY = pos.y + vel.y * grid;

  // Tambahkan batasan tembok
  if (newX >= 0 && newX < width && newY >= 0 && newY < height) {
    pos.x = newX;
    pos.y = newY;
  } else {
    dead = true;
    
    // Play game over sound
    gameOverSound.rewind();
    gameOverSound.play();
    
    if (len > highscore) highscore = len;
  }

  moveX = int(vel.x);
  moveY = int(vel.y);

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
>>>>>>> 3d677e5f01094db782f23dac5bd962b190c9e5f8
