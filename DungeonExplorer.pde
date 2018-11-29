void setup(){
  noSmooth();
  size(500, 500);
  loadImages();
}

void draw(){
  background(0);
  image(coin_anim[frameCount%4], width/4, height/4, width/2, height/2);
}
