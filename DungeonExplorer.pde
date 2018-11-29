void setup(){
  noSmooth();
  size(500, 500);
  loadImages();
}

void draw(){
  background(255);
  image(chest_full_open_anim[frameCount%12/4], width/4, height/4, width/2, height/2);
}
