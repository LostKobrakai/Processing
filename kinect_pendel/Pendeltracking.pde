class Pendeltracking{
  SimpleOpenNI k;
  
  //Abstand
  float thresholdMin;
  float thresholdMax;
  
  //Pendel
  PVector pos;
  PVector vel;
  PVector wpoint;
  PVector lastPos;
  
  PVector[] velSave;
  float[] velSmoothMag;
  float[] velMag;
  
  PImage newDepthImage;
  
  boolean lock;
  
  Pendeltracking(SimpleOpenNI kinect, float tmin, float tmax){
    k = kinect;
    thresholdMin = tmin;
    thresholdMax = tmax;
    
    k.setMirror(false);
    k.enableDepth();
    k.alternativeViewPointDepthToImage();
    
    pos = new PVector(0, 0);
    vel = new PVector(0, 0);
    lastPos = new PVector(0, 0);
    wpoint = new PVector(285, 264);
    
    newDepthImage = k.depthImage();
    
    velSmoothMag = new float[640];
    velMag = new float[640];
    velSave = new PVector[10];
    for(int i = velSave.length - 1; i>= 0; i--){
      velSave[i] = new PVector(0, 0);
    }
  }
  
  void track(){
    k.update();
    
    int[] depthMap = k.depthMap();
    int index;
    PVector realWorldPoint;
    PImage save = new PImage(640, 480);
    PImage depth = k.depthImage();
    
    float minX = 640;
    float maxX = 0;
    float minY = 480;
    float maxY = 0;
    
    save.loadPixels();
    depth.loadPixels();
    for (int y=0; y < k.depthHeight();y++){
      for (int x=0; x < k.depthWidth();x++){
        index = x + y * k.depthWidth();
        if (depthMap[index] > 0){ 
          realWorldPoint = k.depthMapRealWorld()[index];
          if (realWorldPoint.z >= thresholdMin && realWorldPoint.z <= thresholdMax){
            if(x < minX) minX = x;
            if(x > maxX) maxX = x;
            if(y < minY) minY = y;
            if(y > maxY) maxY = y;
            save.pixels[index] = color(0, 1, 0); 
          }
          else save.pixels[index] = depth.pixels[index];
        }
      }
    }
    save.updatePixels();
    
    lastPos.set(pos.x, pos.y);
    pos.set(lerp(minX, maxX, 0.5), lerp(minY, maxY, 0.5));
    vel = PVector.sub(pos, lastPos);
    this.saveVel();
    
    newDepthImage = save;
  }
  
  void saveVel(){
    for(int i = velSave.length - 1; i > 0; i--){
      velSave[i].set(velSave[i-1].x, velSave[i-1].y);
    }
    velSave[0].set(vel.x, vel.y);
    
    int i = frameCount % velMag.length;
    velMag[i] = vel.mag();
    velSmoothMag[i] = this.getSmoothVel().mag();
  }
  
  void drawController(){
    pushMatrix();
    pushStyle();
    
    fill(0);
    rect(0, 0, 640, 600);
    stroke(255, 0, 0);
    noFill();
    line(0, 480, 640, 480);
    image(newDepthImage, 0, 0);
    line(lastPos.x, lastPos.y, pos.x, pos.y);
    line(wpoint.x, wpoint.y, pos.x, pos.y);
    
    fill(1);
    text("Geschwindigkeit: "+str(vel.mag()), 0, 495);
    text("Position: "+pos.x+":"+pos.y, 0, 510);
    text("Geschwindigkeit Ø: "+this.getSmoothVel().mag(), 0, 525);
    text("X: "+mouseX, 240, 495);
    text("Y: "+mouseY, 240, 510);
    text("Min: "+thresholdMin, 380, 495);
    text("Max: "+thresholdMax, 380, 510);
    text("LOCKED: "+str(lock), 520, 495);
    text("FPS: "+str(frameRate), 520, 510);
    
    for(int i = 0; i < velMag.length; i++){
      line(i, 550, i, 550 - constrain(velMag[i], 0, 30));
      line(i, 590, i, 590 - constrain(velSmoothMag[i], 0, 30));
    }
    
    popStyle();
    popMatrix();
  }
  
  PVector getPos(){
    return pos;
  }
  
  PVector getVel(){
    return vel;
  }
  
  PVector getSmoothVel(){
    float allX = 0;
    float allY = 0;
    for(int i = velSave.length - 1; i >= 0; i--){
      allX += velSave[i].x;
      allY += velSave[i].y;
    }
    PVector smoothVel = new PVector(allX/velSave.length, allY/velSave.length);
    return smoothVel;
  }
  
  PVector getLastPos(){
    return lastPos;
  }
  
  PVector getMiddle(){
    return wpoint;
  }
  
  PImage getNewDepthImage(){
    return newDepthImage;
  }
  
  float getThresholdMin(){
    return thresholdMin;
  }
  
  float getThresholdMax(){
    return thresholdMax;
  }
  
  void setMiddle(PVector v){
    if(!lock) wpoint.set(v.x, v.y);
  }
  
  void setMiddle(float x, float y){
    if(!lock) wpoint.set(x, y);
  }
  
  void addThreshold(float min, float max){
    if(!lock){
      thresholdMax += max;
      thresholdMin += min;
    }
  }
  
  void subThreshold(float min, float max){
    if(!lock){
      thresholdMax -= max;
      thresholdMin -= min;
    }
  }
  
  void toggleLock(){
    if(lock) lock = false;
    else lock = true;
  }
}
