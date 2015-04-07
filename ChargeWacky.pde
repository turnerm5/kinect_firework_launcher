class ChargeWacky extends ChargeBasic {
  
  ChargeWacky(PVector location) {
    super(location);
    
    //smaller number of particles
    numParticles = (int) random(50,100);
    
    //stars grow in size over time
    sizeMult = 1.004;
    
    //small detonation
    detChargeX = 8;
    detChargeY = 8;
    detChargeZ = 8;
    
    //longer lifespan
    lifespanBase = 100;

    //smaller stars
    lowerSize = 5;
    upperSize = 8;

    //gravity is reversed!
    forceMultiplier = -1.07;
  }   
}