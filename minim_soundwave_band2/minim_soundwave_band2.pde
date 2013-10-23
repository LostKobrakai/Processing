import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

Minim minim;
AudioPlayer song;
FFT fft;
color bg;
 
void setup()
{
  size(1280, 720);
  colorMode(RGB, 1);
  background(1);
  bg = color(1);
  stroke(0);
 
  // always start Minim first!
  minim = new Minim(this);
 
  // specify 512 for the length of the sample buffers
  // the default buffer size is 1024
  song = minim.loadFile("song.mp3", 512);
  song.play();
 
  // an FFT needs to know how 
  // long the audio buffers it will be analyzing are
  // and also needs to know 
  // the sample rate of the audio it is analyzing
  fft = new FFT(song.bufferSize(), song.sampleRate());
}
 
void draw()
{
  noStroke();
  fill(1,1,1,.2);
  rect(0,0,width,height);
  stroke(0);
  
  fft.forward(song.mix);
 
  float steps = width*1.0/(song.mix.size()-1);
  println(steps);
  for(int i = 0; i < song.mix.size() - 1; i++)
  {
    line(i*steps, 360 + song.mix.get(i)*400, i*steps+steps, 360 + song.mix.get(i+1)*400);
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
