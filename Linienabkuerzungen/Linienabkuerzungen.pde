void setup() {
  punkte = new JSONArray();
  size(1280, 768);
  colorMode(HSB, 100);
  background(0, 0, 100);
  stroke(0,0,0);
  fill(0,0,0,0);
}

JSONArray punkte;

void draw(){
  if(mousePressed){
    //Punkte Speichern
    int i = punkte.size();
    if(i == 0 || i < 10 && (mouseX != punkte.getJSONObject(i-1).getInt("mX") || mouseY != punkte.getJSONObject(i-1).getInt("mY") )){
      JSONObject punkt = new JSONObject();
      punkt.setInt("mX", mouseX);
      punkt.setInt("mY", mouseY);
      punkte.setJSONObject(i, punkt);
    }else if(mouseX != punkte.getJSONObject(i-1).getInt("mX") || mouseY != punkte.getJSONObject(i-1).getInt("mY") ){
      stroke(0,0,0,40);
      line(punkte.getJSONObject(0).getInt("mX"), punkte.getJSONObject(0).getInt("mY"), mouseX, mouseY);
      //println("input");
      //println(punkte);
      punkte.remove(0);
      //println(punkte.getJSONObject(0));
      JSONObject punkt = new JSONObject();
      punkt.setInt("mX", mouseX);
      punkt.setInt("mY", mouseY);
      punkte.setJSONObject(i-1, punkt);
    }
    stroke(0,0,0);
    line(pmouseX, pmouseY, mouseX, mouseY);
  }
}
