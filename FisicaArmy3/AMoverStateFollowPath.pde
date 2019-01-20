class ArmyMoverStateFollowPath implements ArmyMoverState{

  ArmyMover armyMover;
  
  ArmyMoverStateFollowPath(ArmyMover armyMover){
    this.armyMover = armyMover;
  }

  void firstSelectionArmy(){
  }
  
  void dragFromArmy(float x, float y){
      PVector lastPoint  = armyMover.wayPoints.isEmpty() ? armyMover.soldierMover.absolutPosition : armyMover.wayPoints.get(armyMover.wayPoints.size()-1);
      float distance     = dist(lastPoint.x,lastPoint.y,x,y);
      
      if(distance > armyMover.wayPointsGap)
       armyMover.wayPoints.add(new PVector(x,y));

  }
  
  void secondSelection(float x, float y){
  }
  
  
  void update(){
  }
  
  void display(boolean selected){
        if (!armyMover.wayPoints.isEmpty()) {
      if (selected) stroke(armyMover.soldierMover.r, armyMover.soldierMover.g, armyMover.soldierMover.b, 300);
      else stroke(armyMover.soldierMover.r,armyMover.soldierMover.g, armyMover.soldierMover.b, 100);
      noFill();

      beginShape();
      PVector msp = armyMover.soldierMover.meanSoldierPosition();
      vertex(msp.x, msp.y);
      vertex(armyMover.soldierMover.absolutPosition.x, armyMover.soldierMover.absolutPosition.y);
      for (PVector p : armyMover.wayPoints) {
        if (armyMover.soldierMover.armyState != armyMover.soldierMover.armyWar) {
          // fill(255,255,255);
          //noStroke();
          vertex(p.x, p.y);

          //ellipse(p.x,p.y,4,4);
        }
      }
      endShape();
      ellipse(armyMover.soldierMover.absolutPosition.x, armyMover.soldierMover.absolutPosition.y, 3, 3);
      for (PVector p : armyMover.wayPoints) {
        if (armyMover.soldierMover.armyState != armyMover.soldierMover.armyWar) {
          // fill(255,255,255);
          //noFill();
          //vertex(p.x,p.y);
          // stroke(255);
          ellipse(p.x, p.y, 3, 3);
        }
      }
    }
  }



}
