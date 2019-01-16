import fisica.*;

FWorld  world;
ArmySelector     armySelector    = new ArmySelector();  
String debugText = "DEBUG";

Button zoomInButton,zoomOutButton; 

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
  
  zoomInButton = new Button(width-(300+50), (50), 300, 100);
  zoomInButton.setText("Zoom In");
 // zoomInButton.setLocalColorScheme(G4P.RED_SCHEME);
 // zoomInButton.setFont(new Font("Monospaced", Font.PLAIN, 22));
 // zoomInButton.addEventHandler(this, "zoomInButton_click");
  
  zoomOutButton = new Button(width-(300+50), (50+100+50), 300, 100);
  zoomOutButton.setText("Zoom Out");
//  zoomOutButton.setLocalColorScheme(G4P.RED_SCHEME);
 // zoomOutButton.setFont(new Font("Monospaced", Font.PLAIN, 22));
 // zoomOutButton.addEventHandler(this, "zoomOutButton_click");
}

void draw(){
  background(50);
  //DEBUG TEXT 
  textSize(40); 
  fill(200,0,0);
  text(debugText,70,70);
  
  zoomInButton.display();
  zoomOutButton.display();
  
  world.step();
  armySelector.drawSelector();
  armySelector.update();
  world.draw();
}

void mousePressed(){
  boolean result = armySelector.selectArmy(mouseX,mouseY);
  debugText = "MOUSE PRESSED";
  if(zoomInButton.isPushed(mouseX,mouseY)) zoomInButton_click();
  if(zoomOutButton.isPushed(mouseX,mouseY)) zoomOutButton_click();
}

public void zoomInButton_click() {
  zoomMap(1.1);
  debugText = "ZOOM-IN BUTTON PRESSED";
}

public void zoomOutButton_click() {
  zoomMap(0.9);
  debugText = "ZOOM-OUT BUTTON PRESSED";
}

void mouseDragged(){
  boolean result = armySelector.moveArmy(mouseX,mouseY);
  debugText = "MOUSE DRAGGED:" + (mouseX - pmouseX);
  if(!result){
    moveMap(mouseX-pmouseX,mouseY-pmouseY);
  }
}

void mouseReleased(){
  zoomInButton.release();
  zoomOutButton.release();
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
