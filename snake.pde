class Snake {
  PVector pos;
  PVector vel;
  ArrayList<PVector> hist;
  int len;
  int moveX = 0;
  int moveY = 0;
  int lives;
  boolean isTongueOut = false; // Menandakan apakah lidah sedang keluar
  int tongueTimer = 0; // Timer untuk mengatur kecepatan lidah

  Snake() {
    pos = new PVector(20, 20);
    vel = new PVector();
    hist = new ArrayList<PVector>();
    len = 0;
    lives = 3;
  }

  void update() {
    hist.add(pos.copy());

    float newX = pos.x + vel.x * grid;
    float newY = pos.y + vel.y * grid;

    // Check collision with the border
    if (newX >= 20 && newX < width && newY >= 10 && newY < height - 20) {
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
        // Handle collision with itself
        dead = true;

        // Play game over sound
        gameOverSound.rewind();
        gameOverSound.play();

        if (len > highscore) highscore = len;
      }
    }

    // Tambahkan logika untuk menjulurkan dan menyembunyikan lidah
    tongueTimer++;
    if (tongueTimer >= 5) { // Ubah angka ini untuk meningkatkan atau mengurangi kecepatan lidah
      isTongueOut = !isTongueOut;
      tongueTimer = 0;
    }
  }

  void eat() {
    float adjustedX = pos.x + 10;
    float adjustedY = pos.y + 10;

    // Check for food collision
    if (adjustedX >= food.x && adjustedX < food.x + grid && adjustedY >= food.y && adjustedY < food.y + grid) {
      len++;
      if (speed > 5) speed--;
      newFood();

      // Play food sound
      foodSound.rewind();
      foodSound.play();
    }

    // Check for bomb collision
    if (adjustedX >= bomb.x && adjustedX < bomb.x + grid && adjustedY >= bomb.y && adjustedY < bomb.y + grid) {
      len--;
      lives--;
      if (lives < 1) dead = true;
      if (speed > 5) speed--;
      newBomb();
    }
  }

 void show() {
  noStroke();

  // Animate the head of the snake with a menacing appearance
  float headSize = map(frameCount % 35, 0, 34, grid, grid * 1.5); // Menambahkan faktor skala pada ukuran kepala ular
  fill(196, 11, 11); // Warna merah gelap untuk tampilan menyeramkan

  // Gambar kepala ular berbentuk elips/peluru
  ellipse(pos.x + headSize / 2, pos.y + headSize / 2, headSize, headSize);

  // Gambar mata menyeramkan pada kepala ular
  float eyeSize = headSize * 0.2;
  float eyeOffset = headSize * 0.25;
  fill(255); // Warna putih untuk mata
  ellipse(pos.x + headSize * 0.4, pos.y + headSize * 0.4, eyeSize, eyeSize);
  ellipse(pos.x + headSize * 0.8, pos.y + headSize * 0.4, eyeSize, eyeSize);

  // Gambar pupil di dalam mata menyeramkan
  fill(0); // Warna hitam untuk pupil
  ellipse(pos.x + headSize * 0.4, pos.y + headSize * 0.4, eyeSize * 0.7, eyeSize * 0.7);
  ellipse(pos.x + headSize * 0.8, pos.y + headSize * 0.4, eyeSize * 0.7, eyeSize * 0.7);

  // Gambar senyum jahat
  fill(0); // Warna hitam untuk mulut
  float mouthSize = headSize * 0.4;
  float mouthX = pos.x + headSize * 0.5;
  float mouthY = pos.y + headSize * 0.7;
  arc(mouthX, mouthY, mouthSize, mouthSize, PI / 8, 7 * PI / 8);

  // Animasikan tubuh ular dengan sudut melengkung
  for (PVector p : hist) {
    float bodySize = map(frameCount % 35, 0, 34, grid, grid * 1.5); // Menambahkan faktor skala pada ukuran tubuh ular
    fill(255, 92, 31);

    // Gambar tubuh ular berbentuk elips/peluru
    ellipse(p.x + bodySize / 2, p.y + bodySize / 2, bodySize, bodySize);
  }
  // Tambahkan logika untuk menampilkan lidah
  if (isTongueOut) {
    drawTongue(headSize);
  }
}


  void drawTongue(float headSize) {
    // Gambar lidah
    fill(255, 1, 1); // Warna merah untuk lidah
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