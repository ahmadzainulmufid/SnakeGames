class Snake {
  PVector pos;  // Snake's head position
  PVector vel;  // Snake's velocity (direction of movement)
  ArrayList<PVector> hist;  // ArrayList to store snake's history (positions)
  int len;  // Length of the snake
  int moveX = 0;  // Directional indicator for X-axis
  int moveY = 0;  // Directional indicator for Y-axis
  int lives;  // Number of lives remaining
  boolean isTongueOut = false;  // Flag for tongue animation
  int tongueTimer = 0;  // Timer for controlling the tongue animation

  Snake() {
    pos = new PVector(20, 20);
    vel = new PVector();
    hist = new ArrayList<PVector>();
    len = 0;
    lives = 3;
  }

  void update() {
    // Add the current position to the history
    hist.add(pos.copy());

    // Calculate the new position based on velocity
    float newX = pos.x + vel.x * grid;
    float newY = pos.y + vel.y * grid;

    // Check if the new position is within the canvas borders
    if (newX >= 20 && newX < width && newY >= 10 && newY < height - 20) {
      pos.x = newX;
      pos.y = newY;
    } else {
      // Snake hit the border, set as dead
      dead = true;

      // Play game over sound
      gameOverSound.rewind();
      gameOverSound.play();

      // Update highscore if needed
      if (len > highscore) highscore = len;
    }

    // Update move indicators
    moveX = int(vel.x);
    moveY = int(vel.y);

    // Remove oldest positions if history size exceeds snake length
    if (hist.size() > len) {
      hist.remove(0);
    }

    // Check for collision with itself
    for (PVector p : hist) {
      if (p.x == pos.x && p.y == pos.y) {
        // Snake collided with itself, set as dead
        dead = true;

        // Play game over sound
        gameOverSound.rewind();
        gameOverSound.play();

        // Update highscore if needed
        if (len > highscore) highscore = len;
      }
    }

    // Handle tongue animation
    tongueTimer++;
    if (tongueTimer >= 10) { // Adjust the timer value for tongue animation speed
      isTongueOut = !isTongueOut;
      tongueTimer = 0;
    }
  }

  void eat() {
    float adjustedX = pos.x + 10;
    float adjustedY = pos.y + 10;

    // Check if snake's head overlaps with food
    if (adjustedX >= food.x && adjustedX < food.x + grid && adjustedY >= food.y && adjustedY < food.y + grid) {
      // Snake ate food, increase length and speed
      len++;
      if (speed > 5) speed--;
      newFood();

      // Play food sound
      foodSound.rewind();
      foodSound.play();
    }

    // Check if snake's head overlaps with bomb
    if (adjustedX >= bomb.x && adjustedX < bomb.x + grid && adjustedY >= bomb.y && adjustedY < bomb.y + grid) {
      // Snake hit a bomb, decrease length and lives
      len--;
      lives--;
      if (lives < 1) dead = true;
      if (speed > 5) speed--;
      newBomb();
    }
  }

  void show() {
    noStroke();

    // Calculate head size with a smoother animation
    float headSize = map(frameCount % 60, 0, 59, grid, grid * 1.5); // Adjust the map values for a slower animation

    // Draw snake's head
    fill(196, 11, 11);
    ellipse(pos.x + headSize / 2, pos.y + headSize / 2, headSize, headSize);

    // Draw snake's eyes
    float eyeSize = headSize * 0.2;
    fill(255);
    ellipse(pos.x + headSize * 0.4, pos.y + headSize * 0.4, eyeSize, eyeSize);
    ellipse(pos.x + headSize * 0.8, pos.y + headSize * 0.4, eyeSize, eyeSize);

    fill(0);
    ellipse(pos.x + headSize * 0.4, pos.y + headSize * 0.4, eyeSize * 0.7, eyeSize * 0.7);
    ellipse(pos.x + headSize * 0.8, pos.y + headSize * 0.4, eyeSize * 0.7, eyeSize * 0.7);

    // Draw snake's mouth
    fill(0);
    float mouthSize = headSize * 0.4;
    float mouthX = pos.x + headSize * 0.5;
    float mouthY = pos.y + headSize * 0.7;
    arc(mouthX, mouthY, mouthSize, mouthSize, PI / 8, 7 * PI / 8);

    // Animate snake's body with smoothly changing size
    for (PVector p : hist) {
      float bodySize = map(frameCount % 60, 0, 59, grid, grid * 1.5); // Adjust the map values for a slower animation
      fill(255, 92, 31);
      ellipse(p.x + bodySize / 2, p.y + bodySize / 2, bodySize, bodySize);
    }

    // Add logic to display tongue
    if (isTongueOut) {
      drawTongue(headSize);
    }
  }

  // Function to draw snake's tongue
  void drawTongue(float headSize) {
    fill(255, 1, 1);
    float tongueLength = headSize * 0.5;
    float tongueWidth = headSize * 0.3;
    float tongueX = pos.x + headSize * 0.5;
    float tongueY = pos.y + headSize * 0.8;
    float angle = atan2(vel.y, vel.x);
    float tongueEndX = tongueX + cos(angle) * tongueLength;
    float tongueEndY = tongueY + sin(angle) * tongueLength;
    triangle(tongueX, tongueY, tongueEndX - tongueWidth / 2, tongueEndY, tongueEndX + tongueWidth / 2, tongueEndY);
  }
}

// Function to handle mouse movement for controlling the snake's direction
void mouseMoved() {
  float dx = mouseX - snake.pos.x;
  float dy = mouseY - snake.pos.y;

  // Determine whether the change in x or y is greater
  if (abs(dx) > abs(dy)) {
    // Move left or right, but only if not already moving left or right
    if (dx > 0 && snake.vel.x != -1) {
      snake.vel.set(1, 0, 0);
    } else if (dx < 0 && snake.vel.x != 1) {
      snake.vel.set(-1, 0, 0);
    }
  } else {
    // Move up or down, but only if not already moving up or down
    if (dy > 0 && snake.vel.y != -1) {
      snake.vel.set(0, 1, 0);
    } else if (dy < 0 && snake.vel.y != 1) {
      snake.vel.set(0, -1, 0);
    }
  }
}
