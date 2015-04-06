class ChargeWacky extends ChargeBasic {
  
  ChargeWacky(PVector location) {
    super(location);
    
    //smaller number of particles
    numParticles = (int) random(50,100);
    
    //stars grow in size over time
    sizeMult = 1.008;
    
    //small detonation
    detChargeX = 5;
    detChargeY = 5;
    detChargeZ = 5;
    
    //longer lifespan
    lifespanBase = 100;

    //smaller stars
    lowerSize = 1;
    upperSize = 3;

    //gravity is reversed!
    forceMultiplier = -1.05;
  }   
}