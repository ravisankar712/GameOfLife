GameOfLife gol;
int resolution = 13; //13;
PImage image;

void setup() {
  //size(640, 480);
  fullScreen();
  image = loadImage("and.png");
  gol = new GameOfLife(resolution);
  //gol.image_init(image);
  gol.update_frequency = 1;
}

void draw() {
  background(0);
  gol.update();
  gol.render();
}

void mousePressed() {
  int x = mouseX/resolution;
  int y = mouseY/resolution;
  if (mouseButton == LEFT) {
    gol.change_state(x, y);
  } else if (mouseButton == RIGHT) {
    gol.glider_gun(x, y);
  }
}

void keyPressed() {
  if (key == ' ') {
    gol.pauseorresume();
  }

  if (key == 'r') {
    gol.init_grid();
  }

  if (key == 'a') {
    gol.randomise();
  }
  
  if (key == 'f'){
    gol.glider_flip = !gol.glider_flip;
  }
  
  if (key == 'g'){
    gol.glider_remover = !gol.glider_remover;
  }
  
  if (key == 'l'){
    gol.grid_lines = !gol.grid_lines;
  }
}
