class ArmyPathFinder{

  ArrayList<PVector> wayPoints = new ArrayList<PVector>();
  PVector nextPoint;
  Army army;

  ArmyPathFinder(Army army){
    this.army = army;
  }

  void update(){
    army.updateArmy();
        
    if(!wayPoints.isEmpty() && !army.isMarching() && nextPoint == null){
      nextPoint = wayPoints.get(0);
      army.commandArmyHeading(nextPoint.x,nextPoint.y);
    }else if(!wayPoints.isEmpty() && !army.isMarching() && nextPoint != null){
       army.commandArmyPosition(nextPoint.x,nextPoint.y);
       wayPoints.remove(nextPoint);
       nextPoint = null;
    }  
  }
  
  void addWayPoint(float x, float y){
      PVector lastPoint  = wayPoints.isEmpty() ? army.absolutPosition : wayPoints.get(wayPoints.size()-1);
      float distance     = dist(lastPoint.x,lastPoint.y,x,y);
      if(distance > 20)
        wayPoints.add(new PVector(x,y));
  }
  
  void drawWayPoints(){
    for(PVector p: wayPoints){
      if(army.armyState != army.armyWar)
        ellipse(p.x,p.y,2,2);
    }
  }
  

}
