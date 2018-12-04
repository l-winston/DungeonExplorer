final float PLAYER_SPEED = 30; // px/frame
final float PLAYER_SPRITE_WIDTH = 16; // original image dimensions
final float PLAYER_SPRITE_HEIGHT = 28; // original image dimensions
final float ANIMATION_SPEED_SCALE = 0.1; // animation speed scale


// enum to represent the type of player
enum PlayerType {
  ELF_F, ELF_M, KNIGHT_F, KNIGHT_M, WIZZARD_F, WIZZARD_M
}

class Player extends Entity {

  // images/animations for drawing
  PImage[] idle_anim;
  PImage[] run_anim;
  PImage hit;

  // whether of not the player was last facing the right (matters for drawing the player)
  boolean facing_right;

  // the controls on the keyboard that map to this player's movement
  char[] controls;

  // which keys are currently held down
  boolean[] keysdown;

  public Player(float x, float y, char[] controls, PlayerType type) {
    this.controls = controls;

    // at creation, assume no keys are down
    keysdown = new boolean[4];

    // create the player's body
    create(x, y);

    // players spawn facing right
    facing_right = true;

    // set the animations/images to the correct ones depending on the player's type
    if (type == PlayerType.ELF_F) {
      idle_anim = elf_f_idle_anim;
      run_anim = elf_f_run_anim;
      hit = elf_f_hit_anim;
    } else if (type == PlayerType.ELF_M) {
      idle_anim = elf_m_idle_anim;
      run_anim = elf_m_run_anim;
      hit = elf_m_hit_anim;
    } else if (type == PlayerType.KNIGHT_F) {
      idle_anim = knight_f_idle_anim;
      run_anim = knight_f_run_anim;
      hit = knight_f_hit_anim;
    } else if (type == PlayerType.KNIGHT_M) {
      idle_anim = knight_m_idle_anim;
      run_anim = knight_m_run_anim;
      hit = knight_m_hit_anim;
    } else if (type == PlayerType.WIZZARD_F) {
      idle_anim = wizzard_f_idle_anim;
      run_anim = wizzard_f_run_anim;
      hit = wizzard_f_hit_anim;
    } else if (type == PlayerType.WIZZARD_M) {
      idle_anim = wizzard_m_idle_anim;
      run_anim = wizzard_m_run_anim;
      hit = wizzard_m_hit_anim;
    }
  }

  public void create(float x, float y) {

    BodyDef bd = new BodyDef();
    Vec2 center = box2d.coordPixelsToWorld(x, y);
    bd.position.set(center);
    bd.type = BodyType.DYNAMIC;
    bd.fixedRotation = true;

    // set friction:
    //   bd.linearDamping = ...;
    //   bd.angularDamping = ...;

    // if body is moving fast:
    //   bd.bullet = ...;

    walkbox = box2d.createBody(bd);

    // inital starting state:
    //   body.setLinearVelocity(new Vec2(0, 3));
    //   body.setAngularVelocity(1.2);

    PolygonShape ps = new PolygonShape();
    float box2Dw = box2d.scalarPixelsToWorld(hitboxw/2);
    float box2Dh = box2d.scalarPixelsToWorld(hitboxh/2);
    ps.setAsBox(box2Dw, box2Dh);

    // make circular shape:
    //   CircleShape cs = new CircleShape();
    //   cs.m_radius = ...;


    FixtureDef fd = new FixtureDef();
    fd.shape = ps;

    // set pararaters that affect physics of shape:
    //   fd.friction = ...;
    //   fd.restitution = ...;
    //   fd.density = ...;

    walkbox.createFixture(fd);

    // can directly create fixture w/ shape & density:
    //   body.createFixture(ps, 1);

    walkbox.setUserData(this);


    BodyDef hitboxbd = new BodyDef();
    hitboxbd.position.set(center);
    hitboxbd.type = BodyType.DYNAMIC;
    hitboxbd.fixedRotation = true;

    // set friction:
    //   bd.linearDamping = ...;
    //   bd.angularDamping = ...;

    // if body is moving fast:
    //   bd.bullet = ...;

    hitbox = box2d.createBody(hitboxbd);

    // inital starting state:
    //   body.setLinearVelocity(new Vec2(0, 3));
    //   body.setAngularVelocity(1.2);

    PolygonShape hitboxps = new PolygonShape();
    float hitboxbox2Dw = box2d.scalarPixelsToWorld(playerw/2);
    float hitboxbox2Dh = box2d.scalarPixelsToWorld(playerh/2);
    hitboxps.setAsBox(hitboxbox2Dw, hitboxbox2Dh);

    // make circular shape:
    //   CircleShape cs = new CircleShape();
    //   cs.m_radius = ...;


    FixtureDef hitboxfd = new FixtureDef();
    hitboxfd.shape = hitboxps;  
    hitboxfd.isSensor = true;
    //hitboxfd.filter.maskBits = 0x0000;

    // set pararaters that affect physics of shape:
    //   fd.friction = ...;
    //   fd.restitution = ...;
    //   fd.density = ...;

    hitbox.createFixture(hitboxfd);

    // can directly create fixture w/ shape & density:
    //   body.createFixture(ps, 1);

    hitbox.setUserData(this);
    
    hitbox.setSleepingAllowed(false);
  }

  // draws the player's movement hitbox as a green rectangle
  public void showHitbox() {
    pushMatrix();
    pushStyle();

    rectMode(CENTER);
    stroke(0, 0, 255);
    strokeWeight(5);
    noFill();
    Vec2 pos = box2d.getBodyPixelCoord(walkbox);

    rect(pos.x, pos.y, hitboxw, hitboxh);
    
    Vec2 hitboxpos = box2d.getBodyPixelCoord(hitbox);
    strokeWeight(5);
    noFill();
    stroke(0, 255, 0);
    rect(hitboxpos.x, hitboxpos.y, playerw, playerh);

    popStyle();
    popMatrix();
  }

  // draw's the player's body
  public void show() {

    pushMatrix();
    pushStyle();

    Vec2 pos = box2d.getBodyPixelCoord(walkbox);
    Vec2 vel = walkbox.getLinearVelocity();
    // getting angle of rotation:
    //   float a = body.getAngle();
    translate(pos.x, pos.y - playerh/2);
    imageMode(CENTER);
    if (!facing_right) {
      scale(-1, 1);
    }
    if (vel.x==0 && vel.y== 0) {
      image(idle_anim[round(frameCount*ANIMATION_SPEED_SCALE)%idle_anim.length], 0, 0, playerw, playerh);
    } else {
      image(run_anim[round(frameCount*ANIMATION_SPEED_SCALE)%idle_anim.length], 0, 0, playerw, playerh);
    }
    
    popMatrix();
    popStyle();
  }


  // call this when keyPressed update the player's movement 
  public void keyPressUpdate() {
    float k = key == CODED ? keyCode : key;
    if (k == controls[0]) {
      keysdown[0] = true;
    }

    if (k == controls[1]) {
      keysdown[1] = true;
    }

    if (k == controls[2]) {
      keysdown[2] = true;
    }

    if (k == controls[3]) {
      keysdown[3] = true;
    }
  }

  // call this when keyReleased update the player's movement 
  public void keyReleaseUpdate() {
    float k = key == CODED ? keyCode : key;

    if (k == controls[0]) {
      keysdown[0] = false;
    }

    if (k == controls[1]) {
      keysdown[1] = false;
    }

    if (k == controls[2]) {
      keysdown[2] = false;
    }

    if (k == controls[3]) {
      keysdown[3] = false;
    }
  }

  // update the player's velocity depending on the keys inputted
  public void step() {
    Vec2 vel = walkbox.getLinearVelocity();

    float vx = 0;
    float vy = 0;

    if (keysdown[0])
      vy += PLAYER_SPEED;
    if (keysdown[1])
      vx -= PLAYER_SPEED;
    if (keysdown[2])
      vy -= PLAYER_SPEED;
    if (keysdown[3])
      vx += PLAYER_SPEED;

    walkbox.setLinearVelocity(new Vec2(vx, vy));

    if (vel.x != 0) {
      facing_right = vel.x > 0;
    }

    hitbox.setTransform(walkbox.getPosition(), 0);
  }
}
