enum DataType{
  WALKBOX, HITBOX
}


class UserData{
  Object obj;
  DataType data;
  
  public UserData(Object o, DataType d){
    obj = o;
    data = d;
  }
}
