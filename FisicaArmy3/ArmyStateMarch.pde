class ArmyStateMarch implements ArmyState{

  Army    army;
  boolean collisionDetected = false;

  ArmyStateMarch(Army army){
    this.army = army;
  }

  void commandArmyPosition(float x, float y){
    army.absolutPosition.set(x,y);
  }
  
  void commandArmyHeading(float x, float y){
    PVector target    = new PVector(x,y);
    PVector direction = target.sub(army.absolutPosition);
    for(Soldier s: army.soldiers){
      s.getRelPos().rotate(direction.heading()-army.heading);
    }
    army.heading      = direction.heading();
  }
  
  void updateArmySoldiers(){
    army.isMarching = false;
    for(Soldier s: army.soldiers){
      s.updatePosition();
      if(s.isMarching()){      army.isMarching=true;}
      if(s.getFilterBits()==1){collisionDetected=true;}
    }
  }  
  
  void updateState(){
    if(collisionDetected){
      collisionDetected   = false;
      army.armyState      = army.armyWar;
    }
  }
  
  void updateArmyToZoom(){
    army.absolutPosition.mult(GameConstants.zoomFactor);
        for(Soldier s: army.soldiers){
            s.updateSoldierSizeToZoom();
            s.updateSoldierPositionToZoom();
          }
  }
  
  boolean isMarching(){
    return army.isMarching;
  }
  
  void contactStarted(FContact c){
    army.armyWar.contactStarted(c);
  }
  
}
