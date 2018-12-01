import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

boolean debug;

float playerw;
float playerh;
float hitboxw;
float hitboxh;

float tilew, tileh;

Room[] rooms;
int current;

Player main;
Player second;
//Player third;

Box2DProcessing box2d;

ArrayList<Boundary> currentFloorBoundaries;
Boundary test;

void setup() {
  debug = false;

  noSmooth();
  size(700, 700);

  loadImages();
  loadSound();

  createBox2dWorld();
  createWorld();

  current = 0;
  for (Boundary b : rooms[current].boundaries) {
    b.createBody();
  }
}

void draw() {
  background(0);

  rooms[current].stepAll();
  box2d.step();

  Vec2 mainpos = box2d.coordWorldToPixels(main.body.getPosition());
  Vec2 secondpos = box2d.coordWorldToPixels(second.body.getPosition());

  float avgx = (mainpos.x + secondpos.x)/2;
  float avgy = (mainpos.y + secondpos.y)/2;

  translate(width/2 - avgx, height/2 - avgy);

  rooms[current].display_floors();

  rooms[current].display();
  if (debug) {
    for (Boundary b : rooms[current].boundaries) 
      b.show();
    for (Entity e : rooms[current].entities) 
      e.showHitbox();
  }


  //image(big_zombie_idle_anim[frameCount%32/8], main.x, main.y, width/5, height/5);
  //mage(walls[WALL_INNER_CORNER_T_TOP_LEFT], width/4, height/4, width/2, height/2);
}

void createBox2dWorld() {
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, 0);
}

void createWorld() {

  rooms = new Room[2];
  rooms[0] = new Room(10, 12);
  rooms[1] = new Room(20, 22);

  calculateDistances();

  rooms[0].boundaries.add(new Boundary(0.5*tilew, 7*tileh, tilew, 12*tileh));
  rooms[0].boundaries.add(new Boundary(13.5*tilew, 7*tileh, tilew, 12*tileh));
  rooms[0].boundaries.add(new Boundary(7*tilew, 13*tileh, tilew*14, tileh));
  rooms[0].boundaries.add(new Boundary(7*tilew, 1.5*tileh, tilew*14, tileh));
  
  rooms[1].boundaries.add(new Boundary(0.5*tilew, 12*tileh, tilew, 22*tileh));
  rooms[1].boundaries.add(new Boundary(23.5*tilew, 12*tileh, tilew, 22*tileh));
  rooms[1].boundaries.add(new Boundary(12*tilew, 23*tileh, tilew*24, tileh));
  rooms[1].boundaries.add(new Boundary(12*tilew, 1.5*tileh, tilew*24, tileh));

  //rooms[0].setColumn(2, 1);
  //rooms[0].setColumn(12, 12);
  for (int i = 0; i < 10; i++)
    rooms[0].setColumn(int(random(2, 13)), int(random(1, 13)));
    
  for (int i = 0; i < 200; i++)
    rooms[1].setColumn(int(random(2, 23)), int(random(1, 23)));



  main = new Player(width/2, height/2, new char[]{'w', 'a', 's', 'd'}, PlayerType.KNIGHT_M, rooms[0]);    
  second = new Player(width/2, height/2, new char[]{'i', 'j', 'k', 'l'}, PlayerType.KNIGHT_F, rooms[0]);  
  //third = new Player(width/2, height/2, new char[]{UP, LEFT, DOWN, RIGHT}, PlayerType.ELF_M, rooms[0]);  

  rooms[0].addEntity(main);
  rooms[1].addEntity(main);
  rooms[0].addEntity(second);
  rooms[1].addEntity(second);
  //rooms[0].addEntity(third);
  //rooms[1].addEntity(third);
}

void calculateDistances() {
  tilew = width*1.0/30;
  tileh = height*1.0/30;
  playerw = tilew;
  playerh = tilew*PLAYER_SPRITE_HEIGHT/PLAYER_SPRITE_WIDTH;
  hitboxw = playerw;
  hitboxh = playerh / 3.4f;
}

boolean[] wasd = new boolean[4];

void keyPressed() {
  main.keyPressUpdate();
  second.keyPressUpdate();
  //third.keyPressUpdate();


  if (key == ' ') {
    for (Boundary b : rooms[current].boundaries) {
      b.destroyBody();
    }
    current = (current+1)%rooms.length;
    for (Boundary b : rooms[current].boundaries) {
      b.createBody();
    }
  }
}

void keyReleased() {
  main.keyReleaseUpdate();
  second.keyReleaseUpdate();
  //third.keyReleaseUpdate();
}

float[] pixelToTile(float x, float y, Room room) {
  return new float[]{y / tileh, x / tilew};
}

float[] tileToPixel(float i, float j, Room room) {
  return new float[]{j * tilew, i * tileh};
}

void mousePressed() {
  debug ^= true;
}
