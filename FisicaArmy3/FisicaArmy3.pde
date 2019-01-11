import fisica.*;

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
  armySelector.addArmy(new ArmyPathFinder(new Army(200,150,"B",0,0,0)));
  armySelector.addArmy(new ArmyPathFinder(new Army(100,200,"C",200,0,0)));
}

void draw(){
  background(100);
  
  textSize(30); 
  text(debugText,30,30);
  
  
  world.step();
  armySelector.drawSelector();
  armySelector.update();
  world.draw();
  

}

void mousePressed(){
  boolean result = armySelector.selectArmy(mouseX,mouseY);
  
  debugText = "MOUSE PRESSED";

}

void mouseDragged(){
  boolean result = armySelector.moveArmy(mouseX,mouseY);
  
  debugText = "MOUSE DRAGGED:" + (mouseX - pmouseX);
  
  if(!result){
    moveMap(mouseX-pmouseX,mouseY-pmouseY);
  }
  
}

void moveMap(float dx, float dy){
  
  for(ArmyPathFinder ap:armySelector.armyList){
    
    for(PVector wp:ap.wayPoints){
      wp.add(dx,dy);
    }
    
    ap.army.absolutPosition.add(dx,dy);
    
    for(Soldier s:ap.army.soldiers){
      s.setPosition(s.getX()+dx,s.getY()+dy);
      //s.relPosition.set(s.relPosition.x +dx, s.relPosition.y + dy);
    }
    
  }
  
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
