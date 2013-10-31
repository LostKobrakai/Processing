import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

Minim minim;
AudioPlayer song;
FFT fft;
color bg;
Wave[] waves;
PVector q1;
PVector q2;
PVector q3;
PVector q4;

int amp;
 
void setup()
{
  //Generall Stuff
  size(displayWidth, displayHeight, P2D);
  colorMode(RGB, 1);
  background(1);
  bg = color(1);
  stroke(0);
  
  //Music Stuff
  waves = new Wave[20];
  for(int i = waves.length - 1; i >= 0 ; i--){
    waves[i] = new Wave(512);
  }
  minim = new Minim(this);
  song = minim.loadFile("song.mp3", 512);
  song.play();
  fft = new FFT(song.bufferSize(), song.sampleRate());
  q1 = new PVector();
  q2 = new PVector();
  q3 = new PVector();
  q4 = new PVector();
  amp = 50;
}
 
void draw()
{
  amp = mouseX/2;
  //Record Waves and Cycle them
  for(int i = waves.length - 1; i > 0 ; i--){
    waves[i] = waves[(i + waves.length - 1) % waves.length];
  }
  waves[0] = new Wave(512);
  fft.forward(song.mix);
  float steps = width*1.0/(song.mix.size()-1);
  for(int i = 0; i < song.mix.size() - 1; i++)
  {
    waves[0].saveWavePoint(i, i*steps, song.mix.get(i));
    waves[0].saveWavePoint(i+1, i*steps+steps, song.mix.get(i+1));
  }
  
  translate(width/2, height/2);
  if(mousePressed){
    q1.set(random(width/4), -1 * random(height/2));
    q2.set(-1 * random(width/4), -1 * random(height/2));
    q3.set(-1 * random(width/4), random(height/2));
    q4.set(random(width/4), random(height/2));
  }
  
  background(1);
  
  /*beginShape();
  vertex(q1.x, q1.y);
  vertex(q2.x, q2.y);
  vertex(q3.x, q3.y);
  vertex(q4.x, q4.y);
  endShape(CLOSE);*/
  
  for(int l = 0; l < song.mix.size() - 1; l++)
  {
    for(int i = 0; i < waves.length; i++){
      PVector v1 = waves[i].getWavePoint(l);
      PVector v2 = waves[i].getWavePoint(l+1);
      
      PVector start = PVector.lerp(q3, q2, i * 1.0 / waves.length);
      PVector end = PVector.lerp(q4, q1, i * 1.0 / waves.length);
      
      float x1 = lerp(start.x, end.x, l * 1.0/song.mix.size());
      float y1 = lerp(start.y, start.y, l * 1.0/song.mix.size()) + v1.y * amp;
      float x2 = lerp(start.x, end.x, (l+1) * 1.0/song.mix.size());
      float y2 = lerp(start.y, start.y, (l+1) * 1.0/song.mix.size()) + v2.y * amp;
      line(x1, y1, x2, y2);
    }
  }
}

int lin(int x, int y){
  return y * width + x;
}
 
void stop()
{
  song.close();
  minim.stop();
 
  super.stop();
}
