// contact listener to detect bullet hit (and more)
class CustomListener implements ContactListener {
  CustomListener() {
  }

  // This function is called when a new collision occurs
  void beginContact(Contact cp) {
    // Get both shapes
    Fixture f1 = cp.getFixtureA();
    Fixture f2 = cp.getFixtureB();

    // Get both bodies
    Body b1 = f1.getBody();
    Body b2 = f2.getBody();

    // Get our objects that reference these bodies

    if (!(b1.getUserData() instanceof UserData) || !(b2.getUserData() instanceof UserData)) {
      return;
    }

    UserData data1 = (UserData)b1.getUserData();
    UserData data2 = (UserData)b2.getUserData();

    if (data1 == null || data2 == null)
      return;

    if (data1.obj instanceof Bullet) {
      if (((Bullet)data1.obj).source != data2.obj && data2.type != DataType.WALKBOX) {
        ((Bullet)data1.obj).hit();
        //toDestroy.add((Bullet)data1.o);
        if (data2.obj instanceof Entity)
          ((Entity)data2.obj).hit();
      }
    }

    if (data2.obj instanceof Bullet) {
      if (((Bullet)data2.obj).source != data1.obj && data1.type != DataType.WALKBOX) {
        ((Bullet)data2.obj).hit();
        //toDestroy.add((Bullet)data2.o);
        if (data1.obj instanceof Entity)
          ((Entity)data1.obj).hit();
      }
    }
  }

  void endContact(Contact contact) {
    // TODO Auto-generated method stub
  }

  void preSolve(Contact contact, Manifold oldManifold) {
    // TODO Auto-generated method stub
  }

  void postSolve(Contact contact, ContactImpulse impulse) {
    // TODO Auto-generated method stub
  }
}

enum DataType {
  WALKBOX, HITBOX
}

class UserData {
  Object obj;
  DataType type;

  UserData(Object ob, DataType ty) {
    obj = ob;
    type = ty;
  }
}
