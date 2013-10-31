//Import der Bibliotheken
import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

//Variablen für die Audiospur
Minim minim;
AudioPlayer player;
AudioInput input;
AudioOutput out;
FFT fft;
BeatDetect beat;
float beatRadius;

//Variablen für das Pendel
Pendel p;
PVector start;
PVector middle;
PVector vel;
float lastMax;

void setup(){
  //Einstellungen für das Fenster
  size(displayWidth, displayHeight, P2D);
  smooth(4);
  colorMode(RGB, 1);
  background(1);
  stroke(0);
  ellipseMode(CENTER);
  
  //Erstellung des Audioplayers
  minim = new Minim(this);
  player = minim.loadFile("song.mp3", 2048);
  input = minim.getLineIn();
  player.play();
  fft = new FFT(player.bufferSize(), player.sampleRate());
  //fft.linAverages(1);
  beat = new BeatDetect();
  beatRadius = 5;
  //player.loop();
  
  //Erstellung des Pendels
  start = new PVector(width/2, 200);
  middle = new PVector(width/2, height/2);
  vel = new PVector(20, 20);
  p = new Pendel(start, vel, middle);
}

void draw(){
  //Background??
  //background(1);
  
  //FrameRate -.-
  rect(0,0,40,30);
  fill(0);
  text(str(floor(frameRate*10)*1.0/10), 5, 20);
  fill(1, .5);
  
  //Pendelfortbewegung
  p.move();
  PVector curP = p.getPos();
  PVector lastP = p.getLastPos();
  
  //FFT Line 
  fft.forward(player.mix);
  drawFreqBetween(middle, curP, 1);
  
  //FFT
  fft.forward(player.mix);
  float radius = constrain(fft.getBand(1), 5, 200);
  //ellipse(curP.x, curP.y, radius, radius);
  
  //Beatdetect
  /*beat.detect(player.mix);
  if( beat.isOnset() ) beatRadius = 30;
  ellipse(curP.x, curP.y, beatRadius, beatRadius);
  beatRadius = constrain(beatRadius * 0.5, 5, 30);*/
  
  //Linie zeichnen
  //line(lastP.x, lastP.y, curP.x, curP.y);
  
  //Ab einem bestimmten "Durchmesser" die lautstärke schrittweise runterdrehen, bis pause
  if ( player.isPlaying() ){
    if(p.getDistLastMax() <= 100 && p.getDistLastMax() != lastMax){ // Abhängig von der Gesamtgröße????
      float gain = map(p.getDistLastMax(), 0, 100, -80, 0);
      player.setGain(gain);
      //player.shiftGain(player.getGain(), gain, 50);
      lastMax = p.getDistLastMax();
    }
    if(player.getGain() == -80){
      println("=== PAUSE ===");
      player.pause();
    }
  }
}

//Pendel neu setzen
void mousePressed(){
  start.set(mouseX, mouseY);
  vel.set(-vel.x, vel.y);
  p.reset(start, vel);
  if(player.getGain() == -80) player.setGain(-25);
  player.shiftGain(player.getGain(), 0, 500);
  player.play();
  println("=== RESUME ===");
}

void keyPressed(){
  if(keyCode == 32){ // Leertaste
    save("screenshot"+"_"+day()+"-"+month()+"_"+hour()+"-"+minute()+".jpg");
  }
}

void stop()
{
  player.close();
  input.close();
  minim.stop();
  super.stop();
}
