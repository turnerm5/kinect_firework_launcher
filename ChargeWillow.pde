class ChargeWillow extends ChargeBasic {
  
  ChargeWillow(PVector location) {
    super(location);
    
    // lots of stars
    numParticles = (int) random(200,300);
    
    //stars shrink over time
    sizeMult = .98;
    
    //big detonation
    detChargeX = 15;
    detChargeY = 15;
    detChargeZ = 15;

    //a whiteish color
    particleColor = color(random(240,255), random(240,255), random(240,255));
    
    //lives a bit longer
    lifespanBase = 70;

    //larger stars
    lowerSize = 6;
    upperSize = 8;

    //gravity is very strong
    forceMultiplier = 20;
  }   
}