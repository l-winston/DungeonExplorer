void setup(){
  noSmooth();
  size(500, 500);
  loadImages();
}

void draw(){
  background(255);
  image(goblin_idle_anim[frameCount%32/8], width/4, height/4, width/2, height/2);
}
