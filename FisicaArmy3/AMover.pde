class ArmyMover{
  
  float wayPointsGap = GameConstants.wayPointGapStart;
  
  ArrayList<PVector> wayPoints = new ArrayList<PVector>();
  PVector nextPoint;
  SoldiersMover soldierMover;

  ArmyMover(SoldiersMover army){
    this.soldierMover = army;
  }

  void update(){
    soldierMover.updateArmy();
        
    if(!wayPoints.isEmpty() && !soldierMover.isMarching() && nextPoint == null){
      nextPoint = wayPoints.get(0);
      soldierMover.commandArmyHeading(nextPoint.x,nextPoint.y);
    }else if(!wayPoints.isEmpty() && !soldierMover.isMarching() && nextPoint != null){
       soldierMover.commandArmyPosition(nextPoint.x,nextPoint.y);
       wayPoints.remove(nextPoint);
       nextPoint = null;
    }  
  }
  
    void updateWithZoomFactor(){
      wayPointsGap *= GameConstants.zoomFactor;
      soldierMover.updateArmyToZoom();
      for(PVector wp : wayPoints){
        wp.mult(GameConstants.zoomFactor);
      }
    }
    
    void updateMapPosition(float dx, float dy){
    for (PVector wp : wayPoints) {
        wp.add(dx, dy);
      }
      soldierMover.updateMapPosition(dx,dy);
    }
  
  void addWayPoint(float x, float y){
      PVector lastPoint  = wayPoints.isEmpty() ? soldierMover.absolutPosition : wayPoints.get(wayPoints.size()-1);
      float distance     = dist(lastPoint.x,lastPoint.y,x,y);
      
      if(distance > wayPointsGap)
       wayPoints.add(new PVector(x,y));
  }
  
  void drawWayPoints(boolean selected){
if(!wayPoints.isEmpty()){
   if(selected) stroke(soldierMover.r,soldierMover.g,soldierMover.b,300);else stroke(soldierMover.r,soldierMover.g,soldierMover.b,100);
          noFill();

beginShape();
  PVector msp = soldierMover.meanSoldierPosition();
  vertex(msp.x,msp.y);
  vertex(soldierMover.absolutPosition.x,soldierMover.absolutPosition.y);
    for(PVector p: wayPoints){
      if(soldierMover.armyState != soldierMover.armyWar){
       // fill(255,255,255);
        //noStroke();
        vertex(p.x,p.y);

        //ellipse(p.x,p.y,4,4);
      }
    }
   endShape();
   ellipse(soldierMover.absolutPosition.x,soldierMover.absolutPosition.y,3,3);
 for(PVector p: wayPoints){
      if(soldierMover.armyState != soldierMover.armyWar){
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
