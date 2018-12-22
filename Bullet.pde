abstract class Bullet extends Entity {
  Entity source;

  float radius;

  float vx;
  float vy;

  PImage[] dead_anim;

  int frame_hit;

  // x/y pixel coords
  // vx/vy world scalars
  // r pixel scalar
  public Bullet(float x, float y, float vx, float vy, float r, Entity s) {
    radius = r;
    this.vx = vx;
    this.vy = vy;
    this.x = x;
    this.y = y;
    this.source = s;
    frame_hit = -1;
  }

  void destroyBody() {
    super.destroyBody();

    Vec2 vel = walkbox.getLinearVelocity();
    vx = vel.x;
    vy = vel.y;
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
    walkboxfd.isSensor = true;

    walkbox.createFixture(walkboxfd);

    // can directly create fixture w/ shape & density:
    //   body.createFixture(ps, 1);

    walkbox.setUserData(new UserData(this, DataType.WALKBOX));

    walkbox.setSleepingAllowed(false);
  }


  void step() {
    // no need to do anything
  }

  abstract void show();

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

  void hit() {
    walkbox.setLinearVelocity(new Vec2(0, 0));
    frame_hit = frameCount;
  }
}

class FireBullet extends Bullet {
  public FireBullet(float x, float y, float vx, float vy, float r, Entity s) {
    super(x, y, vx, vy, r, s);
    run_anim = pixel_effects_fire;
    dead_anim = explosion_1;
  }

  void show() {
    pushMatrix();
    pushStyle();

    Vec2 pos = box2d.getBodyPixelCoord(walkbox);
    Vec2 vel = walkbox.getLinearVelocity();

    translate(pos.x, pos.y);
    imageMode(CENTER);

    if (frame_hit == -1) {
      rotate(atan2(-vel.y, vel.x) - PI/2);
      translate(-radius/2, -radius*20/4);
      image(run_anim[frameCount%run_anim.length], 0, 0, radius*22, radius*22);
    } else {
      image(dead_anim[((frameCount-frame_hit)/3)%dead_anim.length], 0, 0, radius*10, radius*10);
    }

    popMatrix();
    popStyle();

    if (frame_hit != -1 && (frameCount - frame_hit)/3 > dead_anim.length)
      toDestroy.add(this);
  }
}

class BlueCircleBullet extends Bullet {

  public BlueCircleBullet(float x, float y, float vx, float vy, float r, Entity s) {
    super(x, y, vx, vy, r, s);
    run_anim = new PImage[] {circle_bullet_blue};
  }

  void show() {

    pushMatrix();
    pushStyle();

    Vec2 pos = box2d.getBodyPixelCoord(walkbox);

    translate(pos.x, pos.y);
    imageMode(CENTER);

    //image(run_anim[round(frameCount*ANIMATION_SPEED_SCALE)%run_anim.length], 0, 0, radius*2, radius*2);
    //image(circle_bullet_red, 0, 0, radius*2, radius*2);
    image(run_anim[frameCount%run_anim.length], 0, 0, radius*2, radius*2);

    popMatrix();
    popStyle();
  }
}
