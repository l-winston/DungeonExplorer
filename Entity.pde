// all entities will inherit this class
abstract class Entity {

  Body walkbox;
  Body hitbox;

  abstract void step();
  abstract void show();
  abstract void showHitbox();

  void killBody() {
    box2d.destroyBody(walkbox);
    box2d.destroyBody(hitbox);
  }
}
