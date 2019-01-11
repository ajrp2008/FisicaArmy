class ArmySelector{
  ArmyPathFinder             selectedArmy  = null;
  ArrayList<ArmyPathFinder>  armyList      = new ArrayList<ArmyPathFinder>();

  void addArmy(ArmyPathFinder a){
    armyList.add(a);
  }

  boolean selectArmy(float x, float y){
    ArmyPathFinder targetArmy = null;
    for(ArmyPathFinder a: armyList){
        if(dist(a.army.absolutPosition.x,a.army.absolutPosition.y,x,y)<50){
          if(selectedArmy != null && !a.wayPoints.isEmpty()){
            targetArmy = a; 
            targetArmy.wayPoints.clear();
          }else{
            targetArmy = a;
          }
        }
    }
    selectedArmy = targetArmy;
  
    return selectedArmy != null;
  }

  boolean moveArmy(float x, float y){
    if(selectedArmy!=null){
      selectedArmy.addWayPoint(x,y);
    }
    
    return    selectedArmy != null;

  }

  void update(){
    for(ArmyPathFinder a: armyList){
      a.update();
    }
  }
  
  void drawSelector(){
    for(ArmyPathFinder a: armyList){
      a.drawWayPoints();
      
      ellipse(a.army.absolutPosition.x,a.army.absolutPosition.y,70,70);
    }
    if(selectedArmy!=null && selectedArmy.wayPoints.isEmpty()){
        PVector p =selectedArmy.army.absolutPosition;
        noFill();
        stroke(255,0,0);
        ellipse(p.x,p.y,40,40);
    }
  }

}
