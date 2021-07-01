//as usual messed up row vs column!!
class GameOfLife {
  int res;
  int rows, cols;
  int[][] curr, next;
  boolean isUpdating = false;
  boolean glider_flip = false;
  boolean grid_lines = false;
  boolean glider_remover = false;
  //speed variables in frames
  int time = 0;
  int last_update_time = -100;
  int update_frequency = 2;

  GameOfLife(int res_) {
    res = res_;
    rows = floor(height/res);
    cols = floor(width/res);
    init_grid();
  }

  void init_grid() {
    curr = new int[rows][cols];
    next = new int[rows][cols];
  }

  void pauseorresume() {
    isUpdating = !isUpdating;
  }

  void image_init(PImage img) {
    PImage scaled = createImage(cols, rows, RGB);
    scaled.copy(img, 0, 0, img.width, img.height, 0, 0, cols, rows);
    //pixellating
    scaled.loadPixels();
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        int index = i + j * cols;
        int b = floor(brightness(scaled.pixels[index]));
        if (b > 128) curr[j][i] = 1;
        else curr[j][i] = 0;
      }
    }
  }

  void glider_init(int x, int y, int value) {
    if (!glider_flip) {
      if (!isUpdating && x + 35 < cols && y + 4 < rows && y - 4 > 0) {
        curr[y][x] = value;
        curr[y+1][x] = value;
        curr[y][x+1] = value;
        curr[y+1][x+1] = value;
        curr[y][x+10] = value;
        curr[y+1][x+10] = value;
        curr[y+2][x+10] = value;
        curr[y-1][x+11] = value;
        curr[y+3][x+11] = value;
        curr[y-2][x+12] = value;
        curr[y+4][x+12] = value;
        curr[y-2][x+13] = value;
        curr[y+4][x+13] = value;
        curr[y+1][x+14] = value;
        curr[y-1][x+15] = value;
        curr[y+3][x+15] = value;
        curr[y][x+16] = value;
        curr[y+1][x+16] = value;
        curr[y+2][x+16] = value;
        curr[y+1][x+17] = value;
        curr[y][x+20] = value;
        curr[y-1][x+20] = value;
        curr[y-2][x+20] = value;
        curr[y][x+21] = value;
        curr[y-1][x+21] = value;
        curr[y-2][x+21] = value;
        curr[y-3][x+22] = value;
        curr[y+1][x+22] = value;
        curr[y-3][x+24] = value;
        curr[y+1][x+24] = value;
        curr[y-4][x+24] = value;
        curr[y+2][x+24] = value;
        curr[y-1][x+34] = value;
        curr[y-2][x+34] = value;
        curr[y-1][x+35] = value;
        curr[y-2][x+35] = value;
      }
    } else {
      if (!isUpdating && x - 35 > 0 && y + 4 < rows && y - 4 > 0) {
        curr[y][x] = value;
        curr[y+1][x] = value;
        curr[y][x-1] = value;
        curr[y+1][x-1] = value;
        curr[y][x-10] = value;
        curr[y+1][x-10] = value;
        curr[y+2][x-10] = value;
        curr[y-1][x-11] = value;
        curr[y+3][x-11] = value;
        curr[y-2][x-12] = value;
        curr[y+4][x-12] = value;
        curr[y-2][x-13] = value;
        curr[y+4][x-13] = value;
        curr[y+1][x-14] = value;
        curr[y-1][x-15] = value;
        curr[y+3][x-15] = value;
        curr[y][x-16] = value;
        curr[y+1][x-16] = value;
        curr[y+2][x-16] = value;
        curr[y+1][x-17] = value;
        curr[y][x-20] = value;
        curr[y-1][x-20] = value;
        curr[y-2][x-20] = value;
        curr[y][x-21] = value;
        curr[y-1][x-21] = value;
        curr[y-2][x-21] = value;
        curr[y-3][x-22] = value;
        curr[y+1][x-22] = value;
        curr[y-3][x-24] = value;
        curr[y+1][x-24] = value;
        curr[y-4][x-24] = value;
        curr[y+2][x-24] = value;
        curr[y-1][x-34] = value;
        curr[y-2][x-34] = value;
        curr[y-1][x-35] = value;
        curr[y-2][x-35] = value;
      }
    }
  }

  void glider_gun(int x, int y) {
    if (glider_remover) {
      glider_init(x, y, 0);
    } else glider_init(x, y, 1);
  }

  void change_state(int x, int y) {
    if (!isUpdating) {
      int state = curr[y][x];
      if (state == 1) {
        curr[y][x] = 0;
      } else curr[y][x] = 1;
    }
  }

  void randomise() {
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        if (random(1) < 0.5) {
          curr[i][j] = 1; // 1 is alive
        } else curr[i][j] = 0; //0 is dead
      }
    }
  }

  void render() {
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        int state = curr[j][i];
        if (state == 1) {
          fill(255);
          rect(i * res, j * res, res-1, res-1);
        }
      }
    }

    //some lines
    if (grid_lines) {
      stroke(255, 255, 255, 100);
      for (int i = 0; i < cols; i++) {
        if(i % 10 == 0){
        strokeWeight(1);
        }else strokeWeight(0.3);
        line(i * res, 0, i * res, height);
      }
      for (int i = 0; i < rows; i++) {
        if(i % 10 == 0){
        strokeWeight(1);
        }else strokeWeight(0.3);
        line(0, i * res, width, i * res);
      }
    }
  }

  void update() {
    if (isUpdating) {
      time++;
      if (time - last_update_time >= update_frequency) {
        last_update_time = time;

        for (int i = 0; i < rows; i++) {
          for (int j = 0; j < cols; j++) {
            int neighbors = 0;
            for (int x = -1; x < 2; x++) {
              for (int y = -1; y < 2; y++) {
                if (x == 0 && y == 0) {
                  continue;
                } else {
                  neighbors += curr[(i+x+rows)%rows][(j+y+cols)%cols];
                }
              }
            }

            int state = curr[i][j];
            if (state == 1 && (neighbors == 2 || neighbors == 3)) {
              next[i][j] = 1;
            } else if (state == 0 && neighbors == 3) {
              next[i][j] = 1;
            } else {
              next[i][j] = 0;
            }
          }
        }
        int[][] temp = next;
        next = curr;
        curr = temp;
      }
    }
  }
}
