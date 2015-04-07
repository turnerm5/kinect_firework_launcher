class ChargeDoubleBreak extends ChargeBasic {
  
  ChargeDoubleBreak(PVector location) {
    super(location);
    
    //smaller number of particles
    numParticles = (int) random(40,60);
    
    //stars grow in size over time
    sizeMult = 1.001;
    
    //small detonation
    detChargeX = 8;
    detChargeY = 8;
    detChargeZ = 8;
    
    //short lifespan
    lifespanBase = 25;

    //red stars
    particleColor = color(random(200,255), random(0,50), random(0,50));

    //larger stars
    lowerSize = 5;
    upperSize = 8;

    //gravity is normal
    forceMultiplier = 1.05;
  }   
}