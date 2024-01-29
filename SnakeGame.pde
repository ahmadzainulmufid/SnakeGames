// Import Minim library for audio handling
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

// Initialize variables
int grid = 20; // How big each grid square will be
PVector food;
int speed = 10;
boolean dead = true;
int highscore = 0;
Snake snake;
PVector bomb;

// Variables for animated elements
float angle = 0.0;
float angleSpeed = 0.02;
float foodSizeAmplitude = 15; // Adjust the amplitude to control the size change
float bombSizeAmplitude = 15;

// Variables for background and image handling
PImage backgroundImage; // Declare PImage variable for background image
PImage fruitImage; // Declare PImage variable for fruit image
float fruitScale = 12; // Adjust the scale factor for the fruit
PImage bombImage; 
float bombScale = 12; 

// Minim library objects for audio handling
Minim minim;
AudioPlayer gameSound;
AudioPlayer gameOverSound;
AudioPlayer foodSound;

void setup() {
  // Set up canvas size
  size(800, 800);

  // Load background image
  backgroundImage = loadImage("background.jpg");
  backgroundImage.resize(width, height); // Resize the image to fit the canvas

  // Load fruit image
  fruitImage = loadImage("fruit.png");
  fruitImage.resize((int) (grid * fruitScale), (int) (grid * fruitScale)); // Resize the fruit image with scale factor

  // Load bomb image
  bombImage = loadImage("bomb.png");
  bombImage.resize((int) (grid * bombScale), (int) (grid * bombScale)); // Resize the bomb image with scale factor

  // Initialize game elements
  snake = new Snake();
  food = new PVector();
  bomb = new PVector();
  newFood();
  newBomb();

  // Initialize Minim library
  minim = new Minim(this);

  // Load game sound
  gameSound = minim.loadFile("Kevin MacLeod - 8bit Dungeon Boss.mp3");

  // Load game over sound
  gameOverSound = minim.loadFile("videogame-death-sound-43894.mp3");

  // Load food sound
  foodSound = minim.loadFile("570636__bsp7176__food.mp3");
}

void draw() {
  // Draw background image
  image(backgroundImage, 0, 0);

  // Check if the player is alive
  if (!dead) {
    // Draw border
    drawBorder();

    // Update and display snake
    if (frameCount % speed == 0) {
      snake.update();
    }
    snake.show();
    snake.eat();

    // Animate food size
    angle += angleSpeed;
    float foodSize = grid + (foodSizeAmplitude * sin(angle))/5;
    image(fruitImage, food.x, food.y, foodSize * 1.5, foodSize * 1.5); // Enlarge the fruit

    // Animate bomb size
    angle += angleSpeed;
    float bombSize = grid + (bombSizeAmplitude * sin(angle))/5;
    image(bombImage, bomb.x, bomb.y, bombSize * 1.5, bombSize * 1.5); // Enlarge the bomb

    // Display score and lives
    textAlign(LEFT);
    fill(255);
    textSize(25);
    text("Score: " + snake.len, 14, 32);

    textAlign(LEFT);
    fill(255);
    textSize(25);
    text("Lives: " + snake.lives, 14, height - 10);
  } else {
    // Display game over message
    textSize(25);
    textAlign(CENTER, CENTER);
    fill(255);
    text("Snake Game\nClick to start" + "\nHighscore: " + highscore, width/2, height/2);
  }
}

// Draw border with bricks
void drawBorder() {
  // Set brick size and color
  int brickSize = 20;
  int brickColor = color(106,49,13); // Brown color

  // Draw horizontal bricks at the top and bottom
  for (int x = 0; x < width; x += brickSize) {
    fill(brickColor);
    rect(x, 0, brickSize, brickSize);
    rect(x, height - brickSize, brickSize, brickSize);
  }

  // Draw vertical bricks on the left and right sides
  for (int y = 0; y < height; y += brickSize) {
    fill(brickColor);
    rect(0, y, brickSize, brickSize);
    rect(width - brickSize, y, brickSize, brickSize);
  }
}

// Generate new food position
void newFood() {
  int borderSize = 20;
  food.x = floor(random(borderSize, width - borderSize));
  food.y = floor(random(borderSize, height - borderSize));
  food.x = floor(food.x / grid) * grid;
  food.y = floor(food.y / grid) * grid;
}

// Generate new bomb position
void newBomb() {
  int borderSize = 20;
  bomb.x = floor(random(borderSize, width - borderSize));
  bomb.y = floor(random(borderSize, height - borderSize));
  bomb.x = floor(bomb.x/grid) * grid;
  bomb.y = floor(bomb.y/grid) * grid;
}

// Mouse click event to start the game
void mousePressed() {
  if (dead) {
    // Reset game elements
    snake = new Snake();
    newFood();
    newBomb();
    speed = 20;
    dead = false;

    // Play game sound
    gameSound.rewind();
    gameSound.play();
  }
}
