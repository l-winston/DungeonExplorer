final float SMALL_SPRITE_WIDTH = 16;
final float SMALL_SPRITE_HEIGHT = 20;
final float MEDIUM_SPRITE_WIDTH = 32;
final float MEDIUM_SPRITE_HEIGHT = 34;

class BigDemon extends Entity {
  boolean facing_right;

  public BigDemon(float x, float y) {
    facing_right = true;

    walkboxw = tilew;
    walkboxh = tileh/2f;
    hitboxw = tilew;
    hitboxh = hitboxw * 1.5;

    imgw = 2*tilew;
    imgh = imgw * MEDIUM_SPRITE_HEIGHT/MEDIUM_SPRITE_WIDTH;

    idle_anim = big_demon_idle_anim;
    run_anim = big_demon_run_anim;

    create(x, y);
  }


  void step() {
    super.step();
    
    Vec2 target = main.walkbox.getPosition();
    Vec2 current = walkbox.getPosition().mul(-1);
    
    Vec2 dpos = target.add(current);
    
    dpos.normalize();
    
    dpos.mulLocal(10);
    
    walkbox.setLinearVelocity(dpos);
  }
}
