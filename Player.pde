
class Player {
  float x, y;
  float vx, vy;
  char[] controls;
  boolean[] keysdown;

  public Player(float _x, float _y, char[] controls) {
    x=_x;
    y=_y;
    this.controls = controls;
    keysdown = new boolean[4];
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
      vy-=10;
    if (keysdown[1])
      vx-=10;
    if (keysdown[2])
      vy+=10;
    if (keysdown[3])
      vx+=10;
    x+=vx;
    y+=vy;
  }
}
