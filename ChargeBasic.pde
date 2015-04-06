import java.util.Iterator;

//This is our basic charge class
//It controls an arraylist of stars, the actual class that is rendered
//New attributes should be coded so only variables need to be changed.

class ChargeBasic{
  
  boolean isDead;
  ArrayList<Star> starArray;
  PVector location;
  int timer;
  int numParticles;
  boolean detonated;
  color particleColor;
  float sizeMult; 
  float detChargeX, detChargeY, detChargeZ;
  int lowerSize, upperSize;
  float forceMultiplier;
  float friction;

  int lifespanBase;
  
  ChargeBasic(PVector location_) {
    location = location_.get();
    
    //create our arraylist of the stars
    starArray = new ArrayList<Star>();
    
    //how many stars does this charge have
    numParticles = int(random(150,300));
    
    //a rainbow!
    particleColor = color(random(120,255), random(120,255), random(120,255));
    
    //has not detonated
    detonated = false;
    
    //the basic charge has a default timer
    timer = 150;
    
    //the particles grow as they stay in the sky
    sizeMult = 1.01;
    
    //a medium size explosion
    detChargeX = 8;
    detChargeY = 8;
    detChargeZ = 8;

    //moderately sized stars
    lowerSize = 3;
    upperSize = 5;  

    //moderate lifespan
    lifespanBase = 20;

    //no force multiplier
    forceMultiplier = 1;

    //medium friction
    friction = 0.95;
  }




  ///////////////////////
  // Utility functions //
  ///////////////////////
  
  void changeLocation(PVector loc) {
    location = loc.get();
  }
  
  void applyForce(PVector force) {
    PVector f = force.get();
    f.mult(forceMultiplier);
    for (Star s: starArray) {
        s.applyForce(f);
      }
  }

  boolean isDead() {
    if (timer < -200) {
      return true;
    }  else {
      return false;
    }
  }





  ////////////////////
  // Core functions //
  ////////////////////
  
  void run() {
    Iterator<Star> it = starArray.iterator();
    while (it.hasNext()) {
      Star s = it.next();    
      s.run();
      //Keep increasing the size of the particle
      s.multSize(sizeMult);
      if (s.isDead()) {
        it.remove();
      }
    }
    
    //Count down.
    timer--;
  }

  void detonate() {

    //create our new stars, each with a random lifespan     
    for (int i = 0; i < numParticles; i++) {
      int lifespan = (int) abs((randomGaussian() * 5) + lifespanBase);   
      float particleSize = random(lowerSize, upperSize);
      starArray.add(new Star(location, particleColor, lifespan, particleSize));
    }
    
    //run through the stars we just created, apply a random force to explode
    Iterator<Star> it = starArray.iterator();
    while (it.hasNext()) {
      Star s = it.next();
      s.changeFriction(friction);  
      PVector detCharge = new PVector(randomGaussian()*detChargeX,randomGaussian()*detChargeY,randomGaussian()*detChargeZ);  
      
      //apply the force, using the star's detonate function
      s.detonate(detCharge);
    }
    
    //tell the firework that we've exploded
    detonated = true;    
  }
  
}