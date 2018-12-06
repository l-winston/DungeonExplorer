class Bullet extends Entity {
  float radius;
  
  float vx;
  float vy;
  
  
  // x/y pixel coords
  // vx/vy world scalars
  // r pixel scalar
  public Bullet(float x, float y, float vx, float vy, float r) {
    radius = r;
    run_anim = big_demon_run_anim;
    this.vx = vx;
    this.vy = vy;
    this.x = x;
    this.y = y;
    //create();
  }

  void create() {
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
    walkbox.setLinearVelocity(new Vec2(vx, vy));
    //   body.setAngularVelocity(1.2);

    CircleShape walkboxps = new CircleShape();
    float world_radius = box2d.scalarPixelsToWorld(radius);
    walkboxps.m_radius = world_radius;


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
  }


  void step() {
    // no need to do anything
  }

  public void show() {

    pushMatrix();
    pushStyle();

    Vec2 pos = box2d.getBodyPixelCoord(walkbox);

    translate(pos.x, pos.y);
    imageMode(CENTER);

    image(run_anim[round(frameCount*ANIMATION_SPEED_SCALE)%run_anim.length], 0, 0, radius*2, radius*2);


    popMatrix();
    popStyle();
  }

  // draws the player's movement hitbox as a green rectangle
  public void showHitbox() {
    pushMatrix();
    pushStyle();

    stroke(0, 0, 255);
    strokeWeight(2);
    noFill();

    Vec2 pos = box2d.getBodyPixelCoord(walkbox);

    ellipse(pos.x, pos.y, radius*2, radius*2);

    popStyle();
    popMatrix();
  }
}
