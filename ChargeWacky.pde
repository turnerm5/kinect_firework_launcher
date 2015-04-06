class ChargeWacky extends ChargeBasic {
  
  ChargeWacky(PVector location) {
    super(location);
    
    numParticles = (int) random(50,100);
    
    sizeMult = 1.005;
    
    detChargeX = 5;
    detChargeY = 5;
    detChargeZ = 5;
    
    lifespanBase = 100;

  } 
  
  void detonate() {
     
    for (int i = 0; i < numParticles; i++) {
      int lifespan = (int) abs((randomGaussian() * 10) + lifespanBase);   
      starArray.add(new Star(location, particleColor, lifespan));
    }
    
    Iterator<Star> it = starArray.iterator();
    
    while (it.hasNext()) {
      Star f = it.next();  
      PVector detCharge = new PVector(randomGaussian()*detChargeX,randomGaussian()*detChargeY, randomGaussian()*detChargeZ);  
      float particleSize = random(4,8);
      f.changeSize(particleSize);
      f.applyForce(detCharge);
    }
    
    detonated = true;    
  }

  //Neutralize any force we pass to it.
  void applyForce(PVector force) {
    
    PVector f = force.get();
    f.mult(0);

    for (Star s: starArray) {
        s.applyForce(f);
      }
  }
   
  
}