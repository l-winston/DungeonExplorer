class Hitbox{
  float x, y, w, h;
  public Hitbox(float x, float y, float w, float h){
    this.x=x;
    this.y=y;
    this.w=w;
    this.h=h;
  }
  
  void show(){
    pushMatrix();
    pushStyle();
    
    rectMode(CENTER);
    fill(0, 255, 0);
    translate(x*tilew, y*tileh);
    rect(0, 0, w*tilew, h*tileh);
    
    popStyle();
    popMatrix();
  }
}
