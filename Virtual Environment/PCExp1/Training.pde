void updateFreePractice(){
  boolean printTimeTest = false;
  boolean printPracticeDebugMessages = false;
  //for general testing
  //get the user pos, then add the change in position from the device if it has been updated
  if(!waitingForA && serialAConnected) {
    timeTest = System.nanoTime();
    getStateSetMessage(1, "Manual1:" +practiceIterations);
    if(printPracticeDebugMessages) println("Sent command to A");
  }
  if(!waitingForB && serialBConnected) {
    getStateSetMessage(2, "Manual2:" + practiceIterations);
    if(printPracticeDebugMessages) println("Sent command to B");
  }

  if(newDataFromA) {
    if(printTimeTest){
      print("Elapsed:");
      println(System.nanoTime() - timeTest);
    }
    userAPos += userA.XChange;
    newDataFromA = false;
    timeoutsA = 0;
  }
  else timeoutsA++;
  if(newDataFromB){
    userBPos += userB.XChange;
    newDataFromB = false;
    timeoutsB = 0;
  }
  else timeoutsB++;
  if(timeoutsA > 100) {
    timeoutsA = 0;
    waitingForA = false;
  }
  if(timeoutsB > 100) {
    timeoutsB = 0;
    waitingForB = false;
  }
  if(MOUSE_TEST_MODE == true){
    if (mousePressed == true) {
       if (mouseButton == LEFT) userAPos = mouseX;
       if (mouseButton == RIGHT) userBPos = mouseX;
    }
  }
  updateEnvironment();
  drawGraphics();
  stroke(0);
  fill(0);
  //then set any haptics
  if(userAContact) userA.hapticStrength1 = 1023;
  else userA.hapticStrength1 = 0;

  if(userBContact) userB.hapticStrength1 = 1023;
  else userB.hapticStrength1 = 0;
  setHaptics(1);
  setHaptics(2);
  practiceIterations++;
}

void updatePractice1(){
  boolean printTimeTest = false;
  boolean printPracticeDebugMessages = false;

  //for general testing
  //get the user pos, then add the change in position from the device if it has been updated
  if(!waitingForA && serialAConnected) {
    timeTest = System.nanoTime();
    getStateSetMessage(1, "Practice 1 " +practiceIterations);
    if(printPracticeDebugMessages) println("Sent command to A");
  }
  if(!waitingForB && serialBConnected) {
    getStateSetMessage(2, "Practice 1 " + practiceIterations);
    if(printPracticeDebugMessages) println("Sent command to B");
  }

  if(newDataFromA) {
    if(printTimeTest){
      print("Elapsed:");
      println(System.nanoTime() - timeTest);
    }
    userAPos += userA.XChange;
    newDataFromA = false;
    timeoutsA = 0;
  }
  else timeoutsA++;
  if(newDataFromB){
    userBPos += userB.XChange;
    newDataFromB = false;
    timeoutsB = 0;
  }
  else timeoutsB++;
  if(timeoutsA > 100) {
    timeoutsA = 0;
    waitingForA = false;
  }
  if(timeoutsB > 100) {
    timeoutsB = 0;
    waitingForB = false;
  }
  if(MOUSE_TEST_MODE == true){
    if (mousePressed == true) {
       if (mouseButton == LEFT) userAPos = mouseX;
       if (mouseButton == RIGHT) userBPos = mouseX;
    }
  }
  updateEnvironment();
  drawGraphics();
  stroke(0);
  fill(0);
  //then set any haptics
  if(userATouchingStatic) userA.hapticStrength1 = 1023;
  else userA.hapticStrength1 = 0;

  if(userBTouchingStatic) userB.hapticStrength1 = 1023;
  else userB.hapticStrength1 = 0;
  setHaptics(1);
  setHaptics(2);
  practiceIterations++;
}

void updatePractice2(){
  boolean printTimeTest = false;
  boolean printPracticeDebugMessages = false;

  //for general testing
  //get the user pos, then add the change in position from the device if it has been updated
  if(!waitingForA && serialAConnected) {
    timeTest = System.nanoTime();
    getStateSetMessage(1, "Practice 2 " +practiceIterations);
    if(printPracticeDebugMessages) println("Sent command to A");
  }
  if(!waitingForB && serialBConnected) {
    getStateSetMessage(2, "Practice 2 " + practiceIterations);
    if(printPracticeDebugMessages) println("Sent command to B");
  }

  if(newDataFromA) {
    if(printTimeTest){
      print("Elapsed:");
      println(System.nanoTime() - timeTest);
    }
    userAPos += userA.XChange;
    newDataFromA = false;
    timeoutsA = 0;
  }
  else timeoutsA++;
  if(newDataFromB){
    userBPos += userB.XChange;
    newDataFromB = false;
    timeoutsB = 0;
  }
  else timeoutsB++;
  if(timeoutsA > 100) {
    timeoutsA = 0;
    waitingForA = false;
  }
  if(timeoutsB > 100) {
    timeoutsB = 0;
    waitingForB = false;
  }
  if(MOUSE_TEST_MODE == true){
    if (mousePressed == true) {
       if (mouseButton == LEFT) userAPos = mouseX;
       if (mouseButton == RIGHT) userBPos = mouseX;
    }
  }
  updateEnvironment();
  drawGraphics();
  stroke(0);
  fill(0);
  //then set any haptics
  if(userATouchingStatic) userA.hapticStrength1 = 1023;
  else userA.hapticStrength1 = 0;

  if(userBTouchingStatic) userB.hapticStrength1 = 1023;
  else userB.hapticStrength1 = 0;
  setHaptics(1);
  setHaptics(2);
  
  //Move the static objects
  movingObjectPosA += slowSpeed;
  if(movingObjectPosA >= envWidth) movingObjectPosA = 0;
  movingObjectPosB += slowSpeed;
  if(movingObjectPosB >= envWidth) movingObjectPosB = 0;
  userA.setStaticPos(movingObjectPosA, 4);
  userB.setStaticPos(movingObjectPosB, 4);

  practiceIterations++;
}


void updatePractice3(){
  boolean printTimeTest = false;
  boolean printPracticeDebugMessages = false;

  //for general testing
  //get the user pos, then add the change in position from the device if it has been updated
  if(!waitingForA && serialAConnected) {
    timeTest = System.nanoTime();
    getStateSetMessage(1, "Practice 3 " +practiceIterations);
    if(printPracticeDebugMessages) println("Sent command to A");
  }
  if(!waitingForB && serialBConnected) {
    getStateSetMessage(2, "Practice 3 " + practiceIterations);
    if(printPracticeDebugMessages) println("Sent command to B");
  }

  if(newDataFromA) {
    if(printTimeTest){
      print("Elapsed:");
      println(System.nanoTime() - timeTest);
    }
    userAPos += userA.XChange;
    newDataFromA = false;
    timeoutsA = 0;
  }
  else timeoutsA++;
  if(newDataFromB){
    userBPos += userB.XChange;
    newDataFromB = false;
    timeoutsB = 0;
  }
  else timeoutsB++;
  if(timeoutsA > 100) {
    timeoutsA = 0;
    waitingForA = false;
  }
  if(timeoutsB > 100) {
    timeoutsB = 0;
    waitingForB = false;
  }
  if(MOUSE_TEST_MODE == true){
    if (mousePressed == true) {
       if (mouseButton == LEFT) userAPos = mouseX;
       if (mouseButton == RIGHT) userBPos = mouseX;
    }
  }
  updateEnvironment();
  drawGraphics();
  stroke(0);
  fill(0);
  //then set any haptics
  if(userATouchingStatic) userA.hapticStrength1 = 1023;
  else userA.hapticStrength1 = 0;

  if(userBTouchingStatic) userB.hapticStrength1 = 1023;
  else userB.hapticStrength1 = 0;
  setHaptics(1);
  setHaptics(2);
  
  //Move the static objects
  movingObjectPosA += fastSpeed;
  if(movingObjectPosA >= envWidth) movingObjectPosA = 0;
  movingObjectPosB += fastSpeed;
  if(movingObjectPosB >= envWidth) movingObjectPosB = 0;
  userA.setStaticPos(movingObjectPosA, 4);
  userB.setStaticPos(movingObjectPosB, 4);

  practiceIterations++;
}

void randomise(){
    //Setup random user positions:
  userAPos = int(random(0, envWidth));
  userBPos = int(random(0, envWidth));
  userA.move(userAPos);
  userB.move(userBPos);
  //randomise the static object positions
  movingObjectPosA = int(random(0, envWidth));
  movingObjectPosB = int(random(0, envWidth));
  userA.setStaticPos(movingObjectPosA, 4);
  userB.setStaticPos(movingObjectPosB, 4);
}