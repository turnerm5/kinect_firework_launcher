import java.util.Iterator;
import ddf.minim.*;

PGraphics buffer;
PImage backImg;

ArrayList<TrailSystem> fireworks;
ArrayList<ShellSystem> charges;

int len;

void setup() {

  //general setup. we will use an image buffer to draw things off screen. maybe this helps?
  size(700, 800, P2D );
  frameRate(60);
  background(0);
  backImg = loadImage("background.jpg");

  
  fireworks = new ArrayList<TrailSystem>();
  charges = new ArrayList<ShellSystem>();
}

void mousePressed() {
  fill(255,255,200);
  fireworks.add(new TrailSystem(new PVector(mouseX,mouseY)));
}

void draw() {
  
  //buffer.beginDraw();
  //buffer.background(0,15);
  background(0,20);
  
  Iterator<TrailSystem> it = fireworks.iterator();

  while (it.hasNext()) {
    
    TrailSystem f = it.next();    
    
    f.run();
    
    if (f.isDead()) {
      it.remove(); 
    }
  }
  
  //buffer.endDraw();
  
  //The main drawing functions
  //Display the background
  //image(backImg, 0, 0);
  
  //Draw the fireworks onto the screen
  //image(buffer, 0, 0);
  //filter(DILATE);
}
