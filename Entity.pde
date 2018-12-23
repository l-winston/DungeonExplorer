
// all entities will inherit this class
abstract class Entity {
  
  float hp;
  int frame_last_hit;

  Weapon weapon;

  // images/animations for drawing
  PImage[] idle_anim;
  PImage[] run_anim;
  PImage hit;

  Body walkbox;
  Body hitbox;

  // whether of not the player was last facing the right (matters for drawing the player)
  boolean facing_right;

  float walkboxw;
  float walkboxh;
  float hitboxw;
  float hitboxh;
  float imgw;
  float imgh;

  float x;
  float y;

  void destroyBody() {
    if (walkbox != null)
      box2d.destroyBody(walkbox);
    if (hitbox != null)
      box2d.destroyBody(hitbox);

    Vec2 pos = box2d.getBodyPixelCoord(walkbox);
    x = pos.x;
    y = pos.y;
  }

  void setAwake(boolean awake) {
    walkbox.setAwake(awake);
    hitbox.setAwake(awake);
  }

  // draws the player's movement hitbox as a green rectangle
  public void showHitbox() {
    pushMatrix();
    pushStyle();

    rectMode(CENTER);
    stroke(0, 0, 255);
    strokeWeight(2);
    noFill();

    Vec2 pos = box2d.getBodyPixelCoord(walkbox);


    rect(pos.x, pos.y, walkboxw, walkboxh);  

    Vec2 hitboxpos = box2d.getBodyPixelCoord(hitbox);
    stroke(0, 255, 0);
    rect(hitboxpos.x, hitboxpos.y, hitboxw, hitboxh);

    popStyle();
    popMatrix();
  }

  public void create() {
    Vec2 center = box2d.coordPixelsToWorld(x, y);


    BodyDef walkboxbd = new BodyDef();
    walkboxbd.position.set(center);
    walkboxbd.type = BodyType.DYNAMIC;
    walkboxbd.fixedRotation = true;

    // set friction:
    //   bd.linearDamping = ...;
    //   bd.angularDamping = ...;

    // if body is moving fast:
    //   bd.bullet = ...;

    walkbox = box2d.createBody(walkboxbd);

    // inital starting state:
    //   body.setLinearVelocity(new Vec2(0, 3));
    //   body.setAngularVelocity(1.2);

    PolygonShape walkboxps = new PolygonShape();
    float box2Dw = box2d.scalarPixelsToWorld(walkboxw/2);
    float box2Dh = box2d.scalarPixelsToWorld(walkboxh/2);
    walkboxps.setAsBox(box2Dw, box2Dh);

    // make circular shape:
    //   CircleShape cs = new CircleShape();
    //   cs.m_radius = ...;


    FixtureDef walkboxfd = new FixtureDef();
    walkboxfd.shape = walkboxps;

    // set pararaters that affect physics of shape:
    //   fd.friction = ...;
    //   fd.restitution = ...;
    //   fd.density = ...;

    walkbox.createFixture(walkboxfd);

    // can directly create fixture w/ shape & density:
    //   body.createFixture(ps, 1);

    walkbox.setUserData(new UserData(this, DataType.WALKBOX));


    // --------------------------------------------

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
    float hitboxbox2Dw = box2d.scalarPixelsToWorld(hitboxw / 2f);
    float hitboxbox2Dh = box2d.scalarPixelsToWorld(hitboxh / 2f);
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

    hitbox.setUserData(new UserData(this, DataType.HITBOX));

    hitbox.setSleepingAllowed(false);
  }

  // draw's the player's body
  public void show() {

    pushMatrix();
    pushStyle();

    Vec2 pos = box2d.getBodyPixelCoord(walkbox);
    Vec2 vel = walkbox.getLinearVelocity();

    translate(pos.x, pos.y - imgh/2);
    imageMode(CENTER);

    if (!facing_right) {
      scale(-1, 1);
    }

    if (weapon != null) {
      pushMatrix();
      translate(imgw/3, 0);
      image(weapon.image, 0, 0, imgh*weapon.image.width/weapon.image.height, imgh);
      popMatrix();
    }

    if (vel.x==0 && vel.y== 0) {
      image(idle_anim[round(frameCount*ANIMATION_SPEED_SCALE)%idle_anim.length], 0, 0, imgw, imgh);
    } else {
      image(run_anim[round(frameCount*ANIMATION_SPEED_SCALE)%idle_anim.length], 0, 0, imgw, imgh);
    }

    popMatrix();
    popStyle();
  }

  void step() {
    Vec2 vel = walkbox.getLinearVelocity();
    if (vel.x != 0) {
      facing_right = vel.x > 0;
    }

    Vec2 pos = walkbox.getPosition();
    Vec2 newPos = new Vec2(pos.x, pos.y + box2d.scalarPixelsToWorld(hitboxh/2));
    hitbox.setTransform(newPos, 0);
  }

  abstract void hit(Bullet bullet);

  void shoot(float angle) {
    Vec2 pixelpos = box2d.getBodyPixelCoord(walkbox);

    Vec2 dpos = new Vec2(box2d.scalarPixelsToWorld(cos(angle)), box2d.scalarPixelsToWorld(-sin(angle)));
    dpos.mulLocal(300);

    Bullet newBullet = weapon.makeBullet(pixelpos.x + 20*cos(angle), pixelpos.y + 20*sin(angle) - 5, dpos.x, dpos.y, this);
    toCreate.add(newBullet);

  }
}
