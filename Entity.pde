// all entities will inherit this class
abstract class Entity {

  Body walkbox;
  Body hitbox;

  abstract void step();
  abstract void show();

  void killBody() {
    box2d.destroyBody(walkbox);
    box2d.destroyBody(hitbox);
  }

  // draws the player's movement hitbox as a green rectangle
  public void showHitbox() {
    pushMatrix();
    pushStyle();

    rectMode(CENTER);
    stroke(0, 0, 255);
    strokeWeight(2);
    noFill();

    Vec2 pos = box2d.getBodyPixelCoord(walkbox);

    rect(pos.x, pos.y, walkboxw, walkboxh);

    Vec2 hitboxpos = box2d.getBodyPixelCoord(hitbox);
    stroke(0, 255, 0);
    rect(hitboxpos.x, hitboxpos.y, hitboxw, hitboxh);

    popStyle();
    popMatrix();
  }
}
