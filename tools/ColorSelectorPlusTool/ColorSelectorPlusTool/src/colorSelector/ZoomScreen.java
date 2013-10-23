package colorSelector;

import java.applet.*;
import java.awt.*;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.awt.image.BufferedImage;

import javax.swing.*;

// The Magnifier Applet
@SuppressWarnings("serial")
class ZoomScreen extends Applet implements Runnable, KeyListener {

	public int imgWidth = 300;
	public int imgHeight = 300;
	private ZoomPanel zoomPanel;
	private JPanel parentPanel;
	ColorSelectorPlus parent;
	public void init() {
		mouseC = mouseP = MouseInfo.getPointerInfo().getLocation();
		parentPanel = new JPanel();
		zoomPanel = new ZoomPanel();
		setLayout(new BorderLayout());
		parentPanel.setLayout(new BorderLayout());
		parentPanel.add(zoomPanel, BorderLayout.CENTER);
		add(parentPanel);
		try {
			robot = new Robot(MouseInfo.getPointerInfo().getDevice());
		} catch (AWTException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Thread th = new Thread(this);
		th.start();
		addKeyListener(this);
	}

	public int zoomLevel = 25; // 15 to 95, with steps of 10
	private GraphicsEnvironment ge = GraphicsEnvironment
			.getLocalGraphicsEnvironment();
	private GraphicsDevice[] gs = ge.getScreenDevices();
	private Rectangle bounds;
	private BufferedImage desktop = new BufferedImage(zoomLevel, zoomLevel,
			BufferedImage.TYPE_INT_RGB);
	private BufferedImage resizedImage;
	private Robot robot;

	private BufferedImage getScreen() {

		// zoomLevel = 12;

		bounds = new Rectangle(mouseC.x - zoomLevel / 2, mouseC.y - zoomLevel
				/ 2, zoomLevel, zoomLevel);
		desktop = new BufferedImage(zoomLevel, zoomLevel,
				BufferedImage.TYPE_INT_RGB);

		desktop = robot.createScreenCapture(bounds);
		resizedImage = new BufferedImage(imgWidth, imgHeight,
				BufferedImage.TYPE_INT_RGB);
		Graphics2D g = resizedImage.createGraphics();
		g.drawImage(desktop, 0, 0, imgWidth, imgHeight, null);
		g.dispose();
		return resizedImage;
	}

	private int zm;
	private Point mouseC, mouseP;

	// Create a separate thread and continuously listen for
	// mouse movement and repaint applet
	public void run() {
		while (true) {
			if (parent.tabColorPicker.isVisible()) {
				mouseC = MouseInfo.getPointerInfo().getLocation();
				if (parent.tabColorPicker.isVisible())
					if (!mouseC.equals(mouseP)) {
						zoomPanel.repaint();
						mouseP = mouseC;
					}
			}

			// Very important to add Thread.sleep() or else eats up resources
			try {
				Thread.sleep(30);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	public Color pointColor = new Color(0);
	public BufferedImage screen;

	// The panel that draws the zoomed image
	// Image wasn't directly drawn onto the applet due to weird refresh
	// rates
	// Refreshing was inconsistent and showed lag
	private class ZoomPanel extends JPanel {

		@Override
		public void paintComponent(Graphics g) {
			// g.drawImage(image, 0, 0, null);
			zm = imgHeight / zoomLevel;
			screen = getScreen();
			g.drawImage(screen, 0, 0, this);
			g.setColor(Color.black);
			g.drawRect(imgWidth / 2 - zm / 2, imgHeight / 2 - zm / 2, zm, zm);
			pointColor = new Color(screen.getRGB(imgWidth / 2 + 1,
					imgHeight / 2));
			if (parent.tabColorPicker.isVisible()
					&& parent.isBlankPanelSelected
					&& parent.panelShowPalette.minimized == false) {
				parent.selectedColor.setBackground(pointColor);
				parent.setColorValue(pointColor);
			}

		}
	}

	@Override
	// Spacebar to grab a color
	public void keyPressed(KeyEvent e) {

		if (e.getKeyCode() == KeyEvent.VK_SPACE) {
			parent.setColorValue(pointColor);
			parent.btnAddToPalette.doClick();
		}
	}

	@Override
	public void keyReleased(KeyEvent e) {

	}

	@Override
	public void keyTyped(KeyEvent e) {

	}

}