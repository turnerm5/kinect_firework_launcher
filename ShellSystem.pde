import java.util.Iterator;

class ShellSystem{
 
  float particleSize;
  color particleColor;
  
  boolean isDead;
  boolean hasLines;
  
  int lifespan;
  int timer;
  int numParticles;
  float detCharge;
  float mult;
  int partLifespan;
  int accelDelay;
  float topspeed;
  
  
  ArrayList<StandardParticle> particleArray;
  
  PVector location, accel, target;
  
  ShellSystem(PVector location_) {
    location = location_.get();
    particleArray = new ArrayList<StandardParticle>();
    
    lifespan = 200;
    
    //get our particles ready
    
    initParticles();
  }
  
  void initParticles() {
    detCharge = abs(randomGaussian()) + 2;
    particleColor = color(random(50,255),random(50,255),random(50,255));
    numParticles = int(random(50,120));
    accel = new PVector(0,0.008);
    accelDelay = 0;
    topspeed = 100;
    
    mult = .98;
    for (int i = 0; i < numParticles; i++) {     
      //determine the size of each particle
      particleSize = random(1,4);
      partLifespan = (int) ((randomGaussian() * 30) + 80);
      //fill our array with instances of the superpixels
      particleArray.add(new StandardParticle(location, particleColor, particleSize, detCharge, accel, mult, partLifespan, accelDelay, topspeed));
    }
  }
  
  void run() {
    
    //no need to have our empty shells last forever
    lifespan--;
    
    Iterator<StandardParticle> it = particleArray.iterator();
    
    while (it.hasNext()) {
      StandardParticle f = it.next();    
      f.run();
      if (f.isDead()) {
        it.remove(); 
      }
    }
  }
  
  boolean isDead() {
    if (lifespan < 0 ) {
      return true;
    } else {
      return false;
    }
  }
  
}
