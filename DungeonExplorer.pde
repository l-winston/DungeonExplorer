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

import java.util.HashSet;

// enum representing current phase of game
enum Phase {
  START, GAME, HELP, OPTIONS, PAUSE, CREDITS
}

HashSet<Entity> toDestroy;
HashSet<Entity> toCreate;

Train train;

PFont font;

boolean debug;
boolean mute;

// global variables to aid with drawing characters
float playerw;
float playerh;


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

// sample text
String sampleText = "Welcome to Dungeon Explorer!";

// library object
Box2DProcessing box2d;

ControlP5 startSession;
ControlP5 optionsSession;
ControlP5 helpSession;
ControlP5 pauseSession;
ControlP5 creditsSession;

void setup() {
  debug = false;
  mute = false;

  noSmooth();
  size(700, 700);

  startSession = new ControlP5(this);
  optionsSession = new ControlP5(this);
  helpSession = new ControlP5(this);
  pauseSession = new ControlP5(this);
  creditsSession = new ControlP5(this);

  startSession.setAutoDraw(false);
  optionsSession.setAutoDraw(false);
  helpSession.setAutoDraw(false);
  pauseSession.setAutoDraw(false);
  creditsSession.setAutoDraw(false);

  // set inital phase
  phase = Phase.START;

  // load files
  loadImages();
  loadSound();
  loadFont();

  initalizeCredits();
  addUi();

  for (int i = 0; i < 10; i++) {
    for (int j = 0; j < 10; j++) {
      startPattern[i][j] = 0;
    }
  }

  train = new Train(-width/8f, height*3f/4f, 3, 3, 3, -width/8f, width + width/8f);
  song.loop();
}

int[] poss = {0, 1, 2, 3, 4, 5, 6, 7, 8};

void draw() {

  switch (phase) {
  case GAME:

    for (Entity e : toDestroy) {
      e.destroyBody();
      rooms[current].entities.remove(e);
    }

    for (Entity e : toCreate) {
      e.create();
      rooms[current].entities.add(e);
    }

    toDestroy = new HashSet<Entity>();
    toCreate = new HashSet<Entity>();

    background(0);  

    // calculate physics on each entity (on the floor)
    box2d.step();

    // step all entities on current floor through time
    rooms[current].stepAll();

    // find middle of characters
    Vec2 mainpos = box2d.getBodyPixelCoord(main.walkbox);

    // move camera to follow players
    translate(width/2 - mainpos.x, height/2 - mainpos.y);


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
    }

    break;
  case START:

    drawTitleBackground();


    fill(255);
    textSize(75);
    textAlign(CENTER, CENTER);
    rectMode(CENTER);
    text("Dungeon Explorer", width/2f, height/4f, width/2f, height/4f);


    startSession.draw();
    break;
  case HELP:

    drawTitleBackground();


    fill(255);
    textSize(75);
    textAlign(CENTER, CENTER);
    rectMode(CENTER);


    text("Help", width/2f, height/8f, width/2f, height/4f); 


    imageMode(CENTER);
    //fill(102, 89, 88);
    image(box, width/2f, height/2f, width*2f/3f, height/2f);


    fill(255);
    textSize(30);
    text(sampleText, width/2f, height/2f, width*2f/3f, height/2f);


    helpSession.draw();
    break;
  case OPTIONS:

    drawTitleBackground();


    fill(255);
    textSize(75);
    textAlign(CENTER, CENTER);
    rectMode(CENTER);


    text("Options", width/2f, height/8f, width/2f, height/4f);


    optionsSession.draw();
    break;
  case PAUSE: 

    pushMatrix();

    Vec2 pos = box2d.getBodyPixelCoord(main.walkbox);
    translate(width/2 - pos.x, height/2 - pos.y);
    rooms[current].display_floors();
    rooms[current].display();

    popMatrix();

    fill(color(0, 0, 0, 150));
    rectMode(CORNER);
    noStroke();

    rect(0, 0, width, height);
    pauseSession.draw();
    break;
  case CREDITS:

    drawTitleBackground();

    fill(255);
    textSize(75);
    rectMode(CENTER);
    textAlign(CENTER, CENTER);

    text("Credits!", width/2f, height/8f, width/2f, height/4f);

    textSize(30);

    textAlign(LEFT, CENTER);
    text(roles, width/4f, height/2f, width*7f/16f, height/2f);
    textAlign(RIGHT, CENTER);
    text(names, width*3f/4f, height/2f, width*7f/16f, height/2f);

    creditsSession.draw();
    break;
  }
}

int[][] startPattern = new int[10][10];
float ax = 0;

void drawTitleBackground() { 
  pushStyle();

  imageMode(CORNER);

  for (int i = 0; i < 10; i++) {
    for (int j = 0; j < 10; j++) {
      image(floors[startPattern[i][j]], j*width/10f, i*height/10f, width/10f, height/10f);
    }
  }

  train.step();
  train.show();
  if (train.isDone()) {
    float x = (train.xf);
    float y = random(height*6f/8f) + height*1f/8f;
    float vx = 3 * (train.isRight ? -1 : 1);
    float sx = 3 * (train.isRight ? -1 : 1);
    float xf = (train.xi);
    train = new Train(x, y, vx, sx, 3, x, xf);
  }
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

  // calculate scaling numbers
  calculateDistances();


  // create room array and set dimensions
  rooms = new Room[4];
  rooms[0] = new Room(10, 12);
  rooms[1] = new Room(20, 22);
  rooms[2] = loadRoom("world1.txt");
  rooms[3] = loadRoom("world2.txt");


  rooms[0].createBox();

  for (int i = 0; i < 5; i++)
    rooms[0].setColumn(int(random(2, 13)), int(random(1, 13)));


  rooms[1].createBox();

  for (int i = 0; i < 5; i++)
    rooms[1].setColumn(int(random(2, 23)), int(random(1, 23)));





  // create players
  main = new Player(width/2, height/2, new char[]{'w', 'a', 's', 'd'}, PlayerType.WIZZARD_M);  

  // add players to the rooms
  rooms[0].addEntity(main);
  rooms[1].addEntity(main);
  rooms[2].addEntity(main);
  rooms[3].addEntity(main);

  for (int i = 0; i < 3; i++) {
    rooms[1].addEntity(new BigDemon(random(width)+100, random(height)+100));
    rooms[1].addEntity(new Ogre(random(width)+100, random(height)+100));
    rooms[1].addEntity(new BigZombie(random(width)+100, random(height)+100));
  }

  toDestroy = new HashSet<Entity>();
  toCreate = new HashSet<Entity>();
}

void calculateDistances() {
  // arbitrary way to choose how to scale tiles
  tilew = width / 15;
  tileh = height / 15;
  playerw = tilew;
  playerh = tilew * PLAYER_SPRITE_HEIGHT/PLAYER_SPRITE_WIDTH;
}

void keyPressed() {

  if (phase == Phase.GAME) {

    main.keyPressUpdate();

    if (key == ' ') {
      for (Boundary b : rooms[current].boundaries) {
        b.destroyBody();
      }

      for (Entity e : rooms[current].entities) {
        e.destroyBody();
      }

      current = (current+1)%rooms.length;

      for (Boundary b : rooms[current].boundaries) {
        b.createBody();
      }
      for (Entity e : rooms[current].entities) {
        e.create();
      }
    }

    if (key == 'b') {
      if (phase == Phase.GAME) {
        debug ^= true;
      }
    }

    if (key == ESC) {
      key = 0;
      phase = Phase.PAUSE;
    }

    if (key == 'e') {
      if (main.weapon instanceof FireStaff)
        main.weapon = new NatureStaff();
      else
        main.weapon = new FireStaff();
    }
  }

  if (phase == Phase.PAUSE) {
    if (key == ESC) {
      key = 0;
      phase = Phase.GAME;
    }
  }
}

void keyReleased() {
  if (phase == Phase.GAME) {
    main.keyReleaseUpdate();
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

void addUi() {
  addStartUi();
  addHelpUi();
  addOptionsUi();
  addPauseUi();
  addCreditsUi();
}

void addStartUi() {
  // add start ui
  startSession.addButton("START")
    .setImages(startdefault, starthover, starthover)
    .setValue(0)
    .setPosition(width/2-startdefault.width/2, height/2-startdefault.height/2)
    .setSize(startdefault.width, startdefault.height)
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

        for (Entity e : rooms[current].entities) {
          e.create();
        }
      }
    }
  } 
  )
  .getCaptionLabel()
    .align(CENTER, CENTER)
    ;

  // add options ui
  startSession.addButton("OPTIONS")
    .setImages(optionsdefault, optionshover, optionshover)
    .setValue(0)
    .setPosition(width/2+startdefault.width/2, height/2-startdefault.height/2)
    .setSize(optionsdefault.width, optionsdefault.height)
    .addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent event) {
      if (event.getAction() == ControlP5.ACTION_RELEASED) {
        phase = Phase.OPTIONS;
      }
    }
  } 
  )
  .getCaptionLabel()
    .align(CENTER, CENTER)
    ;

  // add options ui
  startSession.addButton("HELP")
    .setImages(helpdefault, helphover, helphover)
    .setValue(0)
    .setPosition(width/2-startdefault.width, height/2-startdefault.height/2)
    .setSize(helpdefault.width, helpdefault.height)
    .addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent event) {
      if (event.getAction() == ControlP5.ACTION_RELEASED) {
        phase = Phase.HELP;
      }
    }
  } 
  )
  .getCaptionLabel()
    .align(CENTER, CENTER)
    ;

  startSession.addButton("CREDITS")
    .setImages(creditsdefault, creditshover, creditshover)
    .setValue(0)
    .setPosition(width/2-creditsdefault.width/2, height/2+creditsdefault.height/2)
    .setSize(creditsdefault.width, creditsdefault.height)
    .addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent event) {
      if (event.getAction() == ControlP5.ACTION_RELEASED) {
        phase = Phase.CREDITS;
      }
    }
  } 
  )
  .getCaptionLabel()
    .align(CENTER, CENTER)
    ;
}

void addHelpUi() {
  helpSession.addButton("BACK")
    .setImages(backdefault, backhover, backhover)
    .setValue(0)
    .setPosition(0, height - backdefault.height)
    .setSize(backdefault.width, backdefault.height)
    .addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent event) {
      if (event.getAction() == ControlP5.ACTION_RELEASED) {
        phase = Phase.START;
      }
    }
  } 
  )
  .getCaptionLabel()
    .align(CENTER, CENTER)
    ;
}

void addOptionsUi() {
  optionsSession.addButton("BACK")
    .setImages(backdefault, backhover, backhover)
    .setValue(0)
    .setPosition(0, height - backdefault.height)
    .setSize(backdefault.width, backdefault.height)
    .addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent event) {
      if (event.getAction() == ControlP5.ACTION_RELEASED) {
        phase = Phase.START;
      }
    }
  } 
  )
  .getCaptionLabel()
    .align(CENTER, CENTER)
    ;

  optionsSession.addButton("VOLUME")
    .setImages(volumeondefault, volumeonhover, volumeonhover)
    .setValue(0)
    .setPosition(width/2 - volumeondefault.width/2, height/2 - volumeondefault.height/2)
    .setSize(volumeondefault.width, volumeondefault.height)
    .addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent event) {
      if (event.getAction() == ControlP5.ACTION_RELEASED) {
        mute ^= true;

        if (mute)
        song.pause();
        else
          song.loop();

        if (mute) {
          optionsSession.getController("VOLUME").setImages(volumeoffdefault, volumeoffhover, volumeoffhover);
        } else {
          optionsSession.getController("VOLUME").setImages(volumeondefault, volumeonhover, volumeonhover);
        }
      }
    }
  } 
  )
  .getCaptionLabel()
    .align(CENTER, CENTER)
    ;
}

void addPauseUi() {
  pauseSession.addButton("EXIT")
    .setImages(exitdefault, exithover, exithover)
    .setValue(0)
    .setPosition(width/2 - exitdefault.width, height/2 - exitdefault.height/2)
    .setSize(exitdefault.width, exitdefault.height)
    .addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent event) {
      if (event.getAction() == ControlP5.ACTION_RELEASED) {
        phase = Phase.START;
      }
    }
  } 
  )
  .getCaptionLabel()
    .align(CENTER, CENTER)
    ;

  pauseSession.addButton("RESUME")
    .setImages(playdefault, playhover, playhover)
    .setValue(0)
    .setPosition(width/2 + playdefault.width/2, height/2 - playdefault.height/2)
    .setSize(playdefault.width, playdefault.height)
    .addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent event) {
      if (event.getAction() == ControlP5.ACTION_RELEASED) {
        phase = Phase.GAME;
      }
    }
  } 
  )
  .getCaptionLabel()
    .align(CENTER, CENTER)
    ;
}

void addCreditsUi() {
  creditsSession.addButton("BACK")
    .setImages(backdefault, backhover, backhover)
    .setValue(0)
    .setPosition(0, height - backdefault.height)
    .setSize(backdefault.width, backdefault.height)
    .setFont(font)
    .addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent event) {
      if (event.getAction() == ControlP5.ACTION_RELEASED) {
        phase = Phase.START;
      }
    }
  } 
  )
  .getCaptionLabel()
    .align(CENTER, CENTER)
    ;
}

// click to turn on/off debug mode
void mousePressed() {
  if (phase == Phase.GAME) {
    Vec2 pixelrelative = new Vec2(mouseX - (width/2), mouseY - (height/2));

    float a = atan2 (pixelrelative.y, pixelrelative.x);
    main.shoot(a);
  }
}
