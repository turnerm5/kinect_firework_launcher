class Wacky extends ShellSystem {
  
  Wacky(PVector location) {
    super(location);
  }  
  
  //load our shell with new particles
  
  void run() {
    
    //no need to have our empty shells last forever
    lifespan--;
    
    Iterator<StandardParticle> it = particleArray.iterator();
    
    while (it.hasNext()) {
      StandardParticle f = it.next();    
      f.run();
      f.seek(location);
      if (f.isDead()) {
        it.remove(); 
      }
    }
  }
  
}
