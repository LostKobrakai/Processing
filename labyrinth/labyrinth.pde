RingBuffer rbuf;

int lin(int x, int y)
{
  return x + y * width;
}

int delinx(int l)
{
  return l % width;
}

int deliny(int l)
{
  return l / width;
}

int[] flood(color[] p, int x, int y, int[] steps)
{
  rbuf.clr();
  Steps firstStep = new Steps(lin(x, y), steps);
  rbuf.push(firstStep);

  while (!rbuf.isempty ())
  {
    Steps l = rbuf.pop();
    x = delinx(l.getCurrent());
    y = deliny(l.getCurrent());

    if (x >= 0 && x < width && y >= 0 && y < height)
    {
      color test = color(255, 255, 255);
      float rc = red(p[lin(x, y)]);
      float gc = green(p[lin(x, y)]);
      float bc = blue(p[lin(x, y)]);

      float rt = red(test);
      float gt = green(test);
      float bt = blue(test);
      if (dist(rc, gc, bc, rt, gt, bt) <= 50)
      {
        int[] stepAdded = append(l.getSteps(), lin(x, y));
        p[lin(x, y)] = color(255, 0, 0);
        Steps nextStep1 = new Steps(lin(x - 1, y), stepAdded);
        rbuf.push(nextStep1);
        Steps nextStep2 = new Steps(lin(x + 1, y), stepAdded);
        rbuf.push(nextStep2);
        Steps nextStep3 = new Steps(lin(x, y - 1), stepAdded);
        rbuf.push(nextStep3);
        Steps nextStep4 = new Steps(lin(x, y + 1), stepAdded);
        rbuf.push(nextStep4);
      }
      if (x == 600 && y == 400) {
        return l.getSteps();
      }
    }
  }
  steps = new int[1];
  return steps;
}

void drawLab() {
  background(255, 255, 255);
  pushStyle();
  noStroke();
  fill(0, 0, 0);
  translate(20, 20);
  for (int w = 40; w < width-50; w+=50) {
    rect(w, 0, 10, 680);
    for (int i = 0; i <= 680/50; i++) {
      pushStyle();
      fill(255, 255, 255);
      if (random(1) >= 0.4) rect(w, 50*i, 10, 40);
      popStyle();
    }
  }
  for (int h = 40; h < height-30; h+=50) {
    rect(0, h, 1200, 10);
    for (int i = 0; i <= 1200/50; i++) {
      pushStyle();
      fill(255, 255, 255);
      if (random(1) >= 0.4) rect(50*i, h, 40, 10);
      popStyle();
    }
  }
  noFill();
  strokeWeight(10);
  noSmooth();
  stroke(0, 0, 0);
  translate(-20, -20);
  rect(15, 15, width-30, height-30);
  popStyle();
}

void setup() {
  size(1280, 720);
  background(255, 255, 255);
  rbuf = new RingBuffer(width*height);
}

void draw() {
  drawLab();
  loadPixels();
  
  int[] start = {lin(30, 30)};
  int[] wayFound = flood(pixels, 30, 30, start);
  println(wayFound);

  if (wayFound.length > 1) {
    updatePixels();
    stroke(255,255,0);
    for(int i = 1; i < wayFound.length; i++){
      line(delinx(wayFound[i-1]), deliny(wayFound[i-1]), delinx(wayFound[i]), deliny(wayFound[i]));
    }
    noLoop();
  }
}

