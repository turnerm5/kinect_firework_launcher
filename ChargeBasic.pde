import java.util.Iterator;

class ChargeBasic{
  
  boolean isDead;
  ArrayList<Star> starArray;
  PVector location;
  int timer;
  int numParticles;
  boolean detonated;
  color particleColor;
  float sizeMult; 
  float detChargeX, detChargeY;
  
  ChargeBasic(PVector location_) {
    location = location_.get();
    starArray = new ArrayList<Star>();
    
    numParticles = int(random(150,300));
    particleColor = color(random(50,255), random(50,255), random(50,255));
    detonated = false;
    timer = 150;
    
    sizeMult = 1;
    
    detChargeX = 5;
    detChargeY = 5; 
  }
  
  void detonate() {
     
    for (int i = 0; i < numParticles; i++) {
      int lifespan = (int) abs((randomGaussian() * 20) + 50);   
      starArray.add(new Star(location, particleColor, lifespan));
    }
    
    Iterator<Star> it = starArray.iterator();
    
    while (it.hasNext()) {
      Star f = it.next();  
      PVector detCharge = new PVector(randomGaussian()*detChargeX,randomGaussian()*detChargeY);  
      float particleSize = random(.5,1.5);
      f.changeSize(particleSize);
      f.detonate(detCharge);
    }
    
    detonated = true;    
  }
  
  void applyForce(PVector force) {
  for (Star p: starArray) {
      p.applyForce(force);
    }
  }
  
  void run() {
    
    Iterator<Star> it = starArray.iterator();
    
    while (it.hasNext()) {
      Star s = it.next();    
      s.run();
      s.multSize(sizeMult);
      if (s.isDead()) {
        it.remove();
      }
    }
    
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
