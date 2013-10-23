package colorSelector;

import processing.core.*;

/* 
 * The Color Mixer Applet
 * Code borrowed from ColorSelector.java - part of the processing distribution
 * loadPixels() and updatePixels() are more smooth at updating the panel
 * that redrawing the paint area. 
 */
@SuppressWarnings("serial")
class MixerApplet extends PApplet {

	static final int WIDE = 256;
	static final int HIGH = 256;
	int lastX, lastY;
	ColorSelectorPlus parent;

	public void setup() {
		size(WIDE, HIGH);
		colorMode(HSB, 360, 256, 256);
		noFill();
		rectMode(CENTER);
		noLoop();
		loadPixels();
	}

	public void draw() {
		if ((width != WIDE) || (height < HIGH)) {
			System.out.println("bad size " + width + " " + height);
			return;
		}
		int index = 0;
		for (int j = 0; j < 256; j++) {
			for (int i = 0; i < 256; i++) {
				g.pixels[index++] = color(parent.hue, i, 255 - j);
			}
		}

		updatePixels();
		stroke((parent.brightness > 100) ? 0 : 255);
		fill(0);
		strokeWeight(2);
		strokeCap(PROJECT);
		line(lastX - 10, lastY, lastX - 5, lastY);
		line(lastX + 10, lastY, lastX + 5, lastY);
		line(lastX, lastY - 10, lastX, lastY - 5);
		line(lastX, lastY + 10, lastX, lastY + 5);
		noFill();
		strokeWeight(1);
	}

	public void redraw2() {
		lastX = parent.saturation;
		lastY = 255-parent.brightness;
		redraw();
	}
	
	public void mousePressed() {
		updateMouse();
	}

	public void mouseDragged() {
		updateMouse();
	}

	public void updateMouse() {
		if ((mouseX >= 0) && (mouseX < 256) && (mouseY >= 0) && (mouseY < 256)) {			
			parent.brightness = height - mouseY - 1;
			parent.saturation = mouseX;		
//			System.out.println("SetColVal "+parent.red + "," + parent.green + "," + parent.blue + "," + parent.hue + ","
//					+ parent.saturation + "," + parent.brightness);
			lastX = mouseX;
			lastY = mouseY;
			parent.txtS.setText(String.valueOf(parent.saturation));
			parent.txtV.setText(String.valueOf(parent.brightness));			
		}
	}
}
