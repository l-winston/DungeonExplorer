Room start;
Player main;


float tilew, tileh;

void setup() {
  noSmooth();
  size(750, 750);

  loadImages();

  start = new Room(10, 12);
  tilew = width*1.0/start.cols;
  tileh = height*1.0/start.rows;
  playerw = tilew;
  playerh = tilew*PLAYER_SPRITE_HEIGHT/PLAYER_SPRITE_WIDTH;

  main = new Player(start.cols/2, start.rows/2, new char[]{'w', 'a', 's', 'd'}, PlayerType.KNIGHT_M);
}

void draw() {
  background(0);

  main.step();

  start.display_floors();
  start.display_top_walls();
  //start.display_obstacles();
  main.show();
  start.display_bot_walls();

  //image(big_zombie_idle_anim[frameCount%32/8], main.x, main.y, width/5, height/5);
  //mage(walls[WALL_INNER_CORNER_T_TOP_LEFT], width/4, height/4, width/2, height/2);
}

boolean[] wasd = new boolean[4];

void keyPressed() {
  main.keyPressUpdate();
}

void keyReleased() {
  main.keyReleaseUpdate();
}

float[] pixelToTile(float x, float y) {
  return new float[]{y / tileh, x / tilew};
}

float[] tileToPixel(float i, float j) {
  return new float[]{j * tilew, i * tileh};
}
