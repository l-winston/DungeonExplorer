Room start;

void setup() {
  noSmooth();
  size(500, 500);


  loadImages();

  start = new Room(20, 20);
}

void draw() {
  background(0);

  int startx = 0;
  int endx = width;
  int starty = 0;
  int endy = height;

  display(start, 0, 0, width, height);
  //image(big_zombie_run_anim[frameCount%32/8], width/4, height/4, width/2, height/2);
  //mage(walls[WALL_INNER_CORNER_T_TOP_LEFT], width/4, height/4, width/2, height/2);
}

void display(Room room, int x, int y, int w, int h) {
  int tilew = round(w*1.0/room.walls[0].length);
  int tileh = round(h*1.0/room.walls.length);

  for (int i = 0; i < room.floors.length; i++) {
    for (int j = 0; j < room.floors[0].length; j++) {

      if (room.floors[i][j] == -1)
        continue;

      int tilex = x + j * tilew;
      int tiley = y + i * tileh;

      image(floors[room.floors[i][j]], tilex, tiley, tilew, tileh);
    }
  }

  for (int i = 0; i < room.walls.length; i++) {
    for (int j = 0; j < room.walls[0].length; j++) {

      if (room.walls[i][j] == -1)
        continue;

      int tilex = x + j * tilew;
      int tiley = y + i * tileh;

      image(walls[room.walls[i][j]], tilex, tiley, tilew, tileh);
    }
  }
}
