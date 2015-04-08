class ChargeCool extends ChargeBasic {
  
  ChargeCool(PVector location) {
    super(location);
    
    //smaller number of particles
    numParticles = (int) random(50,100);
    
    //stars grow in size over time
    sizeMult = 1.2;
    
    //small detonation
    detChargeX = 14;
    detChargeY = 14;
    detChargeZ = 14;
    
    //longer lifespan
    lifespanBase = 20;

    //smaller stars
    lowerSize = 1;
    upperSize = 2;

    //gravity is reversed!
    forceMultiplier = 3;
  }   
}