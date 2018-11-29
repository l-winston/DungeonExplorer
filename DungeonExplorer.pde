Room start;

void setup() {
  noSmooth();
  size(750, 750);


  loadImages();

  start = new Room(20, 20);
}

void draw() {
  background(0);

  int startx = 0;
  int endx = width;
  int starty = 0;
  int endy = height;

  display(start, width/8, height/8, width*6f/8f, height*6f/8f);
  //image(big_zombie_run_anim[frameCount%32/8], width/4, height/4, width/2, height/2);
  //mage(walls[WALL_INNER_CORNER_T_TOP_LEFT], width/4, height/4, width/2, height/2);
}

void display(Room room, float x, float y, float w, float h) {
  float tilew = w*1.0/room.walls[0].length;
  float tileh = h*1.0/room.walls.length;

  for (int i = 0; i < room.floors.length; i++) {
    for (int j = 0; j < room.floors[0].length; j++) {

      if (room.floors[i][j] == -1)
        continue;

      float tilex = x + j * tilew;
      float tiley = y + i * tileh;

      image(floors[room.floors[i][j]], tilex, tiley, tilew, tileh);
    }
  }

  for (int i = 0; i < room.walls.length; i++) {
    for (int j = 0; j < room.walls[0].length; j++) {

      if (room.walls[i][j] == -1)
        continue;

      float tilex = x + j * tilew;
      float tiley = y + i * tileh;
      
      image(walls[room.walls[i][j]], tilex, tiley, tilew, tileh);
    }
  }
}
