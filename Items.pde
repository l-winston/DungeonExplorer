abstract class Item {
  PImage icon;
  String name;
  
  
}

abstract class Weapon extends Item {
  PImage image;
  
  abstract Bullet makeBullet(float x, float y, float vx, float vy, Entity source);
  
}

class FireStaff extends Weapon {

  public FireStaff(){
    image = weapon_red_magic_staff;
  }
  
  Bullet makeBullet(float x, float y, float vx, float vy, Entity source){
    return new FireBullet(x, y, vx, vy, 10, source);
  }
}

class NatureStaff extends Weapon {
  public NatureStaff(){
    image = weapon_green_magic_staff;
  }
  
    Bullet makeBullet(float x, float y, float vx, float vy, Entity source){
    return new GreenCircleBullet(x, y, vx, vy, 20, source);
  }
}
