import com.onformative.leap.*;
import com.leapmotion.leap.*;

LeapMotionP5 leap;
int myColor = color(0,0,0);

void setup(){
  size(1280, 720, P3D);
  colorMode(RGB, 1);
  background(1);
  stroke(0);
  leap = new LeapMotionP5(this);
}

void draw(){
  
  //background(1);
  Finger f = leap.getFinger(0);
  PVector position = leap.getTip(f);
  PVector velocity = leap.getVelocity(f);
  translate(position.x, position.y, position.z);
  stroke(0,0,0,position.z%1);
  sphere(10);
}
