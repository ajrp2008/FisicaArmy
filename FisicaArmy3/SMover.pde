class SoldiersMover{
  
  ArmyMover           armyMover;
  
  String              name;
  
  SoldiersMoveState           armyState;
  SoldiersMoveState           armyMarch            = new SoldiersMoverStateMarch(this);
  SoldiersMoveState           armyWar              = new SoldiersMoverStateWar(this);              
  
  ArrayList<Soldier>  soldiers             = new ArrayList<Soldier>();
  PVector             absolutPosition      = new PVector();  
  boolean             isMarching           = false;
  float               heading              = 0;
  int                 armySize             = 25;
  float               r,g,b;  
      
  SoldiersMover(float x, float y, String name,float r,float g,float b){
    armyState = armyMarch;
    absolutPosition.set(x,y);
    this.r = r; this.g = g; this.b = b;
    this.name = name;
    createSoldiers(this);
    initSquareFormation(this);
  }
  
  PVector meanSoldierPosition(){
    PVector meanPos  = new PVector();
    int   sizeAlive = 0;
    for(Soldier s: soldiers){
      if(s.isAlive){
        meanPos.add(s.getX(),s.getY());
        sizeAlive++;
      }
    }
    armySize = sizeAlive;
    meanPos.div(sizeAlive);
    
    return meanPos;
  }
  
  float armySizeAlive(){
    return armySize;
  }
  
  void updateArmyToZoom(){
    armyState.updateArmyToZoom();
  }
  
  void updateMapPosition(float dx, float dy){
    absolutPosition.add(dx, dy);
      ((SoldiersMoverStateWar)(armyWar)).positionContact.add(dx, dy);
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
  
  void retreatTo(float x, float y){
    armyState.retreatTo(x,y);
  }
  
}
