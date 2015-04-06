import java.util.Iterator;

//This is our basic charge class
//It controls an arraylist of stars, the actual class that is rendered

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

  
  //each charge has a different lifespan for its stars
  int lifespanBase = 20;
  
  ChargeBasic(PVector location_) {
    location = location_.get();
    
    //create our arraylist of the stars
    starArray = new ArrayList<Star>();
    
    //how many stars does this charge have
    numParticles = int(random(150,300));
    
    //a rainbow!
    particleColor = color(random(50,255), random(50,255), random(50,255));
    detonated = false;
    
    //the basic charge has a default timer
    timer = 150;
    
    //the particles grow as they stay in the sky
    sizeMult = 1.01;
    
    //how big of an explosion in every direction
    detChargeX = 5;
    detChargeY = 5;
    detChargeZ = 5;  
  }
  


  void detonate() {
    
    //create our new stars, each with a random lifespan     
    for (int i = 0; i < numParticles; i++) {
      int lifespan = (int) abs((randomGaussian() * 5) + lifespanBase);   
      starArray.add(new Star(location, particleColor, lifespan));
    }
    
    //run through the stars we just created, apply a random force to explode
    Iterator<Star> it = starArray.iterator();
    while (it.hasNext()) {
      Star s = it.next();  
      PVector detCharge = new PVector(randomGaussian()*detChargeX,randomGaussian()*detChargeY,randomGaussian()*detChargeZ);  
      
      //the particles need a size, so we can see them
      float particleSize = random(3,5);
      s.changeSize(particleSize);
      
      //apply the force, using the star's detonate function
      s.detonate(detCharge);
    }
    
    //tell the firework that we've exploded
    detonated = true;    
  }
  

  //Apply any force we pass to it.
  void applyForce(PVector force) {
  for (Star s: starArray) {
      s.applyForce(force);
    }
  }


  //Our standard run function
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
  
  boolean isDead() {
    if (timer < -200) {
      return true;
    }  else {
      return false;
    }
  }
}