import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

int grid = 20; // How big each grid square will be
PVector food;
int speed = 10;
boolean dead = true;
int highscore = 0;
Snake snake;
PVector bomb;

float angle = 0.0;
float angleSpeed = 0.02;
float foodSizeAmplitude = 15; // Adjust the amplitude to control the size change
float bombSizeAmplitude = 15;

PImage backgroundImage; // Declare PImage variable for background image
PImage fruitImage; // Declare PImage variable for fruit image
float fruitScale = 12; // Adjust the scale factor for the fruit
PImage bombImage; 
float bombScale = 12; 

Minim minim;
AudioPlayer gameSound;
AudioPlayer gameOverSound;
AudioPlayer foodSound;

void setup() {
  size(800, 800);

  // Load background image
  backgroundImage = loadImage("background.jpg");
  backgroundImage.resize(width, height); // Resize the image to fit the canvas

  // Load fruit image
  fruitImage = loadImage("fruit.png");
  fruitImage.resize((int) (grid * fruitScale), (int) (grid * fruitScale)); // Resize the fruit image with scale factor
  
    // Load fruit image
  bombImage = loadImage("bomb.png");
  bombImage.resize((int) (grid * bombScale), (int) (grid * bombScale)); // Resize the fruit image with scale factor

  snake = new Snake();
  food = new PVector();
  bomb = new PVector();
  newFood();
  newBomb();
  //frameRate(100);
  
    minim = new Minim(this);

  // Load game sound
  gameSound = minim.loadFile("Kevin MacLeod - 8bit Dungeon Boss.mp3");

  // Load game over sound
  gameOverSound = minim.loadFile("videogame-death-sound-43894.mp3");
  // Load food sound
  foodSound = minim.loadFile("570636__bsp7176__food.mp3");
}

void draw() {
  image(backgroundImage, 0, 0);
  drawBorder();
  if (!dead) {
    if (frameCount % speed == 0) {
      snake.update();
    }
    snake.show();
    snake.eat();

    angle += angleSpeed;
    float foodSize = grid + (foodSizeAmplitude * sin(angle))/5;
    image(fruitImage, food.x, food.y, foodSize * 1.5, foodSize * 1.5); // Perbesar buah

    angle += angleSpeed;
    float bombSize = grid + (bombSizeAmplitude * sin(angle))/5;
    image(bombImage, bomb.x, bomb.y, bombSize * 1.5, bombSize * 1.5); // Perbesar bom

    textAlign(LEFT);
    fill(255);
    textSize(25);
    text("Score: " + snake.len, 14, 32);
    
    textAlign(LEFT);
    fill(255);
    textSize(25);
    text("Lives: " + snake.lives, 14, height - 10);
  } else {
    textSize(25);
    textAlign(CENTER, CENTER);
    fill(255);
    text("Snake Game\nClick to start" + "\nHighscore: " + highscore, width/2, height/2);
  }
}



void drawBorder() {
  // Set brick size and color
  int brickSize = 20;
  int brickColor = color(106,49,13); // White color

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


void newFood() {
  int borderSize = 20;
  food.x = floor(random(borderSize, width - borderSize));
  food.y = floor(random(borderSize, height - borderSize));
  food.x = floor(food.x / grid) * grid;
  food.y = floor(food.y / grid) * grid;
}

void newBomb() {
  int borderSize = 20;
  bomb.x = floor(random(borderSize, width - borderSize));
  bomb.y = floor(random(borderSize, height - borderSize));
  bomb.x = floor(bomb.x/grid) * grid;
  bomb.y = floor(bomb.y/grid) * grid;
}


void mousePressed() {
  if (dead) {
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
