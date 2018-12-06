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
