/**
 * Objects
 * by hbarragan. 
 * 
 * Move the cursor across the image to change the speed and positions
 * of the geometry. The class MRect defines a group of lines.
 */

import controlP5.*;
import processing.serial.*;
userObject userA;


userObject userB;

void setup()
{
  size(1200, 640);//, P2D);
  colorMode(HSB);
  myFont = createFont("Courier New", 14);
  startBX = width-(10+listBoxWidth);

  textFont(myFont);
  cp5 = new ControlP5(this);
  portList = Serial.list();
  initialiseControls();
  
  envWidth = 600;
  envStart = (width/2) - (envWidth/2); //how far from the screen edge
  envYPos = 300;
  userA = new userObject(30, userAPos, -20, 150, 8, envWidth, envStart);
  userA.setHue(userAHue);
  userA.setStaticPos(250, 30);
  userB = new userObject(40, userBPos, 20, 150, 20, envWidth, envStart);
  userB.setHue(userBHue);
  userB.setStaticPos(350, 30);
  
  
  frameRate(30);
}
 
 

void draw()
{
  background(200);
  if (mousePressed == true) {
     if (mouseButton == LEFT) userAPos = mouseX;
     
     if (mouseButton == RIGHT) userBPos = mouseX;
  }
  //userBPos ++;//= random(-2, 2);
  if(userAPos < 0) userAPos = envWidth+userAPos;
  if(userBPos < 0) userBPos = envWidth+userBPos;
  userA.move(userAPos);
  userB.move(userBPos);

  checkCollisions();
  
  drawEnviron();  
  userA.display(envYPos-1);
  userB.display(envYPos+1);
  drawCollisions();
  stroke(0);
  fill(0);
}

boolean checkUserCrossing(userObject user1, userObject user2){
  if(user1.getUserEnd() > user1.getUserStart() && user2.getUserEnd() > user2.getUserStart()){
    //Neither user is wrapping
    println("No Wrap");
    if(user1.getUserEnd() < user2.getUserStart() || user1.getUserStart() > user2.getUserEnd()) return false;
    if(user2.getUserEnd() < user1.getUserStart() || user2.getUserStart() > user1.getUserEnd()) return false;
  }
  if(user1.getUserEnd() < user1.getUserStart() && user2.getUserEnd() > user2.getUserStart()){
    //User1 is wrapping
    println("User1 Wrap");
    if(user2.getUserStart() > user1.getUserEnd() && user2.getUserEnd() < user1.getUserStart()) return false;
  }
  if(user2.getUserEnd() < user2.getUserStart() && user1.getUserEnd() > user1.getUserStart()){
    //User2 is wrapping
    
    println("User2 Wrap");
    if(user1.getUserStart() > user2.getUserEnd() && user1.getUserEnd() < user2.getUserStart()) return false;
  }
  if(user1.getUserEnd() < user1.getUserStart() && user2.getUserEnd() < user2.getUserStart()){
    //Both are wrapping - then they are both overlapping as well
    
    println("Both");
    return true;
  }
  return true;
}
void checkCollisions(){
  userATouchingStatic = userA.checkSelfOverlap();
  userBTouchingStatic = userB.checkSelfOverlap();
  //check to see if the users are touching each other or each others lure
  //Do this first for when they are not wrapping around
  bothUsersTouching = checkUserCrossing(userA, userB);
  //userATouchingLure = false;
  //userBTouchingLure = false;
  //bothUsersTouching = false;
  /*
  DON'T check for overlapping agents, just check that they are NOT overlapping
  */
}

void drawCollisions(){
  drawCollissionIndicator(userATouchingStatic, userATouchingLure, bothUsersTouching, userAHue, -10);
  drawCollissionIndicator(userBTouchingStatic, userBTouchingLure, bothUsersTouching, userBHue, 10);
}

void drawCollissionIndicator(boolean flag1, boolean flag2, boolean flag3, int userHue, int yOffset){
  //YOffset tells you what side to draw - top (-) or bottom (+)
  int centre = envStart+(envWidth/2);
  int start = envStart;
  int end = envStart+envWidth;
  int yStart = yOffset;
  int yEnd = yOffset;
  int indicatorWidth = 100;
  if(yOffset < 0){
    yStart = envYPos-(envHeight/2);
    yEnd = -10;
  }   else{
    yStart = envYPos+(envHeight/2);
    yEnd = 10;
  }
  
  if(flag1)fill(color(userHue, 150, 200));
  else fill(color(userHue, 10, 250));
  rect(start, yStart, indicatorWidth, yEnd);
  
  if(flag2) fill(color(userHue, 150, 200));
  else      fill(color(userHue, 10, 250));
  rect(start+indicatorWidth, yStart, indicatorWidth, yEnd);
 
  if(flag3) fill(color(userHue, 150, 200));
  else fill(color(userHue, 10, 250));
  rect(start+indicatorWidth+indicatorWidth, yStart, indicatorWidth, yEnd);
}

void drawEnviron(){
    rectMode(CORNER);
    
    stroke(0);
    fill(255);  // Set fill to userCol
    rect(envStart, 300-(envHeight/2), envWidth, envHeight );
}