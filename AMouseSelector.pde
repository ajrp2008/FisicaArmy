class ArmySelector{
  ArmyPathFinder             selectedArmy  = null;
  ArrayList<ArmyPathFinder>  armyList      = new ArrayList<ArmyPathFinder>();

  void addArmy(ArmyPathFinder a){
    armyList.add(a);
  }

  void selectArmy(float x, float y){
    ArmyPathFinder targetArmy = null;
    for(ArmyPathFinder a: armyList){
        if(dist(a.army.absolutPosition.x,a.army.absolutPosition.y,x,y)<25){
          if(selectedArmy != null && !a.wayPoints.isEmpty()){
            targetArmy = a; 
            targetArmy.wayPoints.clear();
          }else{
            targetArmy = a;
          }
        }
    }
    selectedArmy = targetArmy;
  }

  void moveArmy(float x, float y){
    if(selectedArmy!=null){
      selectedArmy.addWayPoint(x,y);
    }
  }

  void update(){
    for(ArmyPathFinder a: armyList){
      a.update();
    }
  }
  
  void drawSelector(){
    for(ArmyPathFinder a: armyList){
      a.drawWayPoints();
    }
    if(selectedArmy!=null && selectedArmy.wayPoints.isEmpty()){
        PVector p =selectedArmy.army.absolutPosition;
        noFill();
        stroke(255,0,0);
        ellipse(p.x,p.y,40,40);
    }
  }

}
