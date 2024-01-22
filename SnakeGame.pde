int grid = 20; // How big each grid square will be
PVector food;
int speed = 10;
boolean dead = true;
int highscore = 0;
Snake snake;

float angle = 0.0;
float angleSpeed = 0.05;
float foodSizeAmplitude = 5; // Adjust the amplitude to control the size change

void setup() {
  size(500, 500);
  snake = new Snake();
  food = new PVector();
  newFood();
  //frameRate(8);
}

void draw() {
  background(255);
  fill(255);
  if (!dead) {

    if (frameCount % speed == 0) {
      snake.update();
    }
    snake.show();
    snake.eat();

    // Add animation to the food
    angle += angleSpeed;
    float foodSize = grid + foodSizeAmplitude * sin(angle); // Change the size of the food
    ellipse(food.x + grid / 2, food.y + grid / 2, foodSize, foodSize);

    textAlign(LEFT);
    textSize(15);
    fill(0);
    text("Score: " + snake.len, 10, 20);
  } else {
    textSize(25);
    textAlign(CENTER, CENTER);
    fill(0);
    text("Snake Game\nClick to start" + "\nHighscore: " + highscore, width/2, height/2);
  }
}

void newFood() {
  food.x = floor(random(width));
  food.y = floor(random(height));
  food.x = floor(food.x/grid) * grid;
  food.y = floor(food.y/grid) * grid;
}

void mousePressed() {
  if (dead) {
    snake = new Snake();
    newFood();
    speed = 10;
    dead = false;
  }
}
