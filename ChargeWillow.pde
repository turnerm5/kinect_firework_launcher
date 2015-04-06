class ChargeWillow extends ChargeBasic {
  
  ChargeWillow(PVector location) {
    super(location);
    
    numParticles = (int) random(200,300);
    
    sizeMult = .98;
    
    detChargeX = 15;
    detChargeY = 5;
    detChargeZ = 15;
    
    lifespanBase = 70;

  } 
  
  //Multiply any force we pass to it.
  void applyForce(PVector force) {
    
    PVector f = force.get();
    f.mult(6);

    for (Star s: starArray) {
        s.applyForce(f);
      }
  }
  
}