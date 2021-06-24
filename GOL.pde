GameOfLife gol;
int resolution = 2;
PImage image;

void setup(){
  //size(466, 329);
  fullScreen();
  image = loadImage("test.jpg");
  gol = new GameOfLife(resolution);
  gol.image_init(image);
  //gol.randomise();
}

void draw(){
  background(0);
  gol.update();
  gol.render();
}

void mousePressed(){
  int x = mouseX/resolution;
  int y = mouseY/resolution;
  gol.change_state(x, y);
}

void keyPressed(){
  if (key == ' '){
    gol.pauseorresume();
  }
  
  if (key == 'r'){
    gol.init_grid();
  }
}
