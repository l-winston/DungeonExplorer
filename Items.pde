abstract class Item {
  PImage icon;
  String name;
  
  
}

abstract class Weapon extends Item {
  PImage image;
  
  abstract Bullet makeBullet(float x, float y, Entity source);
  
}

class FireStaff extends Weapon {

  public FireStaff(){
    image = weapon_red_magic_staff;
  }
  
  Bullet makeBullet(float x, float y, Entity source){
    return new FireBullet(x, y, 0, 0, 10, source);
  }
}

class NatureStaff extends Weapon {
  public NatureStaff(){
    image = weapon_green_magic_staff;
  }
  
    Bullet makeBullet(float x, float y, Entity source){
    return new GreenCircleBullet(x, y, 0, 0, 20, source);
  }
}
