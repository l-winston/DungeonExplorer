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

Room[] rooms;
Room current;
Player main;

Box2DProcessing box2d;

ArrayList<Boundary> boundaries;
Boundary test;

float tilew, tileh;

void setup() {
  debug = false;

  noSmooth();
  size(700, 700);

  loadImages();
  loadSound();

  createBox2dWorld();
  createWorld();
}

void draw() {
  background(0);

  current.stepAll();
  box2d.step();

  Vec2 pos = box2d.coordWorldToPixels(main.body.getPosition());
  translate(width/2 - pos.x, height/2 - pos.y);

  current.display_floors();


  current.display();
  if (debug) {
    main.showHitbox();
    for (Boundary b : boundaries) 
      b.show();
  }


  //image(big_zombie_idle_anim[frameCount%32/8], main.x, main.y, width/5, height/5);
  //mage(walls[WALL_INNER_CORNER_T_TOP_LEFT], width/4, height/4, width/2, height/2);
}

void createBox2dWorld() {
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, 0);
}

void calculateDistances() {
  tilew = width*1.0/current.cols;
  tileh = height*1.0/current.rows;
  playerw = tilew;
  playerh = tilew*PLAYER_SPRITE_HEIGHT/PLAYER_SPRITE_WIDTH;
  hitboxw = playerw;
  hitboxh = playerh / 3.4f;
}

void createWorld() {
  boundaries = new ArrayList<Boundary>();

  rooms = new Room[1];
  rooms[0] = new Room(10, 12);
  current = rooms[0];

  calculateDistances();

  boundaries.add(new Boundary(0.5*tilew, 7*tileh, tilew, 14*tileh));
  boundaries.add(new Boundary(13.5*tilew, 7*tileh, tilew, 14*tileh));
  boundaries.add(new Boundary(7*tilew, 13*tileh, tilew*14, tileh));
  boundaries.add(new Boundary(7*tilew, 1.5*tileh, tilew*14, tileh));

  current.setColumn(4, 4);
  current.setColumn(6, 7);
  current.setColumn(5, 6);
  current.setColumn(8, 2);

  main = new Player(width/2, height/2, new char[]{'w', 'a', 's', 'd'}, PlayerType.KNIGHT_M);
  current.addEntity(main);
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

void mousePressed() {
  debug ^= true;
}
