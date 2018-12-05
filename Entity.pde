
// all entities will inherit this class
abstract class Entity {

  Body walkbox;
  Body hitbox;
  
  float walkboxw;
  float walkboxh;
  float hitboxw;
  float hitboxh;

  abstract void step();
  abstract void show();

  void killBody() {
    box2d.destroyBody(walkbox);
    box2d.destroyBody(hitbox);
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
  
  public void create(float x, float y) {
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
}
