final float SMALL_SPRITE_WIDTH = 16;
final float SMALL_SPRITE_HEIGHT = 20;
final float MEDIUM_SPRITE_WIDTH = 32;
final float MEDIUM_SPRITE_HEIGHT = 34;

abstract class Enemy extends Entity{
  
  void hit(){
    toDestroy.add(this);
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
