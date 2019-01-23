class ArmyMoverStateFollowPath implements ArmyMoverState{

  ArmyMover armyMover;
  
  float armySelectorSize   = GameConstants.armySelectorSizeStart;
  
  float wayPointsGap = GameConstants.wayPointGapStart;

  ArrayList<PVector> wayPoints = new ArrayList<PVector>();
  PVector nextPoint;

  
  ArmyMoverStateFollowPath(ArmyMover armyMover){
    this.armyMover = armyMover;
  }

  ArmyMover firstSelectionArmy(float x,float y){
          ArmyMover newSelectedArmy = null;
            
          PVector msp = armyMover.soldierMover.meanSoldierPosition();
    
          if (dist(msp.x, msp.y, x, y)<armySelectorSize/2) {
            newSelectedArmy = armyMover; 
            wayPoints.clear();
            nextPoint = null;
          }
          
          return newSelectedArmy;
  }
  
  void dragFromArmy(float x, float y){
      PVector lastPoint  = wayPoints.isEmpty() ? armyMover.soldierMover.absolutPosition : wayPoints.get(wayPoints.size()-1);
      float distance     = dist(lastPoint.x,lastPoint.y,x,y);
      
      if(distance > wayPointsGap)
       wayPoints.add(new PVector(x,y));

  }
  
  void secondSelection(float x, float y){
  }
  
  
  void update(){
    
    if (!wayPoints.isEmpty() && !armyMover.soldierMover.isMarching() && nextPoint == null) {
      nextPoint = wayPoints.get(0);
      armyMover.soldierMover.commandArmyHeading(nextPoint.x, nextPoint.y);
    } else if (!wayPoints.isEmpty() && !armyMover.soldierMover.isMarching() && nextPoint != null) {
      armyMover.soldierMover.commandArmyPosition(nextPoint.x, nextPoint.y);
      wayPoints.remove(nextPoint);
      nextPoint = null;
    }

  }
  
  void display(boolean selected){
        if (!wayPoints.isEmpty()) {
      if (selected) stroke(armyMover.soldierMover.r, armyMover.soldierMover.g, armyMover.soldierMover.b, 300);
      else stroke(armyMover.soldierMover.r,armyMover.soldierMover.g, armyMover.soldierMover.b, 100);
      noFill();

      beginShape();
      PVector msp = armyMover.soldierMover.meanSoldierPosition();
      vertex(msp.x, msp.y);
      vertex(armyMover.soldierMover.absolutPosition.x, armyMover.soldierMover.absolutPosition.y);
      for (PVector p : wayPoints) {
        if (armyMover.soldierMover.armyState != armyMover.soldierMover.armyWar) {
          // fill(255,255,255);
          //noStroke();
          vertex(p.x, p.y);

          //ellipse(p.x,p.y,4,4);
        }
      }
      endShape();
      ellipse(armyMover.soldierMover.absolutPosition.x, armyMover.soldierMover.absolutPosition.y, 3, 3);
      for (PVector p : wayPoints) {
        if (armyMover.soldierMover.armyState != armyMover.soldierMover.armyWar) {
          ellipse(p.x, p.y, 3, 3);
        }
      }
    }
  }

  void updateWithZoomFactor() {
    armySelectorSize*= GameConstants.zoomFactor;
    wayPointsGap *= GameConstants.zoomFactor;
    armyMover.soldierMover.updateArmyToZoom();
    for (PVector wp : wayPoints) {
      wp.mult(GameConstants.zoomFactor);
    }
  }

void updateMapPosition(float dx, float dy) {
    for (PVector wp : wayPoints) {
      wp.add(dx, dy);
    }
    armyMover.soldierMover.updateMapPosition(dx, dy);
  }

}
