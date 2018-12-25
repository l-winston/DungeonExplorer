enum Wall {
  TOP_1, 
    TOP_2, 
    TOP_3, 
    FRONT, 
    LEFT, 
    RIGHT, 
    FRONT_LEFT, 
    FRONT_RIGHT, 
    TOP_LEFT, 
    TOP_RIGHT, 
    CORNER_TOP_LEFT, 
    CORNER_TOP_RIGHT, 
    CORNER_LEFT, 
    CORNER_RIGHT, 
    CORNER_BOTTOM_LEFT, 
    CORNER_BOTTOM_RIGHT, 
    CORNER_FRONT_LEFT, 
    CORNER_FRONT_RIGHT, 
    INNER_CORNER_L_TOP_LEFT, 
    INNER_CORNER_L_TOP_RIGHT, 
    INNER_CORNER_MID_LEFT, 
    INNER_CORNER_MID_RIGHT, 
    INNER_CORNER_T_TOP_LEFT, 
    INNER_CORNER_T_TOP_RIGHT
}

Wall[] types = {  
  Wall.TOP_1, 
  Wall.TOP_2, 
  Wall.TOP_3, 
  Wall.FRONT, 
  Wall.LEFT, 
  Wall.RIGHT, 
  Wall.FRONT_LEFT, 
  Wall.FRONT_RIGHT, 
  Wall.TOP_LEFT, 
  Wall.TOP_RIGHT, 
  Wall.CORNER_TOP_LEFT, 
  Wall.CORNER_TOP_RIGHT, 
  Wall.CORNER_LEFT, 
  Wall.CORNER_RIGHT, 
  Wall.CORNER_BOTTOM_LEFT, 
  Wall.CORNER_BOTTOM_RIGHT, 
  Wall.CORNER_FRONT_LEFT, 
  Wall.CORNER_FRONT_RIGHT, 
  Wall.INNER_CORNER_L_TOP_LEFT, 
  Wall.INNER_CORNER_L_TOP_RIGHT, 
  Wall.INNER_CORNER_MID_LEFT, 
  Wall.INNER_CORNER_MID_RIGHT, 
  Wall.INNER_CORNER_T_TOP_LEFT, 
  Wall.INNER_CORNER_T_TOP_RIGHT
};

void showWall(float x, float y, Wall type) {
  pushMatrix();
  pushStyle();

  translate(x, y);
  switch(type) {
  case TOP_1:
    image(walls[WALL_TOP_1], 0, 0, tilew, tileh);
    break;  
  case TOP_2:
    image(walls[WALL_TOP_2], 0, 0, tilew, tileh);
    break;  
  case TOP_3:
    image(walls[WALL_TOP_3], 0, 0, tilew, tileh);
    break;
  case FRONT:
    image(walls[WALL_2], 0, 0, tilew, tileh);
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
  case CORNER_TOP_LEFT:
    image(walls[WALL_CORNER_TOP_LEFT], 0, 0, tilew, tileh);
    break;
  case CORNER_TOP_RIGHT:
    image(walls[WALL_CORNER_TOP_RIGHT], 0, 0, tilew, tileh);
    break;
  case CORNER_LEFT:
    image(walls[WALL_CORNER_LEFT], 0, 0, tilew, tileh);
    break;
  case CORNER_RIGHT:
    image(walls[WALL_CORNER_RIGHT], 0, 0, tilew, tileh);
    break;
  case CORNER_BOTTOM_LEFT:
    image(walls[WALL_CORNER_BOTTOM_LEFT], 0, 0, tilew, tileh);
    break;
  case CORNER_BOTTOM_RIGHT:
    image(walls[WALL_CORNER_BOTTOM_RIGHT], 0, 0, tilew, tileh);
    break;
  case CORNER_FRONT_LEFT:
    image(walls[WALL_CORNER_FRONT_LEFT], 0, 0, tilew, tileh);
    break;
  case CORNER_FRONT_RIGHT:
    image(walls[WALL_CORNER_FRONT_RIGHT], 0, 0, tilew, tileh);
    break;
  case INNER_CORNER_L_TOP_LEFT:
    image(walls[WALL_INNER_CORNER_L_TOP_LEFT], 0, 0, tilew, tileh);
    break;
  case INNER_CORNER_L_TOP_RIGHT:
    image(walls[WALL_INNER_CORNER_L_TOP_RIGHT], 0, 0, tilew, tileh);
    break;
  case INNER_CORNER_MID_LEFT:
    image(walls[WALL_INNER_CORNER_MID_LEFT], 0, 0, tilew, tileh);
    break;
  case INNER_CORNER_MID_RIGHT:
    image(walls[WALL_INNER_CORNER_MID_RIGHT], 0, 0, tilew, tileh);
    break;
  case INNER_CORNER_T_TOP_LEFT:
    image(walls[WALL_INNER_CORNER_T_TOP_LEFT], 0, 0, tilew, tileh);
    break;  
  case INNER_CORNER_T_TOP_RIGHT:
    image(walls[WALL_INNER_CORNER_T_TOP_RIGHT], 0, 0, tilew, tileh);
    break;
  }
  popStyle();
  popMatrix();
}
