import controlP5.*;
import processing.opengl.*;
import com.onformative.leap.*;
import com.leapmotion.leap.*;

LeapMotionP5 leap;
ControlP5 cp5;
int radius = 20;
Slider s;
int myColor = color(0,0,0);

void setup(){
  size(1280, 720, P3D);
  colorMode(RGB, 1);
  background(1);
  stroke(0);
  leap = new LeapMotionP5(this);
  cp5 = new ControlP5(this);
  setupControls(cp5);
}

void draw(){
  
  background(1);
  for (Finger f : leap.getFingerList()) {
    PVector position = leap.getTip(f);
    PVector velocity = leap.getVelocity(f);
    pushMatrix();
    translate(position.x, position.y, position.z);
    sphere(radius);
    popMatrix();
  }
  
  for (Tool t : leap.getToolList()) {
    PVector position = leap.getTip(t);
    PVector velocity = leap.getVelocity(t);
    pushMatrix();
    translate(position.x, position.y, position.z);
    sphere(radius);
    popMatrix();
  }
}
