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

    if (data1.o.getClass() == Bullet.class) {
      if (((Bullet)data1.o).source != data2.o) {
        toDestroy.add((Bullet)data1.o);
        if (data2.o instanceof Entity)
          toDestroy.add((Entity)data2.o);
      }
    }

    if (data2.o.getClass() == Bullet.class) {
      if (((Bullet)data2.o).source != data1.o) {
        toDestroy.add((Bullet)data2.o);
        if (data1.o instanceof Entity)
          toDestroy.add((Entity)data1.o);
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
  Object o;
  DataType t;

  UserData(Object ob, DataType ty) {
    o = ob;
    t = ty;
  }
}
