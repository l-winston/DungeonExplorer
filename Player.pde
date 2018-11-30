final float PLAYER_SPEED = 0.1; // units of grid/frame
final float PLAYER_SPRITE_WIDTH = 16; // original image dimensions
final float PLAYER_SPRITE_HEIGHT = 28; // original image dimensions
final float ANIMATION_SPEED_SCALE = 0.1;

float playerw;
float playerh;

enum PlayerType {
  ELF_F, ELF_M, KNIGHT_F, KNIGHT_M, WIZZARD_F, WIZZARD_M
}
class Player {
  PImage[] idle_anim;
  PImage[] run_anim;
  PImage hit;

  boolean facing_right;

  float x, y;
  float vx, vy;
  char[] controls;
  boolean[] keysdown;

  public Player(float _x, float _y, char[] controls, PlayerType type) {
    x=_x;
    y=_y;
    this.controls = controls;
    keysdown = new boolean[4];

    facing_right = true;

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

  public void show() {
    pushMatrix();
    pushStyle();

    translate(x*tilew, y*tileh);
    imageMode(CENTER);
    if (!facing_right) {
      scale(-1, 1);
    }
    if (vx==0 && vy== 0) {
      image(idle_anim[round(frameCount*ANIMATION_SPEED_SCALE)%idle_anim.length], 0, 0, playerw, playerh);
    } else {
      image(run_anim[round(frameCount*ANIMATION_SPEED_SCALE)%idle_anim.length], 0, 0, playerw, playerh);
    }

    popStyle();
    popMatrix();
  }

  public void keyPressUpdate() {
    if (key == controls[0]) {
      keysdown[0] = true;
    }

    if (key == controls[1]) {
      keysdown[1] = true;
    }

    if (key == controls[2]) {
      keysdown[2] = true;
    }

    if (key == controls[3]) {
      keysdown[3] = true;
    }
  }

  public void keyReleaseUpdate() {
    if (key == controls[0]) {
      keysdown[0] = false;
    }

    if (key == controls[1]) {
      keysdown[1] = false;
    }

    if (key == controls[2]) {
      keysdown[2] = false;
    }

    if (key == controls[3]) {
      keysdown[3] = false;
    }
  }

  public void step() {
    vx=vy=0;
    if (keysdown[0])
      vy-=PLAYER_SPEED;
    if (keysdown[1])
      vx-=PLAYER_SPEED;
    if (keysdown[2])
      vy+=PLAYER_SPEED;
    if (keysdown[3])
      vx+=PLAYER_SPEED;

    float[] playerTileDimensions = pixelToTile(playerw, playerh);


    boolean[] corners = {
      start.isObstacle(x-0.5, y - 0.5), 
      start.isObstacle(x+0.5, y - 0.5), 
      start.isObstacle(x+0.5, y + 1.5), 
      start.isObstacle(x-0.5, y + 1.5), 
    };

    // top 2
    if (corners[0] && corners[1]) {
      if (vy < 0) {
        vy= 0;
      }
    }

    // bottom 2
    if (corners[2] && corners[3]) {
      if (vy > 0) {
        vy= 0;
      }
    }

    // right 2
    if (corners[1] && corners[2]) {
      if (vx > 0) {
        vx= 0;
      }
    }

    // left 2
    if (corners[3] && corners[0]) {
      if (vx < 0) {
        vx= 0;
      }
    }


    x+=vx;
    y+=vy;

    if (vx != 0) {
      facing_right = vx > 0;
    }
  }
}
