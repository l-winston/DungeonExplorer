enum Wall {
  FRONT, LEFT, RIGHT, NONE, FRONT_LEFT, FRONT_RIGHT, TOP_LEFT, TOP_RIGHT
}

void showWall(float x, float y, Wall type) {
  pushMatrix();
  pushStyle();

  translate(x, y);
  switch(type) {
  case FRONT:
    image(walls[WALL_2], 0, 0, tilew, tileh);
    image(walls[WALL_TOP_2], 0, -tileh, tilew, tileh);
    break;
  case LEFT:
    image(walls[WALL_MID_LEFT], 0, 0, tilew, tileh);
    break;
  case RIGHT:
    image(walls[WALL_MID_RIGHT], 0, 0, tilew, tileh);
    break;
  case FRONT_LEFT:
    image(walls[WALL_FRONT_LEFT], 0, 0, tilew, tileh);
    break;
  case FRONT_RIGHT:
    image(walls[WALL_FRONT_RIGHT], 0, 0, tilew, tileh);
    break;    
  case TOP_LEFT:
    image(walls[WALL_TOP_LEFT], 0, 0, tilew, tileh);
    break;    
  case TOP_RIGHT:
    image(walls[WALL_TOP_RIGHT], 0, 0, tilew, tileh);
    break;
  }
  popStyle();
  popMatrix();
}
