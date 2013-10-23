import java.awt.image.BufferedImage;
import java.awt.*;
import processing.video.*;

PImage shot1;
PImage shot2;
Capture cap;
boolean draw;
int counter;

void setup() {
  size(421, 144, P2D);
  background(255);
  smooth(4);
  frameRate(5);
  fill(0);
  draw = false;
  counter = 0;
  cap = new Capture(this, 1280, 720, 30);
  cap.start();
}

void draw () {
  if(cap.available() == true) cap.read();
  
  // Draw last screenshots if available;
  if(draw){
    background(255);
    image(shot1, 0, 0, 256, 144);
    image(shot2, 256, 0, 165, 108);
    text("Counter: "+counter, 266, 128);
  }
  
  if(draw && minute() % 10 == 1){
    draw = false;
  }
  
  //Get new Screenshots every 10 Minutes
  if(minute() % 10 == 0 && draw == false){
    shot1 = processScreenShot(0);
    shot2 = processScreenShot(1);
    processCamShot();
    println(day()+"_"+month()+"-"+hour()+"_"+minute()+": Screenshots taken");
    draw = true;
    counter++;
  }
}

void processCamShot(){
  if(cap.available() == true) cap.read();
  image(cap, 357, 108, 64, 36);
  PGraphics tmp = createGraphics(1280, 720);
  tmp.beginDraw();
  tmp.image(cap, 0, 0, 1280, 720);
  tmp.endDraw();
  tmp.save("screen-"+day()+"_"+month()+"-"+hour()+"_"+minute()+"-i.tif");
}

PImage processScreenShot(int i){
  PImage screenShot = getScreen(i);
  PGraphics tmp = createGraphics(screenShot.width, screenShot.height);
  tmp.beginDraw();
  tmp.image(screenShot, 0, 0, screenShot.width, screenShot.height);
  tmp.endDraw();
  tmp.save("screen-"+day()+"_"+month()+"-"+hour()+"_"+minute()+"-"+i+".tif");
  return screenShot;
}

PImage getScreen(int i) {
  GraphicsEnvironment ge = GraphicsEnvironment.getLocalGraphicsEnvironment();
  GraphicsDevice[] gs = ge.getScreenDevices();
  if(i >= gs.length) System.err.println("Screen not found.");
  DisplayMode mode = gs[i].getDisplayMode();
  Rectangle bounds = new Rectangle(2560*i, 0, mode.getWidth(), mode.getHeight());
  BufferedImage desktop = new BufferedImage(mode.getWidth(), mode.getHeight(), BufferedImage.TYPE_INT_RGB);

  try {
    desktop = new Robot(gs[0]).createScreenCapture(bounds);
  }
  catch(AWTException e) {
    System.err.println("Screen capture failed.");
  }

  return (new PImage(desktop));
}

void mousePressed(){
  processCamShot();
}

void stop(){
  cap.stop();
}
