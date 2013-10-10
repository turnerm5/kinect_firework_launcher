import java.util.Iterator;
import ddf.minim.*;

ArrayList<TrailSystem> fireworks;
ArrayList<ShellSystem> charges;

PVector gravity;

void setup() {
  size(700, 800, P2D);
  
  background(0);
  
  fireworks = new ArrayList<TrailSystem>();
  charges = new ArrayList<ShellSystem>();
  
  gravity = new PVector(0,.05);
  
}

void mousePressed() {
  int timer = (int) random(80,120);
  fireworks.add(new TrailSystem(new PVector(mouseX,mouseY), timer));
}

void draw() {
  background(0,20);
  manageFireworks();
}

void manageFireworks() {
  Iterator<TrailSystem> it = fireworks.iterator();
  while (it.hasNext()) {
    TrailSystem f = it.next();    
    f.run();
    f.applyForce(gravity);
    if (f.isDead()) {
      it.remove(); 
    }
  } 
}
