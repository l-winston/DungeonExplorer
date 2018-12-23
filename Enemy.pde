final float SMALL_SPRITE_WIDTH = 16;
final float SMALL_SPRITE_HEIGHT = 20;
final float MEDIUM_SPRITE_WIDTH = 32;
final float MEDIUM_SPRITE_HEIGHT = 34;

// number of frames the hit animation shows
final int hit_anim_duration = 15;
final int hit_freeze_duration = 15;

abstract class Enemy extends Entity {
  int frame_last_hit = -1;
  float hp;

  void hit(Bullet bullet) {
    frame_last_hit = frameCount;
    hp -= bullet.damage;

    if (hp < 0)
      toDestroy.add(this);
  }

  void show() {

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

    PImage imageToDraw = null;

    if (vel.x==0 && vel.y== 0) {
      imageToDraw = idle_anim[round(frameCount*ANIMATION_SPEED_SCALE)%idle_anim.length].copy();
    } else {
      imageToDraw = run_anim[round(frameCount*ANIMATION_SPEED_SCALE)%idle_anim.length].copy();
    }

    if (frame_last_hit != -1) {
      if (frameCount - frame_last_hit < hit_anim_duration) {
        imageToDraw.filter(THRESHOLD, 0.5);
      }

      if (frameCount - frame_last_hit < hit_freeze_duration) {
        walkbox.setLinearVelocity(new Vec2(0, 0));
      }
    } else {
      frame_last_hit = -1;
    }

    image(imageToDraw, 0, 0, imgw, imgh);

    popMatrix();
    popStyle();
  }
}

class BigDemon extends Enemy {
  boolean facing_right;

  public BigDemon(float x, float y) {
    facing_right = true;

    walkboxw = tilew;
    walkboxh = tileh/2f;
    hitboxw = tilew;
    hitboxh = hitboxw * 1.5;

    imgw = 2*tilew;
    imgh = imgw * MEDIUM_SPRITE_HEIGHT/MEDIUM_SPRITE_WIDTH;

    this.x = x;
    this.y = y;

    float s = 1.5;
    walkboxw *= s;
    walkboxh *= s;
    hitboxw *= s;
    hitboxh *= s;
    imgw *= s;
    imgh *= s;

    idle_anim = big_demon_idle_anim;
    run_anim = big_demon_run_anim;

    hp = 3;
  }


  void step() {
    super.step();

    Vec2 target = main.walkbox.getPosition();
    Vec2 current = walkbox.getPosition().mul(-1);

    Vec2 dpos = target.add(current);

    dpos.normalize();

    dpos.mulLocal(5);

    walkbox.setLinearVelocity(dpos);
  }
}

class Ogre extends Enemy {
  boolean facing_right;

  public Ogre(float x, float y) {
    facing_right = true;

    walkboxw = tilew;
    walkboxh = tileh/2f;
    hitboxw = tilew;
    hitboxh = hitboxw * 1.5;

    imgw = 2*tilew;
    imgh = imgw * MEDIUM_SPRITE_HEIGHT/MEDIUM_SPRITE_WIDTH;

    this.x = x;
    this.y = y;

    float s = 1.5;
    walkboxw *= s;
    walkboxh *= s;
    hitboxw *= s;
    hitboxh *= s;
    imgw *= s;
    imgh *= s;

    idle_anim = ogre_idle_anim;
    run_anim = ogre_run_anim;

    hp = 3;
  }


  void step() {
    super.step();

    Vec2 target = main.walkbox.getPosition();
    Vec2 current = walkbox.getPosition().mul(-1);

    Vec2 dpos = target.add(current);
    dpos.normalize();
    dpos.mulLocal(5);
    walkbox.setLinearVelocity(dpos);
  }
}

class BigZombie extends Enemy {
  boolean facing_right;

  public BigZombie(float x, float y) {
    facing_right = true;

    walkboxw = tilew;
    walkboxh = tileh/2f;
    hitboxw = tilew;
    hitboxh = hitboxw * 1.5;

    imgw = 2*tilew;
    imgh = imgw * MEDIUM_SPRITE_HEIGHT/MEDIUM_SPRITE_WIDTH;

    this.x = x;
    this.y = y;

    float s = 1.5;
    walkboxw *= s;
    walkboxh *= s;
    hitboxw *= s;
    hitboxh *= s;
    imgw *= s;
    imgh *= s;

    idle_anim = big_zombie_idle_anim;
    run_anim = big_zombie_run_anim;

    hp = 5;
  }


  void step() {
    super.step();

    Vec2 target = main.walkbox.getPosition();
    Vec2 current = walkbox.getPosition().mul(-1);

    Vec2 dpos = target.add(current);
    dpos.normalize();
    dpos.mulLocal(5);
    walkbox.setLinearVelocity(dpos);
  }
}
