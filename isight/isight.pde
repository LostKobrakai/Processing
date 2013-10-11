import processing.video.*;
Capture myCapture;
void setup()
{
  size(640, 480);
  // The name of the capture device is dependent on
  // the cameras that are currently attached to your
  // computer. To get a list of the
  // choices, uncomment the following line
  // println(Capture.list());
 
  // To select the camera, replace "Camera Name"
  // in the next line with one from Capture.list()
  // myCapture = new Capture(this, width, height, Capture.list()[0], 30);
 
  // This code will try to use the camera used
  myCapture = new Capture(this, width, height, 30);
  myCapture.start();
}
void draw() {
  if(myCapture.available() == true){
    myCapture.read();
    image(myCapture, 0, 0);
  }
}

