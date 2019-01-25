class Soldier extends FCircle {

  PVector  relPosition    =  new PVector();
  SoldiersMover     army;

  boolean  isAlive        = true;

  float    speed          = GameConstants.soldierSpeedStart;

  Soldier(SoldiersMover army, PVector relPos) {
    super(GameConstants.soldierSizeStart);
    this.army         = army;
    this.relPosition  = relPos;
    setPosition(army.absolutPosition.x + relPos.x, army.absolutPosition.y + relPos.y);
    setGrabbable(false);
    setDamping(0.25);
    setName(army.name);
    world.add(this);
  }

  void updateSoldierSizeToZoom() {
    speed *= GameConstants.zoomFactor;
    setSize(getSize()*GameConstants.zoomFactor);
  }

  void updateSoldierWhenInFormationPositionToZoom() {
    relPosition.mult(GameConstants.zoomFactor);
    setPosition(army.absolutPosition.x + relPosition.x, army.absolutPosition.y + relPosition.y);
  }


  void updatePosition() {
    if (isMarching()) {
      PVector p  = new PVector(-getX()+(army.absolutPosition.x + relPosition.x), -getY()+(army.absolutPosition.y + relPosition.y));
      p.normalize();
      p.mult(speed);
      setVelocity(p.x, p.y);
    } else {
      setVelocity(0, 0);
    }
  }

  PVector getRelPos() {
    return relPosition;
  }

  boolean isMarching() {
    float e = dist(getX(), getY(), army.absolutPosition.x+relPosition.x, army.absolutPosition.y+relPosition.y);
    if (e > 3) {
      println(frameCount+"I MARCH"+this.getVelocityX());
      return true;
    } else { 
      return false;
    }
  }

  void attack(Soldier opponent) {
    int x = (int)random(1, 100);
    //println("hit x:"+x);
    if (x<2) {
      //println("There is at hit :"+ x + "SOLDIER DEAD !!!");
      opponent.isAlive = false;
      world.remove(opponent);
     // opponent.army.soldiers.remove(opponent);
    }
  }
}
