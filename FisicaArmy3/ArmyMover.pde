class ArmyMover{
  
  String              name;
  
  ArmyMoveState           armyState;
  ArmyMoveState           armyMarch            = new ArmyMoveStateMarch(this);
  ArmyMoveState           armyWar              = new ArmyMoveStateWar(this);              
  
  ArrayList<Soldier>  soldiers             = new ArrayList<Soldier>();
  PVector             absolutPosition      = new PVector();  
  boolean             isMarching           = false;
  float               heading              = 0;
  int                 armySize             = 25;
  float               r,g,b;  
      
  ArmyMover(float x, float y, String name,float r,float g,float b){
    armyState = armyMarch;
    absolutPosition.set(x,y);
    this.r = r; this.g = g; this.b = b;
    this.name = name;
    createSoldiers(this);
    initSquareFormation(this);
  }
  
  PVector meanSoldierPosition(){
    PVector meanPos  = new PVector();
    float   armySize = 0;
    for(Soldier s: soldiers){
      meanPos.add(s.getX(),s.getY());
      if(s.isAlive)armySize++;
    }
    meanPos.div(armySize);
    
    return meanPos;
  }
  
  void updateArmyToZoom(){
    armyState.updateArmyToZoom();
  }
  
  void updateMapPosition(float dx, float dy){
    absolutPosition.add(dx, dy);
      ((ArmyMoveStateWar)(armyWar)).positionContact.add(dx, dy);
      for (Soldier s :soldiers) {
        s.setPosition(s.getX()+dx, s.getY()+dy);
      }
  }
  
  void commandArmyPosition(float x, float y){
    armyState.commandArmyPosition(x,y);
  }
  
  void commandArmyHeading(float x, float y){
    armyState.commandArmyHeading(x,y);
  }
  
  void updateArmy(){
    armyState.updateArmySoldiers();
    armyState.updateState();
  }  
  
  boolean isMarching(){
    return armyState.isMarching();
  }
  
  void contactStarted(FContact c) {
    armyState.contactStarted(c);
  }
  
}
