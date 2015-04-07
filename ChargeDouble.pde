class ChargeDouble extends ChargeBasic {
  
  ArrayList<ChargeBasic> chargeArray;
  boolean alreadyExploded;
  int secondaryTimer = 40;
  boolean timerTriggered;

  ChargeDouble(PVector location, boolean exploded_) {
    super(location);

    chargeArray = new ArrayList<ChargeBasic>();

    alreadyExploded = exploded_;
    timerTriggered = false;

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
    timerTriggered = true;
  }


  void run() {
    super.run();

    Iterator<ChargeBasic> chIt = chargeArray.iterator();
    while (chIt.hasNext()) {
      ChargeBasic c = chIt.next();
      c.run();
    }

    if (timerTriggered) {
      secondaryTimer--;
    }

    if (secondaryTimer == 0 && !alreadyExploded) {
      //run through the stars we just created, apply a random force to explode
      Iterator<Star> stIt = starArray.iterator();
      while (stIt.hasNext()) {
        Star s = stIt.next();
        chargeArray.add(new ChargeDoubleBreak(s.location));  
      }

      Iterator<ChargeBasic> it = chargeArray.iterator();
      while (it.hasNext()) {
        ChargeBasic c = it.next();
        c.detonate();
      }

      alreadyExploded = true;  
    }
  }
}