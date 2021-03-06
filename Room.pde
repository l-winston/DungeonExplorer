import java.util.Collections;
import java.util.Comparator;

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


final int COLUMN_TOP = 0;
final int COLUMN_MID = 1;
final int COLUMN_BASE = 2;

class Room {

  ArrayList<Boundary> boundaries;
  ArrayList<Entity> entities;
  int rows;
  int cols;

  Wall[][] wall;
  int[][] floor;
  boolean[][] column;
  Room(int r, int c) {
    r += 4;
    c += 2;
    rows = r;
    cols = c;

    wall = new Wall[r][c];
    floor = new int[r][c];
    column = new boolean[r][c];
    entities = new ArrayList<Entity>();
    boundaries = new ArrayList<Boundary>();


    for (int[] i : floor) {
      Arrays.fill(i, -1);
    }
  }

  void addEntity(Entity e) {
    entities.add(e);
  }

  void stepAll() {
    for (Entity e : entities) {
      e.step();
    }
  }

  void createBox() {

    for (int j = 1; j < cols-1; j++) {
      // fill top and bottom rows
      wall[1][j] = Wall.FRONT;
      wall[0][j] = Wall.TOP_2;
      wall[rows-2][j] = Wall.FRONT;
      wall[rows-3][j] = Wall.TOP_2;
    }

    wall[rows-2][0] = Wall.FRONT_LEFT;
    wall[rows-2][cols-1] = Wall.FRONT_RIGHT;
    wall[0][0] = Wall.TOP_LEFT;
    wall[0][cols-1] = Wall.TOP_RIGHT;

    for (int i = 1; i < rows-2; i++) {
      wall[i][0] = Wall.LEFT;
      wall[i][cols-1] = Wall.RIGHT;
    }

    for (int i = 1; i < rows-2; i++) {
      for (int j = 1; j < cols-1; j++) {
        floor[i][j] = FLOOR_1;
      }
    }

    boundaries.add(new Boundary(0.5*tilew, rows/2*tileh, tilew, (rows-2)*tileh));
    boundaries.add(new Boundary((cols-0.5)*tilew, rows/2*tileh, tilew, (rows-2)*tileh));
    boundaries.add(new Boundary((cols/2)*tilew, (rows-1)*tileh, tilew*cols, tileh));
    boundaries.add(new Boundary((cols/2)*tilew, 1.5*tileh, tilew*cols, tileh));
  }

  void display() {
    ArrayList<Entity> left = new ArrayList<Entity>();
    left.addAll(entities);


    // sort entities by y value to make sure higher entities are drawn first
    Collections.sort(left, new Comparator<Entity>() {
      @Override
        public int compare(Entity o1, Entity o2) {
        return int(o2.walkbox.getPosition().y - o1.walkbox.getPosition().y);
      }
    }
    );


    for (int i = 0; i < rows-1; i++) {
      for (int j = 0; j < cols; j++) {

        ArrayList<Entity> toRemove = new ArrayList<Entity>();
        for (Entity e : left) {
          Vec2 pos = box2d.coordWorldToPixels(e.walkbox.getPosition());
          if (pos.y < (i+1) * tileh) {
            e.show();
            toRemove.add(e);
          }
        }

        left.removeAll(toRemove);

        float tilex = j * tilew;
        float tiley = i * tileh;

        if (wall[i][j] != null && !isTopPiece(wall[i][j])) {
          showWall(tilex, tiley, wall[i][j]);
        } 
        if (i-1 >= 0) {
          if (isTopPiece(wall[i-1][j])) {
            showWall(tilex, tiley-tileh, wall[i-1][j]);
          }
        }
        if (column[i][j]) {
          showColumn(tilex, tiley);
        }
      }
    }

    for (Entity e : left) {
      e.show();
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

  void setColumn(int i, int j) {
    if (column[i-1][j])
      return;
    column[i-1][j] = true;
    this.boundaries.add(new Boundary((j+0.5)*tilew, i * tileh, tilew / 5f));
  }
}

boolean isTopPiece(Wall w) {
  return w == Wall.TOP_1 || 
    w == Wall.TOP_2 ||
    w == Wall.TOP_3 ||
    w == Wall.TOP_RIGHT ||
    w == Wall.TOP_LEFT ||
    w == Wall.CORNER_TOP_LEFT ||
    w == Wall.CORNER_TOP_RIGHT ||
    w == Wall.CORNER_BOTTOM_LEFT ||
    w == Wall.CORNER_BOTTOM_RIGHT ||

    w == Wall.INNER_CORNER_L_TOP_LEFT ||
    w == Wall.INNER_CORNER_L_TOP_RIGHT ||
    w == Wall.INNER_CORNER_T_TOP_LEFT ||
    w == Wall.INNER_CORNER_T_TOP_RIGHT;
}

Room loadRoom(String fileName) {
  String[] strings = loadStrings(fileName);
  Scanner scan = new Scanner(strings[0]);
  int rows = scan.nextInt();
  int cols = scan.nextInt();
  scan.close();

  Room room = new Room(rows, cols);

  for (int i = 0; i < rows; i++) {
    scan = new Scanner(strings[i+1]);
    for (int j = 0; j < cols; j++) {
      int elem = scan.nextInt();
      if (elem == -1)
        room.wall[i][j] = null;
      else
        room.wall[i][j] = types[elem];
    }
    scan.close();
  }

  for (int i = 0; i < rows; i++) {
    scan = new Scanner(strings[i+1+rows]);
    for (int j = 0; j < cols; j++) {
      int elem = scan.nextInt();
      room.floor[i][j] = elem;
    }
    scan.close();
  }

  scan = new Scanner(strings[2*rows+1]);
  int num_boundaries = scan.nextInt();
  scan.close();
  for (int i = 0; i < num_boundaries; i++) {
    scan = new Scanner(strings[2*rows+1+1+i]);
    room.boundaries.add(new Boundary(scan.nextFloat()*tilew, scan.nextFloat()*tileh, scan.nextFloat()*tilew, scan.nextFloat()*tileh));
    scan.close();
  }

  return room;
}
