GameOfLife gol;
int resolution = 13; //use 13 for the logic gates;
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
  } else if (mouseButton == RIGHT) { //right click to make a glider gun
    gol.glider_gun(x, y);
  }
}

void keyPressed() {
  if (key == ' ') {
    gol.pauseorresume();
  }

  if (key == 'r') { //reset grid to all zeros
    gol.init_grid();
  }

  if (key == 'a') { //randomise the grid
    gol.randomise();
  }
  
  if (key == 'f'){ //flip the glider gun
    gol.glider_flip = !gol.glider_flip;
  }
  
  if (key == 'g'){ //toggle between add or remove
    gol.glider_remover = !gol.glider_remover;
  }
  
  if (key == 'l'){ //show or unshow the grid lines
    gol.grid_lines = !gol.grid_lines;
  }
}
