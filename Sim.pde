class GameOfLife {
  int res;
  int rows, cols;
  int[][] curr, next;
  boolean isUpdating = false;

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
    if (!isUpdating) {
      stroke(255, 255, 255, 100);
      strokeWeight(0.5);
      for (int i = 0; i < cols; i++) {
        line(i * res, 0, i * res, height);
      }
      for (int i = 0; i < rows; i++) {
        line(0, i * res, width, i * res);
      }
    }
  }

  void update() {
    if (isUpdating) {
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
