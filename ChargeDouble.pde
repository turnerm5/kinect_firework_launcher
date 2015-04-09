class ChargeDouble extends ChargeBasic {
  
  ArrayList<ChargeDoubleBreak> chargeArray;

  ChargeDouble(PVector location) {
    super(location);

    chargeArray = new ArrayList<ChargeDoubleBreak>();


    sizeMult = 0.98;

    //smaller number of particles
    numParticles = (int) random(5,8);

    //smaller stars
    lowerSize = 2;
    upperSize = 5;

    //a medium size explosion
    detChargeX = 15;
    detChargeY = 15;
    detChargeZ = 15;

    //gravity is normal
    forceMultiplier = 1;

    lifespanBase = 80;
  }

  void detonate() {
    super.detonate();
    
    for(Star s : starArray) {
      int breakTimer = (int)random(80,100);
      println("breakTimer: " + breakTimer);
      chargeArray.add(new ChargeDoubleBreak(s.location, breakTimer));  
    }

    for (ChargeDoubleBreak c : chargeArray){
      c.trigger();
    }
  }

  void run() {
    super.run();
    
    for (ChargeDoubleBreak c : chargeArray){
      c.run();
      if (c.explodeTest()) {
        c.detonate();
      }
    }   
  }
}