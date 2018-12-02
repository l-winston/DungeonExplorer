// all entities will inherit this class
abstract class Entity{
  
  Body body;
  
  abstract void step();
  abstract void show();
  abstract void showHitbox();
  
  void killBody(){
    box2d.destroyBody(body);
  }
}
