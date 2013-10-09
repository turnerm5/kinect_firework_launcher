import java.util.Iterator;

class ShellSystem{
   
  boolean isDead;
  
  ArrayList<StandardParticle> starArray;
 
  PVector location; 
   
  ShellSystem(PVector location_) {
    location = location_.get();
    starArray = new ArrayList<StandardParticle>();
    initParticles();
  }
  
  void initParticles() {
    color particleColor = color(random(50,255),random(50,255),random(50,255));
    int numParticles = int(random(50,120));
    for (int i = 0; i < numParticles; i++) {     

      float particleSize = random(1,4);
      int partLifespan = (int) ((randomGaussian() * 30) + 80);
      starArray.add(new StandardParticle(location, particleColor, particleSize, partLifespan));
    }
  }
  
  void run() {
      
    Iterator<StandardParticle> it = starArray.iterator();
    
    while (it.hasNext()) {
      StandardParticle f = it.next();    
      f.run();
      if (f.isDead()) {
        it.remove(); 
      }
    }
  }
  
  boolean isDead() {
    //this might be an issue. check if there aren't any stars created
    int sas = starArray.size();
    if (sas == 0) {
      return true;
    }  else {
      return false;
    }
  }
}
