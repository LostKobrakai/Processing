/* --------------------------------------------------------------------------
 * SimpleOpenNI User3d Test
 * --------------------------------------------------------------------------
 * Processing Wrapper for the OpenNI/Kinect 2 library
 * http://code.google.com/p/simple-openni
 * --------------------------------------------------------------------------
 * prog:  Max Rheiner / Interaction Design / Zhdk / http://iad.zhdk.ch/
 * date:  12/12/2012 (m/d/y)
 * ----------------------------------------------------------------------------
 */

import SimpleOpenNI.*;
import hypermedia.video.*;
import java.awt.*;

Pendeltracking ptrack;
SimpleOpenNI context;
boolean lock;

void setup()
{
  size(displayWidth, displayHeight, P2D);
  colorMode(RGB, 1);
  context = new SimpleOpenNI(this);
  if (context.isInit() == false)
  {
    println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
    exit();
    return;
  }
  ptrack = new Pendeltracking(context, 1200, 1500);
}

void draw()
{
  ptrack.track();
  ptrack.drawController();
}


// -----------------------------------------------------------------
// Keyboard events

void keyPressed()
{
  switch(key)
  {
  case ' ':
    context.setMirror(!context.mirror());
    break;
  }

  switch(keyCode)
  {
  case TAB:
    ptrack.toggleLock();
    break;
  case RETURN:
    ptrack.setMiddle(ptrack.getPos());
    break;
  case ENTER:
    ptrack.setMiddle(ptrack.getPos());
    break;
  case LEFT:
    ptrack.subThreshold(10, 0);
    break;
  case RIGHT:
    ptrack.addThreshold(10, 0);
    break;
  case UP:
    ptrack.addThreshold(0, 10);
    break;
  case DOWN:
    ptrack.subThreshold(0, 10);
    break;
  }
}

void mousePressed(){
  ptrack.setMiddle(mouseX, mouseY);
}

