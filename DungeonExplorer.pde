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


Room start;
Player main;

Box2DProcessing box2d;

ArrayList<Boundary> boundaries;
Boundary test;

float tilew, tileh;

void setup() {
  noSmooth();
  size(700, 700);

  loadImages();
  loadSound();

  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, 0);
  boundaries = new ArrayList<Boundary>();

  start = new Room(10, 12);
  tilew = width*1.0/start.cols;
  tileh = height*1.0/start.rows;
  playerw = tilew;
  playerh = tilew*PLAYER_SPRITE_HEIGHT/PLAYER_SPRITE_WIDTH;
  hitboxw = playerw - 1;
  hitboxh = playerh / 3.4f;

  boundaries.add(new Boundary(0.5*tilew, 7*tileh, tilew, 14*tileh));
  boundaries.add(new Boundary(13.5*tilew, 7*tileh, tilew, 14*tileh));
  boundaries.add(new Boundary(7*tilew, 13*tileh, tilew*14, tileh));
  boundaries.add(new Boundary(7*tilew, 1.5*tileh, tilew*14, tileh));

  start.setColumn(4, 4);
  start.setColumn(6, 7);
  start.setColumn(5, 6);
  start.setColumn(8, 2);


  main = new Player(width/2, height/2, new char[]{'w', 'a', 's', 'd'}, PlayerType.KNIGHT_M);
  start.addEntity(main);
}

void draw() {
  background(0);

  start.stepAll();
  box2d.step();

  start.display_floors();
  
  main.showHitbox();

  start.display();

  for (Boundary b : boundaries) {
    b.show();
  }


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
