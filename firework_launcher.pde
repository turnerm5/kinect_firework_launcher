//Copyright 2015 Marshall Turner
//turnerm5@gmail.com

import java.util.Iterator;
import peasy.*;

PeasyCam cam;

ArrayList<Firework> fireworks;

PVector gravity;

void setup() {
  size(700, 800, P3D);
  
  background(0);
  
  fireworks = new ArrayList<Firework>();

  //Always important to have some gravity
  gravity = new PVector(0,.03,0);

  //Camera settings
  cam = new PeasyCam(this, 0, -500 ,0,1200);
  cam.setMinimumDistance(500);
  cam.setMaximumDistance(5000);
  cam.setResetOnDoubleClick(true);
  // cam.setYawRotationMode();
}

void keyPressed() {
  //how long should our firework wait to explode?
  int timer = (int) random(80,100);
  fireworks.add(new Firework(new PVector(randomGaussian()*20,2,randomGaussian()*20), timer));
}

void draw() {
  fill(0);
  background(0);
  ambientLight(150,150,150);
  directionalLight(255,255,255, 0, -1, 0);
  pushMatrix();
  translate(0, 10, 0);
  fill(20, 20, 20);
  box(500,10,500);
  popMatrix();
  
  //our master function
  manageFireworks();
}

void manageFireworks() {
  
  //Iterate through our fireworks.
  Iterator<Firework> it = fireworks.iterator();
  while (it.hasNext()) {
    Firework f = it.next();    
    
    //Our master run function for the firework.
    f.run();
    
    //Ask the firework: "Have you launched yet? If not, do this!"
    if (!f.launched) {
      float launchStrength = abs(randomGaussian()) + 9;
      f.launch(new PVector(random(-1,1),-launchStrength,random(-1,1)));
    }
    
    //Apply gravity to the firework, and let it apply it to the other classes.
    f.applyForce(gravity);

    //If the firework thinks it is dead, remove it from the iterator.
    if (f.isDead()) {
      it.remove();
    }
  } 
}
