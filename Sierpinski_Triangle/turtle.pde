class Turtle {
  float x, y; // Current position of the turtle
  float angle = -90; // Current heading of the turtle
  boolean penDown = true; // Is pen down?
  
  // Set up initial position
  Turtle (float xin, float yin) {
    x = xin;
    y = yin;
  }
  
  // Move forward by the specified distance
  void forward (float distance) {
    
    // Calculate the new position
    float xtarget = x+cos(radians(angle)) * distance;
    float ytarget = y+sin(radians(angle)) * distance;
    
    // If the pen is down, draw a line to the new position
    if (penDown) line(x, y, xtarget, ytarget);
    
    // Update position
    x = xtarget;
    y = ytarget;
    
  }
  
  // Move back by specified distance
  void back (float distance) {
    forward(-distance);
  }
  
  // Turn left by given angle
  void left (float turnangle) {
    angle -= turnangle;
  }
  
  // Turn right by given angle
  void right (float turnangle) {
    angle += turnangle;
  }
  
  // Set the pen to be up
  void penUp() {
    penDown = false;
  }
  
  // Set the pen to be down
  void penDown() {
    penDown = true;
  }
  
  void reset(float xin, float yin){
    x = xin;
    y = yin;
    angle = -90;
  }
}
