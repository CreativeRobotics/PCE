//Perceptual Crossing Experiment

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
  
  
  
  envWidth = 600; //environment width
  envStart = (width/2) - (envWidth/2); //The distance from the screen edge that tne environment starts
  envYPos = 300; //environment Y Position onscreen
  
  userA = new userObject(30, userAPos, -20, 150, 8, envWidth, envStart); //create user A, lure and lure offset
  userA.setHue(userAHue);//set the colour for this user
  userA.setBrightness(userBrightness, lureBrightness, staticBrightness);//set the brightness settings for this users display elements
  userA.setStaticPos(150, 100);//set the position of the static object
  userB = new userObject(40, userBPos, 20, 150, 20, envWidth, envStart); //create user B, lure and lure offset
  userB.setHue(userBHue);//set the colour for this user
  userB.setBrightness(userBrightness, lureBrightness, staticBrightness);//set the brightness settings for this users display elements
  userB.setStaticPos(590, 20); //set the position of the static object
  
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
    //Neither user is wrapping//println("No Wrap");
    if(user1.getUserEnd() < user2.getUserStart() || user1.getUserStart() > user2.getUserEnd()) return false;
    if(user2.getUserEnd() < user1.getUserStart() || user2.getUserStart() > user1.getUserEnd()) return false;
  }
  if(user1.getUserEnd() < user1.getUserStart() && user2.getUserEnd() > user2.getUserStart()){
    //User1 is wrapping//println("User1 Wrap");
    if(user2.getUserStart() > user1.getUserEnd() && user2.getUserEnd() < user1.getUserStart()) return false;
  }
  if(user2.getUserEnd() < user2.getUserStart() && user1.getUserEnd() > user1.getUserStart()){
    //User2 is wrapping//println("User2 Wrap");
    if(user1.getUserStart() > user2.getUserEnd() && user1.getUserEnd() < user2.getUserStart()) return false;
  }
  //if(user1.getUserEnd() < user1.getUserStart() && user2.getUserEnd() < user2.getUserStart()) return true; //Both are wrapping - then they are both overlapping as well
  return true;
}

boolean checkLureCrossing(userObject user1, userObject user2){
  //Returns true if user1 overlaps user 2's lure
  if(user1.getUserEnd() > user1.getUserStart() && user2.getLureEnd() > user2.getLureStart()){
    //Neither the user or the lure are wrapping around
    if(user1.getUserEnd() < user2.getLureStart() || user1.getUserStart() > user2.getLureEnd()) return false;
  }
  if(user1.getUserEnd() < user1.getUserStart() && user2.getLureEnd() > user2.getLureStart()){
    //User wraps but not lure
    if(user1.getUserEnd() < user2.getLureStart() && user1.getUserStart() > user2.getLureEnd()) return false;
  }
  if(user1.getUserEnd() > user1.getUserStart() && user2.getLureEnd() < user2.getLureStart()){
    //Lure wraps but not user
    if(user1.getUserEnd() < user2.getLureStart() && user1.getUserStart() > user2.getLureEnd()) return false;
  }
  //if(user1.getUserEnd() < user1.getUserStart() && user2.getLureEnd() < user2.getLureStart()) return true;
  return true;
}


void checkCollisions(){
  userATouchingStatic = userA.checkSelfOverlap(); //works
  userBTouchingStatic = userB.checkSelfOverlap(); //works
  //check to see if the users are touching each other or each others lure
  //Do this first for when they are not wrapping around
  
  bothUsersTouching = checkUserCrossing(userA, userB); //works
  userATouchingLure = checkLureCrossing(userA, userB); //see if A crosses B's lure
  userBTouchingLure = checkLureCrossing(userB, userA); //see if B crosses A's lure
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
  
  if(flag1)fill(color(userHue, 150, staticBrightness)); //Static contact
  else fill(color(userHue, 10, 250));
  rect(start, yStart, indicatorWidth, yEnd);
  
  if(flag2) fill(color(userHue, 150, lureBrightness));//Lure contact
  else      fill(color(userHue, 10, 250));
  rect(start+indicatorWidth, yStart, indicatorWidth, yEnd);
 
  if(flag3) fill(color(userHue, 150, userBrightness));//User contact
  else fill(color(userHue, 10, 250));
  rect(start+indicatorWidth+indicatorWidth, yStart, indicatorWidth, yEnd);
}

void drawEnviron(){
    rectMode(CORNER);
    
    stroke(0);
    fill(255);  // Set fill to userCol
    rect(envStart, 300-(envHeight/2), envWidth, envHeight );
}