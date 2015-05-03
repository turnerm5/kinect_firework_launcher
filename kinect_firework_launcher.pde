//
//
//The current date is: Mon 03/10/2014 
//
//

import java.util.Iterator;

ArrayList<Firework> fireworks;

PVector gravity;

void setup() {
  size(700, 800);
  
  background(0);
  
  fireworks = new ArrayList<Firework>();
  
  gravity = new PVector(0,.03);
}

void mousePressed() {
  int timer = (int) random(80,120);
  fireworks.add(new Firework(new PVector(mouseX,mouseY), timer));
}

void draw() {
  fill(0, 15);
  rect(0, 0, width, height);
  manageFireworks();
}

void manageFireworks() {
  Iterator<Firework> it = fireworks.iterator();
  while (it.hasNext()) {
    Firework f = it.next();    
    f.run();
    
    if (!f.launched) {
      float launchStrength = -1 * abs((randomGaussian()*1)+7);
      f.launch(new PVector(random(-1,1),launchStrength));
    }
    
    f.applyForce(gravity);
    if (f.isDead()) {
      it.remove();
    }
  } 
}
