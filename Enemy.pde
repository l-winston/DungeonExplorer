final int SMALL_SPRITE_WIDTH = 16;
final int SMALL_SPRITE_HEIGHT = 20;
final int MEDIUM_SPRITE_WIDTH = 32;
final int MEDIUM_SPRITE_HEIGHT = 34;

class BigDemon extends Entity {
  boolean facing_right;

  public BigDemon(float x, float y) {
    facing_right = true;

    walkboxw = playerw * 4f/5f;
    walkboxh = playerh * 1f / 4f;
    hitboxw = playerw * 2f / 3f;
    hitboxh = playerh / 2f;

    create(x, y);
  }


  void step() {
  }

  void show() {
  }
}
