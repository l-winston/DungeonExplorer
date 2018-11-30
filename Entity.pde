abstract class Entity{
  
  Body body;
  
  abstract void step();
  abstract void show();
  
  void killBody(){
    box2d.destroyBody(body);
  }
}
