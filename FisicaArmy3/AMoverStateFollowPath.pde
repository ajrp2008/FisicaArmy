class ArmyMoverStateFollowPath implements ArmyMoverState{

  boolean approveRoute = false;
  
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
    
    
           //FIRST SELECTION: SELECT THIS ARMY
          if (dist(msp.x, msp.y, x, y)<armySelectorSize/2) {
            newSelectedArmy = armyMover; 
            
           // wayPoints.clear();
           // nextPoint = null;
            //approveRoute = false;
          }
                           
                           //FIRST SELECTION: SELECT LAST WAYPOINT
          if(!wayPoints.isEmpty()){
            PVector wp =  wayPoints.get(wayPoints.size()-1);
           float distFromLastWayPoint = dist(wp.x,wp.y,x,y);
      
           if(distFromLastWayPoint < armySelectorSize/2){
          
          
          newSelectedArmy = armyMover;
        }}
          
          
          
          return newSelectedArmy;
  }
  
  void dragFromArmy(float x, float y){
    
    
    //DRAG : ONLY WHEN NOT ARMY SELECTED AND NOT ROUTE APPROVED
    PVector msp = armyMover.soldierMover.meanSoldierPosition();  
    if(approveRoute || dist(msp.x, msp.y, x, y)<armySelectorSize/2)return;
     
      //DRAG : NEW WAYPOINT WHEN DISTANCE MORE THAN GAP!
      PVector lastPoint  = wayPoints.isEmpty() ? armyMover.soldierMover.absolutPosition : wayPoints.get(wayPoints.size()-1);
      float distance     = dist(lastPoint.x,lastPoint.y,x,y);      
      if(distance > wayPointsGap)
       wayPoints.add(new PVector(x,y));

  }
  
  void secondSelection(float x, float y){
    
    //SECOND SELECTION: ONLY WHEN WAYPOINTS EXISTS
   if(wayPoints.isEmpty())return;
   
   
   //SECOND SELECTION: Select last wayPoint - approve !!
   PVector wp =  wayPoints.get(wayPoints.size()-1);
   float distFromLastWayPoint = dist(wp.x,wp.y,x,y);
      
   if(distFromLastWayPoint < armySelectorSize/2){
     approveRoute = true;
   }
   
   //SECOND SELECTION:  Select army again and route exists -> delete route!
   PVector msp = armyMover.soldierMover.meanSoldierPosition();
    
   if (dist(msp.x, msp.y, x, y)<armySelectorSize/2 && !wayPoints.isEmpty()) {
                 wayPoints.clear();
            nextPoint = null;
            approveRoute = false;
   }
   
   
  }
  
  
  void update(){
    
      armyMover.soldierMover.updateArmy();

  if(approveRoute){
    if (!wayPoints.isEmpty() && !armyMover.soldierMover.isMarching() && nextPoint == null) {
      nextPoint = wayPoints.get(0);
      armyMover.soldierMover.commandArmyHeading(nextPoint.x, nextPoint.y);
    } else if (!wayPoints.isEmpty() && !armyMover.soldierMover.isMarching() && nextPoint != null) {
      armyMover.soldierMover.commandArmyPosition(nextPoint.x, nextPoint.y);
      wayPoints.remove(nextPoint);
      nextPoint = null;
    } else if(wayPoints.isEmpty()){
      approveRoute = false;
    }
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
          
          if(wayPoints.indexOf(p) >=( wayPoints.size()-1)){
          ellipse(p.x, p.y,armySelectorSize , armySelectorSize);
          }
          
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
