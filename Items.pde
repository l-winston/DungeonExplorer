abstract class Item {
  PImage icon;
  String name;
  
  
}

abstract class Weapon extends Item {
  PImage image;
  
  abstract Bullet makeBullet(float x, float y, float r, Entity source);
  
}

class FireStaff extends Weapon {

  public FireStaff(){
    image = weapon_red_magic_staff;
  }
  
  Bullet makeBullet(float x, float y, float r, Entity source){
    return new FireBullet(x, y, 0, 0, r, source);
  }
}

class NatureStaff extends Weapon {
  public NatureStaff(){
    image = weapon_green_magic_staff;
  }
  
    Bullet makeBullet(float x, float y, float r, Entity source){
    return new BlueCircleBullet(x, y, 0, 0, r, source);
  }
}
