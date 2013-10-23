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
  loadPixels();
  for(int h = 0; h < height; h++){
    for(int w = 0; w < width; w++){
      if(h+5 < height) pixels[ lin(w,h) ] = pixels[ lin(w, h+1)];
      else pixels[ lin(w,h) ] = bg;
    }
  }
  updatePixels();
  
  fft.forward(song.mix);
 
  float steps = width*1.0/(song.mix.size()-1);
  println(steps);
  for(int i = 0; i < song.mix.size() - 1; i++)
  {
    line(i*steps, 620 + song.mix.get(i)*100, i*steps+steps, 620 + song.mix.get(i+1)*100);
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
