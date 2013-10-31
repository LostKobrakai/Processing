class Pendel{
  
  //Daten des Pendels
  PVector pos;
  PVector lastPos;
  PVector vel;
  PVector wpoint;
  
  //Maximal und Minimalpunkte erkennen
  PVector tmpLastMax;
  PVector tmpLastMin;
  PVector lastMax;
  PVector lastMin;
  boolean growing;
  
  //Konstruktor (Einmalig ausgeführt beim Erstellen des Pendels)
  Pendel(PVector start, PVector speed, PVector middle){
    pos = new PVector(start.x, start.y);
    vel = new PVector(speed.x, speed.y);
    wpoint = new PVector(middle.x, middle.y);
    lastPos = new PVector(start.x, start.y);
    tmpLastMax = new PVector(start.x, start.y);
    tmpLastMin = new PVector(start.x, start.y);
    lastMax = new PVector(start.x, start.y);
    lastMin = new PVector(start.x, start.y);
  }
  
  //Bewegung zum nächsten Punkt in der Pendellaufbahn
  void move(){
    //Alten Punkt zwischenspeichern und zum nächsten gehen
    lastPos.set(pos.x, pos.y);
    vel.mult(0.999);
    pos.add(vel);
    PVector gravity = PVector.sub(wpoint, pos);
    gravity.normalize();
    vel.add(gravity);
    
    //Errechnung von Maximalwerten, beim Ersten ausführen letzten Wert als Minimalwert setzen
    if(PVector.dist(pos, wpoint) > PVector.dist(tmpLastMax, wpoint)){
      if(!growing){
        lastMin.set(tmpLastMin.x, tmpLastMin.y);
      }
      tmpLastMax.set(pos.x, pos.y);
      tmpLastMin.set(pos.x, pos.y);
      growing = true;
    }else //Errechnung von Minimalwerten, beim Ersten ausführen letzten Wert als Maximalwert setzen
   if(PVector.dist(pos, wpoint) < PVector.dist(tmpLastMin, wpoint)){
      if(growing){
        lastMax.set(tmpLastMax.x, tmpLastMax.y);
        //line(lastMax.x, lastMax.y, wpoint.x, wpoint.y);
      }
      tmpLastMin.set(pos.x, pos.y);
      tmpLastMax.set(pos.x, pos.y);
      growing = false;
    }
  }
  
  //Aktuelle Position ausgeben
  PVector getPos(){
    return pos;
  }
  
  //Letzte Position ausgeben
  PVector getLastPos(){
    return lastPos;
  }
  
  //Abstand zum Mittelpunkt ausgeben
  float getDist(){
    return PVector.dist(pos, wpoint);
  }
  
  //Abstand des letzen Maximalwertes zum Mittelpunkt
  float getDistLastMax(){
    return PVector.dist(lastMax, wpoint);
  }
  
  //Neuer Startpunkt und Geschwindigkeit setzen: Pendel wird neu angestoßen
  void reset(PVector newpos, PVector newvel){
    pos.set(newpos.x, newpos.y);
    vel.set(newvel.x, newvel.y);
    lastMax.set(newpos.x, newpos.y);
    lastMin.set(newpos.x, newpos.y);
    tmpLastMax.set(newpos.x, newpos.y);
    tmpLastMin.set(newpos.x, newpos.y);
  }
}
