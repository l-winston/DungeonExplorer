
float[] offsets = {0, 30, 30, 250, 60, 60, 60, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30};

PImage[][] sprites = {
  knight_m_run_anim, 
  elf_m_run_anim, 
  wizzard_m_run_anim, 

  big_demon_run_anim, 
  ogre_run_anim, 
  big_zombie_run_anim, 

  chort_run_anim, 
  wogol_run_anim, 
  necromancer_run_anim, 
  orc_shaman_run_anim, 
  orc_warrior_run_anim, 
  masked_orc_run_anim, 
  ice_zombie_run_anim, 
  zombie_run_anim, 
  swampy_run_anim, 
  muddy_run_anim, 
  skelet_run_anim, 
  imp_run_anim, 
  goblin_run_anim, 
  tiny_zombie_run_anim
};


class Train {

  float x, y;
  float vx;
  float sx, sy;
  float fx;

  float[] locations;
  public Train(float x, float y, float vx, float sx, float sy, float fx) {
    this.x = x;
    this.y = y;
    this.vx = vx;
    this.sx = sx;
    this.sy = sy;
    this.fx = fx;
    
    locations = new float[offsets.length];
    locations[0] = x;
    for (int i = 1; i < offsets.length; i++) {
      locations[i] = locations[i-1] - offsets[i];
    }
  }

  void step() {
    for (int i = 0; i < offsets.length; i++) {
      locations[i] += vx;
    }
  }

  void show() {
    pushStyle();
    imageMode(CORNERS);
    for (int i = 0; i < offsets.length; i++) {
      float w = sx*sprites[i][0].width;
      float h = sy*sprites[i][0].height;
      image(sprites[i][(frameCount/8)%sprites[i].length], locations[i], y - h, locations[i] + w, y);
    }
    popStyle();
  }
  
  boolean isDone(){
    float last = x;
    for(float i : offsets){
      last -= i;
    }
    
    return last >= fx;
  }
}
