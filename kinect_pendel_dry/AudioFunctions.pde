void drawFreqBetween(PVector a, PVector b, float factor){
  pushMatrix();
  translate(a.x, a.y);
  PVector line = PVector.sub(b, a);
  rotate(line.heading());
  float steps = line.mag()*1.0/(player.mix.size()-1);
  for(int i = 0; i < player.mix.size() -1; i++){
    line(i*steps, player.mix.get(i) * line.mag()/factor, i*steps+steps, player.mix.get(i+1) * line.mag()/factor);
  }
  popMatrix();
}
