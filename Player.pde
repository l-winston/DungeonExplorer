final float PLAYER_SPEED = 30; // px/frame
final float PLAYER_SPRITE_WIDTH = 16; // original image dimensions
final float PLAYER_SPRITE_HEIGHT = 28; // original image dimensions
final float ANIMATION_SPEED_SCALE = 0.1; // animation speed scale


// enum to represent the type of player
enum PlayerType {
  ELF_F, ELF_M, KNIGHT_F, KNIGHT_M, WIZZARD_F, WIZZARD_M
}

class Player extends Entity {
    
  // the controls on the keyboard that map to this player's movement
  char[] controls;

  // which keys are currently held down
  boolean[] keysdown;

  public Player(float x, float y, char[] controls, PlayerType type) {
    this.controls = controls;
    // at creation, assume no keys are down
    keysdown = new boolean[4];

    // initalize dimensions
    walkboxw = playerw * 4f/5f;
    walkboxh = playerh * 1f / 4f;
    hitboxw = playerw * 2f / 3f;
    hitboxh = playerh / 2f;
    imgw = playerw;
    imgh = playerh;
    
    weapon = new FireStaff();

    this.x = x;
    this.y = y;

    // create the player's body
    //create();

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

    Vec2 pos = walkbox.getPosition();
    Vec2 newPos = new Vec2(pos.x, pos.y + box2d.scalarPixelsToWorld(playerh/4));
    hitbox.setTransform(newPos, 0);
  }
  
  void hit(Bullet bullet){
  
  }
}
