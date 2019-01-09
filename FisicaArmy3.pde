import fisica.*;

FWorld  world;
ArmySelector     armySelector    = new ArmySelector();  

void setup(){
  size(400,400);
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
  background(255);
  world.step();
  armySelector.drawSelector();
  armySelector.update();
  world.draw();
}

void mousePressed(){
  armySelector.selectArmy(mouseX,mouseY);
}

void mouseDragged(){
  armySelector.moveArmy(mouseX,mouseY);
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
