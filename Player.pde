
class Player {
  float x, y;
  float vx, vy;

  public Player(float _x, float _y) {
    x=_x;
    y=_y;
  }

  public void step() {
    vx=vy=0;
    if (wasd[0])
      vy-=10;
    if (wasd[1])
      vx-=10;
    if (wasd[2])
      vy+=10;
    if (wasd[3])
      vx+=10;
    x+=vx;
    y+=vy;
  }
}
