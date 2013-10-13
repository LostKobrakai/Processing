class Line{
  int startX;
  int startY;
  int currentX;
  int currentY;
  int iteration;
  int angle;
  int speed;
  int state;
  
  Line(int x, int y, int a){
    startX = x;
    startY = y;
    angle = a;
    
    speed = 1;
    iteration = 1;
    state = 1;
  }
  
  int[] moveLine(){
    int[] current = {floor(sin(radians(angle)) * iteration * speed), floor(cos(radians(angle)) * iteration * speed)};
    return current;
  }
  
  void drawLine(color[] p, color bg){
    int[] m = moveLine();
    if( checkCoords(m[0], m[1]) && p[ lin(m[0], m[1]) ] == bg){
      currentX = floor(sin(radians(angle)) * iteration * speed);
      currentY = floor(cos(radians(angle)) * iteration * speed);
      iteration++;
    }else{
      if(state == 1) state = 2;
    }
    line(startX, startY, currentX, currentY);
  }
  
  Line[] startNewLines(){
    if(state == 2){
      state = 3;
      
      int c = floor(random(3));
      Line[] lines = new Line[c];
      for(int i = 0; i < c; i++){
        lines[i] = new Line(0, 0, floor(random(90)));
      }
      return lines;
    }else{
      Line[] lines = new Line[0];
      return lines;
    }
  }
}
