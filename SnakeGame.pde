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
float angleSpeed = 0.05;
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

void setup() {
  size(500, 500);

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
  //frameRate(8);
  
    minim = new Minim(this);

  // Load game sound
  gameSound = minim.loadFile("Kevin MacLeod - 8bit Dungeon Boss.mp3");

  // Load game over sound
  gameOverSound = minim.loadFile("videogame-death-sound-43894.mp3");
}

void draw() {
  // Display background image
  image(backgroundImage, 0, 0);

  if (!dead) {
    if (frameCount % speed == 0) {
      snake.update();
    }
    snake.show();
    snake.eat();

    // Add animation to the food (fruit)
    angle += angleSpeed;
    float foodSize = grid + foodSizeAmplitude * sin(angle); // Change the size of the food
    image(fruitImage, food.x, food.y, foodSize, foodSize); // Display the fruit image

    // Add animation to the food (fruit)
    angle += angleSpeed;
    float bombSize = grid + bombSizeAmplitude * sin(angle); // Change the size of the food
    image(bombImage, bomb.x, bomb.y, bombSize, bombSize); // Display the fruit image
    
    textAlign(LEFT);
    fill(255);
    textSize(25);
    text("Score: " + snake.len, 14, 32);
  } else {
    textSize(25);
    textAlign(CENTER, CENTER);
    fill(255);
    text("Snake Game\nClick to start" + "\nHighscore: " + highscore, width/2, height/2);
  }
}

void newFood() {
  food.x = floor(random(width));
  food.y = floor(random(height));
  food.x = floor(food.x/grid) * grid;
  food.y = floor(food.y/grid) * grid;
}

void newBomb() {
  bomb.x = floor(random(width));
  bomb.y = floor(random(height));
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
