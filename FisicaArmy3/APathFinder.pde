class ArmyPathFinder{
  
  float wayPointsGap = GameConstants.wayPointGapStart;
  
  ArrayList<PVector> wayPoints = new ArrayList<PVector>();
  PVector nextPoint;
  ArmyMover army;

  ArmyPathFinder(ArmyMover army){
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
  
    void updateWithZoomFactor(){
      wayPointsGap *= GameConstants.zoomFactor;
      army.updateArmyToZoom();
      for(PVector wp : wayPoints){
        wp.mult(GameConstants.zoomFactor);
      }
    }
    
    void updateMapPosition(float dx, float dy){
    for (PVector wp : wayPoints) {
        wp.add(dx, dy);
      }
      army.updateMapPosition(dx,dy);
    }
  
  void addWayPoint(float x, float y){
      PVector lastPoint  = wayPoints.isEmpty() ? army.absolutPosition : wayPoints.get(wayPoints.size()-1);
      float distance     = dist(lastPoint.x,lastPoint.y,x,y);
      
      if(distance > wayPointsGap)
       wayPoints.add(new PVector(x,y));
  }
  
  void drawWayPoints(boolean selected){
if(!wayPoints.isEmpty()){
   if(selected) stroke(army.r,army.g,army.b,300);else stroke(army.r,army.g,army.b,100);
          noFill();

beginShape();
  PVector msp = army.meanSoldierPosition();
  vertex(msp.x,msp.y);
  vertex(army.absolutPosition.x,army.absolutPosition.y);
    for(PVector p: wayPoints){
      if(army.armyState != army.armyWar){
       // fill(255,255,255);
        //noStroke();
        vertex(p.x,p.y);

        //ellipse(p.x,p.y,4,4);
      }
    }
   endShape();
   ellipse(army.absolutPosition.x,army.absolutPosition.y,3,3);
 for(PVector p: wayPoints){
      if(army.armyState != army.armyWar){
      // fill(255,255,255);
        //noFill();
        //vertex(p.x,p.y);
       // stroke(255);
        ellipse(p.x,p.y,3,3);
      }
}
    
  }
  } 

}
