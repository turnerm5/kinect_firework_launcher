class ChargeWacky extends ChargeBasic {
  
  ChargeWacky(PVector location) {
    super(location);
    
    numParticles = 10;
    
    sizeMult = 1.01;
    
    detChargeX = 10;
    detChargeY = 2;
    
    
  } 
  
  void detonate() {
     
    for (int i = 0; i < numParticles; i++) {
      int lifespan = (int) abs((randomGaussian() * 20) + 100);   
      starArray.add(new Star(location, particleColor, lifespan));
    }
    
    Iterator<Star> it = starArray.iterator();
    
    while (it.hasNext()) {
      Star f = it.next();  
      PVector detCharge = new PVector(randomGaussian()*detChargeX,randomGaussian()*detChargeY);  
      float particleSize = random(2,4);
      f.changeSize(particleSize);
      f.detonate(detCharge);
    }
    
    detonated = true;    
  }
  
  
  
}
