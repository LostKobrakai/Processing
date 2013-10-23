import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

Minim minim;
AudioPlayer song;
FFT fft;
color bg;
Wave[] waves;
 
void setup()
{
  size(1280, 720, P3D);
  colorMode(RGB, 1);
  background(1);
  bg = color(1);
  stroke(0);
  frameRate(20);
  
  waves = new Wave[20];
  
  for(int i = waves.length - 1; i >= 0 ; i--){
    waves[i] = new Wave(512);
    println(i);
  }
 
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
  
  for(int i = waves.length - 1; i > 0 ; i--){
    waves[i] = waves[(i + waves.length - 1) % waves.length];
  }
  
  waves[0] = new Wave(512);
  //if(frameCount < 105 && frameCount > 100) println(frameCount +" : "+ waves[0].getWavePoint(123) +" : "+ waves[1].getWavePoint(123) +" : "+ waves[2].getWavePoint(123));
  
  
  translate(width/4, height/4);
  rotateY(TAU/8);
  rotateX(-TAU/16);
  background(1);
  
  fft.forward(song.mix);
 
  float steps = width*1.0/(song.mix.size()-1);
  for(int i = 0; i < song.mix.size() - 1; i++)
  {
    if(i == 0) println(i+", "+i*steps+", "+(song.mix.get(i) * 400));
    if(i == 0) println(waves[0].getWavePoint(0));
    if(i == 0) println(waves[1].getWavePoint(0));
    waves[0].saveWavePoint(i, i*steps, song.mix.get(i) * 400);
    waves[0].saveWavePoint(i+1, i*steps+steps, song.mix.get(i+1) * 400);
    if(i == 0) println(waves[0].getWavePoint(0));
    if(i == 0) println(waves[1].getWavePoint(0));
  }
  for(int l = 0; l < song.mix.size() - 1; l++)
  {
    for(int i = 0; i < waves.length; i++){
      PVector v1 = waves[i].getWavePoint(l);
      PVector v2 = waves[i].getWavePoint(l+1);
      line(v1.x, 360 + v1.y, -100*i, v2.x, 360 + v2.y, -100*i);
    }
  }
  println("--");
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
