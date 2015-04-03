//
//
//The current date is: Mon 03/10/2014 
//
//

import java.util.Iterator;
import ddf.minim.*;
import peasy.*;

PeasyCam cam;

ArrayList<Firework> fireworks;

PVector gravity;

void setup() {
  size(700, 800, P3D);
  
  background(0);
  
  fireworks = new ArrayList<Firework>();
  
  gravity = new PVector(0,.03);

  cam = new PeasyCam(this, 0, 0 ,0,1000);
  cam.setMinimumDistance(500);
  cam.setMaximumDistance(5000);
  cam.setResetOnDoubleClick(false);
}

void mousePressed() {
  int timer = (int) random(80,120);
  fireworks.add(new Firework(new PVector(0,0,0), timer));
}

void draw() {
  fill(0);
  background(0);
  pushMatrix();
  translate(0, 0, 0);
  fill(50, 50, 50);
  box(200,1,200);
  popMatrix();
  manageFireworks();
}

void manageFireworks() {
  Iterator<Firework> it = fireworks.iterator();
  while (it.hasNext()) {
    Firework f = it.next();    
    f.run();
    
    if (!f.launched) {
      float launchStrength = abs(randomGaussian()) + 5;
      f.launch(new PVector(random(-1,1),-launchStrength,random(-1,1)));
    }
    
    f.applyForce(gravity);
    if (f.isDead()) {
      it.remove();
    }
  } 
}
