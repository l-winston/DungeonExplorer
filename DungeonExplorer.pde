import controlP5.*;

import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.callbacks.ContactListener;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;
import org.jbox2d.collision.Manifold;
import org.jbox2d.dynamics.contacts.Contact;
import org.jbox2d.callbacks.ContactImpulse;

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

// enum representing current phase of game
enum Phase {
  START, GAME
}

PFont font;

boolean debug;
boolean mute;

// global variables to aid with drawing characters
float playerw;
float playerh;
float hitboxw;
float hitboxh;

// global variablles to aid with scaling
float tilew, tileh;

// every "floor" or "room" of the game
Room[] rooms;
// index of current floor
int current;

// current phase
Phase phase;

// initalize players
Player main;
Player second;

// library object
Box2DProcessing box2d;
ControlP5 cp5;

// boundaries on current floor
ArrayList<Boundary> currentFloorBoundaries;

void setup() {
  debug = false;
  mute = true;

  noSmooth();
  size(700, 700);

  cp5 = new ControlP5(this);
  cp5.setAutoDraw(false);

  // set inital phase
  phase = Phase.START;

  // load files
  loadImages();
  loadSound();
  loadFont();

  // add start ui
  cp5.addButton("START")
    .setValue(0)
    .setPosition(width/2-100/2, height/2-20/2)
    .setSize(int(100), int(20))
    .setFont(font)
    .addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent event) {
      if (event.getAction() == ControlP5.ACTION_RELEASED) {
        phase = Phase.GAME;
        createBox2dWorld();
        createWorld();

        current = 0;
        for (Boundary b : rooms[current].boundaries) {
          b.createBody();
        }
      }
    }
  } 
  )
  .setColorForeground(color(0, 0, 0, 0))
    .setColorBackground(color(0, 0, 0, 0))
    .setColorActive(color(0, 0, 0, 0))
    .getCaptionLabel()
    .align(CENTER, CENTER)
    ;
}

void draw() {

  switch (phase) {
  case GAME:
    background(0);

    // step all entities on current floor through time
    rooms[current].stepAll();
    // calculate physics on each entity (on the floor)
    box2d.step();


    // find middle of characters
    Vec2 mainpos = box2d.coordWorldToPixels(main.body.getPosition());
    Vec2 secondpos = box2d.coordWorldToPixels(second.body.getPosition());

    float avgx = (mainpos.x + secondpos.x)/2;
    float avgy = (mainpos.y + secondpos.y)/2;


    // move camera to follow players
    translate(width/2 - avgx, height/2 - avgy);


    // show current floor
    rooms[current].display_floors();

    // show all entities on current floor
    rooms[current].display();

    // if in debug mode, show hitboxes of all entities
    if (debug) {
      for (Boundary b : rooms[current].boundaries) 
        b.showHitbox();
      for (Entity e : rooms[current].entities) 
        e.showHitbox();
      break;
    }


    //image(big_zombie_idle_anim[frameCount%32/8], main.x, main.y, width/5, height/5);
    //mage(walls[WALL_INNER_CORNER_T_TOP_LEFT], width/4, height/4, width/2, height/2);
    break;
  case START:
    background(70, 59, 58);

    drawTitleBackground();
    fill(255);
    textSize(75);
    textAlign(CENTER, CENTER);
    rectMode(CENTER);
    text("Dungeon Explorer", width/2, height/4, width/2, height/4);
    cp5.draw();
    break;
  }
}

void drawTitleBackground() {   

  for (int i = 0; i < 10; i++) {
    for (int j = 0; j < 10; j++) {
      image(walls[5], j*width/10f, i*height/10f, width/10f, height/10f);
    }
  }
  
  imageMode(CENTER);
  
  pushMatrix();

  translate(width/8, height/3);
  scale(5);
  image(big_demon_idle_anim[0], 0, 0);

  popMatrix();
  pushMatrix();

  translate(width*7/8, height/3);
  scale(5);
  image(big_zombie_idle_anim[0], 0, 0);

  popMatrix();
  pushMatrix();

  translate(width/4, height*5/6);
  scale(5);
  image(elf_m_idle_anim[0], 0, 0);

  popMatrix();
  pushMatrix();

  translate(width/2, height*5/6);
  scale(5);
  image(knight_m_idle_anim[0], 0, 0);

  popMatrix();
  pushMatrix();

  translate(width*3/4, height*5/6);
  scale(5);
  image(wizzard_m_idle_anim[0], 0, 0);

  popMatrix();
}

void createBox2dWorld() {
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  // default gravity setting is (-10, 0)
  box2d.setGravity(0, 0);
  // add contact listener
  box2d.world.setContactListener(new CustomListener());
}

void createWorld() {

  // create room array and set dimensions
  rooms = new Room[2];
  rooms[0] = new Room(10, 12);
  rooms[1] = new Room(20, 22);

  // calculate scaling numbers
  calculateDistances();

  rooms[0].boundaries.add(new Boundary(0.5*tilew, 7*tileh, tilew, 12*tileh));
  rooms[0].boundaries.add(new Boundary(13.5*tilew, 7*tileh, tilew, 12*tileh));
  rooms[0].boundaries.add(new Boundary(7*tilew, 13*tileh, tilew*14, tileh));
  rooms[0].boundaries.add(new Boundary(7*tilew, 1.5*tileh, tilew*14, tileh));

  rooms[1].boundaries.add(new Boundary(0.5*tilew, 12*tileh, tilew, 22*tileh));
  rooms[1].boundaries.add(new Boundary(23.5*tilew, 12*tileh, tilew, 22*tileh));
  rooms[1].boundaries.add(new Boundary(12*tilew, 23*tileh, tilew*24, tileh));
  rooms[1].boundaries.add(new Boundary(12*tilew, 1.5*tileh, tilew*24, tileh));

  // randomly spawn columns
  for (int i = 0; i < 10; i++)
    rooms[0].setColumn(int(random(2, 13)), int(random(1, 13)));

  for (int i = 0; i < 100; i++)
    rooms[1].setColumn(int(random(2, 23)), int(random(1, 23)));

  // create players
  main = new Player(width/2, height/2, new char[]{'w', 'a', 's', 'd'}, PlayerType.KNIGHT_M);    
  second = new Player(width/2, height/2, new char[]{UP, LEFT, DOWN, RIGHT}, PlayerType.KNIGHT_F);  

  // add players to the rooms
  rooms[0].addEntity(main);
  rooms[1].addEntity(main);
  rooms[0].addEntity(second);
  rooms[1].addEntity(second);
}

void calculateDistances() {
  // arbitrary way to choose how to scale tiles
  tilew = width*1.0/15;
  tileh = height*1.0/15;
  playerw = tilew;
  playerh = tilew*PLAYER_SPRITE_HEIGHT/PLAYER_SPRITE_WIDTH;
  hitboxw = playerw;
  hitboxh = playerh / 3.4f;
}

void keyPressed() {
  if (key == 'm') {
    mute ^= true;
    if (mute)
      song.pause();
    else
      song.loop();
  }

  if (phase == Phase.GAME) {
    main.keyPressUpdate();
    second.keyPressUpdate();

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
}

void keyReleased() {
  if (phase == Phase.GAME) {
    main.keyReleaseUpdate();
    second.keyReleaseUpdate();
  }
}

// conversion method 
float[] pixelToTile(float x, float y) {
  return new float[]{y / tileh, x / tilew};
}

// conversion method
float[] tileToPixel(float i, float j) {
  return new float[]{j * tilew, i * tileh};
}

// click to turn on/off debug mode
void mousePressed() {
  if (phase == Phase.GAME) {
    debug ^= true;
  }
}

// contact listener to detect bullet hit (and more)
class CustomListener implements ContactListener {
  CustomListener() {
  }

  // This function is called when a new collision occurs
  void beginContact(Contact cp) {
    // Get both shapes
    Fixture f1 = cp.getFixtureA();
    Fixture f2 = cp.getFixtureB();
    // Get both bodies
    Body b1 = f1.getBody();
    Body b2 = f2.getBody();

    // Get our objects that reference these bodies
    Object o1 = b1.getUserData();
    Object o2 = b2.getUserData();

    if (o1 == null || o2 == null)
      return;

    if (o1.getClass() == Player.class && o2.getClass() == Player.class) {
      println("PLAYER-PLAYER Contact!");
    }
  }

  void endContact(Contact contact) {
    // TODO Auto-generated method stub
  }

  void preSolve(Contact contact, Manifold oldManifold) {
    // TODO Auto-generated method stub
  }

  void postSolve(Contact contact, ContactImpulse impulse) {
    // TODO Auto-generated method stub
  }
}
