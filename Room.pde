final int WALL_TOP_1 = 0;
final int WALL_TOP_2 = 1;
final int WALL_TOP_3 = 2;

final int WALL_1 = 3;
final int WALL_2 = 4;
final int WALL_3 = 5;

final int FOUNTAIN_TOP = 6;

final int HOLE_1 = 7;
final int HOLE_2 = 8;

final int BANNER_RED = 9;
final int BANNER_BLUE = 10;
final int BANNER_GREEN = 11;
final int BANNER_YELLOW = 12;

final int WALL_COLUMN_TOP = 13;
final int WALL_COLUMN_MID = 14;
final int WALL_COLUMN_BOT = 15;

final int WALL_GOO_TOP = 16;
final int WALL_GOO_BOT = 17;

final int WALL_TOP_LEFT = 18;
final int WALL_TOP_RIGHT = 19;
final int WALL_MID_LEFT = 20;
final int WALL_MID_RIGHT = 21;
final int WALL_FRONT_LEFT = 22;
final int WALL_FRONT_RIGHT = 23;

final int WALL_CORNER_TOP_LEFT = 24;
final int WALL_CORNER_TOP_RIGHT = 25;
final int WALL_CORNER_LEFT = 26;
final int WALL_CORNER_RIGHT = 27;
final int WALL_CORNER_BOTTOM_LEFT = 28;
final int WALL_CORNER_BOTTOM_RIGHT = 29;
final int WALL_CORNER_FRONT_LEFT = 30;
final int WALL_CORNER_FRONT_RIGHT = 31;

final int WALL_INNER_CORNER_L_TOP_LEFT = 32;
final int WALL_INNER_CORNER_L_TOP_RIGHT = 33;
final int WALL_INNER_CORNER_MID_LEFT = 34;
final int WALL_INNER_CORNER_MID_RIGHT = 35;
final int WALL_INNER_CORNER_T_TOP_LEFT = 36;
final int WALL_INNER_CORNER_T_TOP_RIGHT = 37;

final int FLOOR_1 = 0;
final int FLOOR_2 = 1;
final int FLOOR_3 = 2;
final int FLOOR_4 = 3;
final int FLOOR_5 = 4;
final int FLOOR_6 = 5;
final int FLOOR_7 = 6;
final int FLOOR_8 = 7;
final int FLOOR_LADDER = 8;

class Room {
  int rows;
  int cols;

  int[][] wall;
  int[][] floor;
  boolean[][] obstacle;

  Room(int r, int c) {
    r += 3;
    c += 2;
    rows = r;
    cols = c;

    wall = new int[r][c];
    floor = new int[r][c];
    obstacle = new boolean[r][c];
    create(r, c);
  }

  void create(int r, int c) {

    for (int[] i : wall) {
      Arrays.fill(i, -1);
    }

    for (int[] i : floor) {
      Arrays.fill(i, -1);
    }

    for (int j = 1; j < cols-1; j++) {
      // fill first and second row (excluding corners)
      wall[0][j] = WALL_TOP_2;
      obstacle[0][j] = true;
      wall[1][j] = WALL_2;
      obstacle[1][j] = true;
      wall[r-2][j] = WALL_TOP_2;
      wall[r-1][j] = WALL_2;
      obstacle[r-1][j] = true;
    }
    
    wall[r-1][0] = WALL_FRONT_LEFT;
    wall[r-1][c-1] = WALL_FRONT_RIGHT;
    wall[0][0] = WALL_TOP_LEFT;
    wall[0][c-1] = WALL_TOP_RIGHT;

    for (int i = 1; i < rows-1; i++) {
      wall[i][0] = WALL_MID_LEFT;
      obstacle[i][0] = true;
      wall[i][c-1] = WALL_MID_RIGHT;
      obstacle[i][c-1] = true;
    }

    for (int i = 1; i < r-1; i++) {
      for (int j = 1; j < c-1; j++) {
        floor[i][j] = FLOOR_1;
      }
    }
  }

  void access(int r, int c) {
    int actualr = r+2;
    int actualc = c+1;
  }

  boolean isObstacle (float x, float y) {
    return obstacle[floor(y)][floor(x)];
  }

  void display_walls() {
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {

        if (wall[i][j] == -1)
          continue;

        float tilex = j * tilew;
        float tiley = i * tileh;

        image(walls[wall[i][j]], tilex, tiley, tilew, tileh);
      }
    }
  }

  void display_floors() {
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {

        if (floor[i][j] == -1)
          continue;

        float tilex = j * tilew;
        float tiley = i * tileh;

        image(floors[floor[i][j]], tilex, tiley, tilew, tileh);
      }
    }
  }
}
