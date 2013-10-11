import java.util.Iterator;

class ShellSystem{
  
  boolean isDead;
  
  ArrayList<StandardParticle> starArray;
 
  PVector location;
 
  int timer;
 
  boolean detonated; 
   
  ShellSystem(PVector location_) {
    location = location_.get();
    starArray = new ArrayList<StandardParticle>();
    initParticles();
    detonated = false;
    timer = 150;
  }
  
  void initParticles() {
    int numParticles = int(random(50,120));
    for (int i = 0; i < numParticles; i++) {     
      starArray.add(new StandardParticle(location));
    }
  }
  
  void detonate() {
     
    Iterator<StandardParticle> it = starArray.iterator();
    
    while (it.hasNext()) {
      StandardParticle f = it.next();
      PVector detCharge = new PVector(randomGaussian()*8,randomGaussian()*8);   
      f.detonate(detCharge);
    }
    
    detonated = true;    
  }
  
  void applyForce(PVector force) {
  for (StandardParticle p: starArray) {
      p.applyForce(force);
    }
  }
  
  void run() {
    
    Iterator<StandardParticle> it = starArray.iterator();
    
    while (it.hasNext()) {
      StandardParticle f = it.next();    
      f.run();
      if (f.isDead()) {
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
