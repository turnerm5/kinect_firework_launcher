class ChargeWacky extends ChargeBasic {
  
  ChargeWacky(PVector location) {
    super(location);
    
    numParticles = (int) random(50,100);
    
    sizeMult = 1.06;
    
    detChargeX = 10;
    detChargeY = 10;
    detChargeZ = 10;
    
    lifespanBase = 20;

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
      f.detonate(detCharge);
    }
    
    detonated = true;    
  }
   
  
}