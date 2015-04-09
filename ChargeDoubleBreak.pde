class ChargeDoubleBreak extends ChargeBasic {
  
    int breakTimer;
    boolean timerTriggered;

    ChargeDoubleBreak(PVector location, int breakTimer_) {
        super(location);
        
        //smaller number of particles
        numParticles = (int) random(40,60);
        
        //stars grow in size over time
        sizeMult = 1.001;
        
        //small detonation
        detChargeX = 10;
        detChargeY = 10;
        detChargeZ = 10;

        breakTimer = breakTimer_;

        timerTriggered = false;
        
        //short lifespan
        lifespanBase = 25;

        //red stars
        particleColor = color(random(200,255), random(0,150), random(0,150));

        //larger stars
        lowerSize = 5;
        upperSize = 8;

        //gravity is normal
        forceMultiplier = 1.05;
    }

    void run(){
        super.run();
        if (timerTriggered){
            breakTimer--;
        }   
    }

    boolean explodeTest(){
        if (breakTimer < 0) {
            return true;
        } else {
            return false;
        }
    }

  void trigger(){
    timerTriggered = true;
  }   
}