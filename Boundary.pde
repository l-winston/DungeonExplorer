class Boundary {
  
  float x, y;
  float w, h;
  float r;
  Body body;
  
  // whether or not the boundary's body is represented by a circle
  boolean circular;

  Boundary(float x_, float y_, float w_, float h_) {
    // if there are 4 params, assume the Boundary will be a rectangle
    circular = false;

    x = x_;
    y = y_;
    w = w_;
    h = h_;
  }

  Boundary(float x_, float y_, float r_) {
    // if there are 3 params, assume the Boundary will be a
    circular = true;

    x = x_;
    y = y_;
    r = r_;
  }

  void setAwake(boolean awake) {
    if(body == null)
      return;
    body.setAwake(awake);
  }
  void createBody() {
    // body defenition is different whether or not the boundary is a circle
    if (circular) {
      BodyDef bd = new BodyDef();
      bd.position.set(box2d.coordPixelsToWorld(x, y));
      bd.type = BodyType.STATIC;
      body = box2d.createBody(bd);

      CircleShape ps = new CircleShape();
      ps.m_radius = box2d.scalarPixelsToWorld(r);

      body.createFixture(ps, 1);
    } else {
      BodyDef bd = new BodyDef();
      bd.position.set(box2d.coordPixelsToWorld(x, y));
      bd.type = BodyType.STATIC;
      body = box2d.createBody(bd);

      float box2dW = box2d.scalarPixelsToWorld(w/2);
      float box2dH = box2d.scalarPixelsToWorld(h/2);
      PolygonShape ps = new PolygonShape();
      ps.setAsBox(box2dW, box2dH);

      body.createFixture(ps, 1);
    }
    
    body.setUserData(new UserData(this, DataType.WALKBOX));
  }
  
  void destroyBody(){
    box2d.destroyBody(body);
  }

  void showHitbox() {
    stroke(255, 0, 0);
    strokeWeight(5);
    noFill();
    rectMode(CENTER);
    if (!circular)
      rect(x, y, w, h);
    else
      ellipse(x, y, r*2, r*2);
  }
}
