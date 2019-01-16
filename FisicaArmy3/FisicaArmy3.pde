import fisica.*;

//small test change
FWorld  world;
ArmySelector     armySelector    = new ArmySelector();  

String debugText = "DEBUG";

void setup(){
  size(1440,2960);
  smooth();
  Fisica.init(this);
  world = new FWorld();
  world.setGravity(0,0);
  ellipseMode(CENTER);
  armySelector.addArmy(new ArmyPathFinder(new Army(100,100,"A",0,255,0)));
  armySelector.addArmy(new ArmyPathFinder(new Army(200,150,"B",255,255,255)));
  armySelector.addArmy(new ArmyPathFinder(new Army(100,200,"C",200,0,0)));
}

void draw(){
  background(50);
 
  //ZOOM-IN BUTTON 
  rect(1200,40,200,190);

  //ZOOM-OUT BUTTON 
  rect(1200,240,200,190);

 
  //DEBUG TEXT 
  textSize(40); 
  fill(200,0,0);
  text(debugText,70,70);
  
  
  
  world.step();
  armySelector.drawSelector();
  armySelector.update();
  world.draw();
  

}

void mousePressed(){
  boolean result = armySelector.selectArmy(mouseX,mouseY);
  
  debugText = "MOUSE PRESSED";
  
  if(mouseX >1200 && mouseX < 1400 && mouseY > 40 && mouseY < 240){
    debugText = "ZOOM-IN BUTTON PRESSED";
    zoomMap(1.1);
  }
  if(mouseX >1200 && mouseX < 1400 && mouseY > 240 && mouseY < 440){
    debugText = "ZOOM-OUT BUTTON PRESSED";
    zoomMap(0.9);
  }
}

void mouseDragged(){
  boolean result = armySelector.moveArmy(mouseX,mouseY);
  
  debugText = "MOUSE DRAGGED:" + (mouseX - pmouseX);
  
  if(!result){
    moveMap(mouseX-pmouseX,mouseY-pmouseY);
  }
  
}

void zoomMap(float zoom){
  GameConstants.zoomFactor = zoom;
  armySelector.updateWithZoomFactor();
}


void moveMap(float dx, float dy){
  armySelector.updateMapPosition(dx,dy);
}


void contactStarted(FContact c) {
    if(!c.getBody1().getName().equals(c.getBody2().getName())){
      c.getBody1().setFilterBits(1);
      c.getBody2().setFilterBits(1);
      Soldier s1 = (Soldier)c.getBody1();
      Soldier s2 = (Soldier)c.getBody2();
      s1.army.contactStarted(c);
      s2.army.contactStarted(c);
    }
}
