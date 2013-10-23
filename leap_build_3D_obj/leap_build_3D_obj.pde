import controlP5.*;
import com.onformative.leap.*;
import com.leapmotion.leap.*;

LeapMotionP5 leap;
ControlP5 cp5;
Obj3D obj;

int objIndex;

void setup(){
  size(1280, 720, P3D);
  colorMode(RGB, 1);
  background(1);
  leap = new LeapMotionP5(this);
  cp5 = new ControlP5(this);
  obj = new Obj3D(width*height);
  
  cp5.addNumberbox("objIndex")
   .setPosition(20,100)
   .setSize(100,14)
   .setScrollSensitivity(1.0);
}

void draw(){
  pushMatrix();
  background(1);
  
  fill(.5);
  stroke(.7);
  beginShape();
  obj.buildShape();
  endShape();
  
  Finger f = leap.getFinger(0);
  PVector pos = leap.getTip(f);
  translate(pos.x, pos.y, pos.z);
  sphere(20);
  
  if(keyPressed){
    obj.addVertex(leap.getTip(f));
    objIndex = obj.getIndex();
  }
  
  popMatrix();
}
