class Army{
  
  String              name;
  
  ArmyState           armyState;
  ArmyState           armyMarch            = new ArmyStateMarch(this);
  ArmyState           armyWar              = new ArmyStateWar(this);              
  
  ArrayList<Soldier>  soldiers             = new ArrayList<Soldier>();
  PVector             absolutPosition      = new PVector();  
  boolean             isMarching           = false;
  float               heading              = 0;
  int                 armySize             = 25;
  float               r,g,b;  
      
  Army(float x, float y, String name,float r,float g,float b){
    armyState = armyMarch;
    absolutPosition.set(x,y);
    this.r = r; this.g = g; this.b = b;
    this.name = name;
    createSoldiers(this);
    initSquareFormation(this);
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
