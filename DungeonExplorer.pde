Room start;
Player main;

void setup() {
  noSmooth();
  size(750, 750);


  loadImages();

  start = new Room(20, 20);
  main = new Player(width/2, height/2, new char[]{'w', 'a', 's', 'd'}, PlayerType.ELF_M);
}

void draw() {
  background(0);

  main.step();

  int startx = 0;
  int endx = width;
  int starty = 0;
  int endy = height;

  display(start, width/8, height/8, width*6f/8f, height*6f/8f);

  image(big_zombie_idle_anim[frameCount%32/8], main.x, main.y, width/5, height/5);
  //mage(walls[WALL_INNER_CORNER_T_TOP_LEFT], width/4, height/4, width/2, height/2);
}

boolean[] wasd = new boolean[4];

void keyPressed() {
  main.keyPressUpdate();
}

void keyReleased() {
  main.keyReleaseUpdate();
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
