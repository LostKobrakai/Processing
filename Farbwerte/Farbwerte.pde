color savedColor;

void setup() {
  size(1280, 768);
  colorMode(HSB, 100);
  background(0, 0, 100);
  fill(0,0,0);
}

String getRGBCode(color col, String div){
  String text = str( int( red(col) * 2.55 ) )+div;
  text += str( int( green(col) * 2.55 ) )+div;
  text += str( int( blue(col) * 2.55 ) );
  return text;
}

void draw() {
  //Save Image on Klick (Bevor die Farbe sich ändert)
  if(mousePressed) saveFrame("color_"+getRGBCode(savedColor, "_")+".png");
  
  float hue = float(mouseX) / float(width) * 100.0;
  float saturation = 50;
  float brightness = 100 - (float(mouseY) / float(height) * 100.0); // 100 - dass oben hell unten dunkel
  color currentColor = color(hue, saturation, brightness);
  savedColor = currentColor;
  
  background(currentColor);

  if(brightness <= 40) fill(0,0,100);
  else fill(0,0,0); 
  textAlign(CENTER);
  textSize(20);
  textLeading(30);
  String colorText;
  colorText = "RGB(255): ";
  colorText += getRGBCode(currentColor, "/")+"\n";
  
  colorText += "RGB(1): ";
  colorText += str( red(currentColor) / 100 )+"/";
  colorText += str( green(currentColor) / 100 )+"/";
  colorText += str( blue(currentColor) / 100 )+"\n";
  
  colorText += "HSB(100): ";
  colorText += str( int( red(currentColor) ) )+"/";
  colorText += str( int( green(currentColor) ) )+"/";
  colorText += str( int( blue(currentColor) ) )+"\n";
  
  colorText += "\nclick to save image.";
  
  text(colorText, width / 2, height / 2);
  
}

