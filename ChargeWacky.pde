class ChargeWacky extends ChargeBasic {
  
  ChargeWacky(PVector location) {
    super(location);
    
    numParticles = 10;
    
    sizeMult = 1.02;
    
    detChargeX = 5;
    detChargeY = 4;
    detChargeZ = 7;
    
  } 
  
  void detonate() {
     
    for (int i = 0; i < numParticles; i++) {
      int lifespan = (int) abs((randomGaussian() * 20) + 100);   
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