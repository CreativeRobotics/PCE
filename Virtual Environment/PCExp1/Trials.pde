

void runTrial(){
  //Do everything here
  boolean printTrialDebug = false;
  incrimentalTime = 0;
  numberOfIterations = trialLengthSeconds * trialResolution;
  millisecondsBetweenSteps = 1000/trialResolution;
  timeoutsA = 0;
  timeoutsB = 0;
  trialStep = 0;
  
  //Setup random user positions:
  userAPos = int(random(0, envWidth));
  userBPos = int(random(0, envWidth));
  userA.move(userAPos);
  userB.move(userBPos);
  //reset the static object positions
  
  userA.setStaticPos(150, 4);
  userB.setStaticPos(450, 4);
  
  for(int step = 0; step < numberOfIterations; step++){
    
    if(logBenchmarks) loopStartMark = System.currentTimeMillis();
    
    lastStepStart = System.currentTimeMillis();

    //println(endOfStep-lastStepStart);
    
    if(keyPressed){
      haltTrial();
      return;
    }
    if(logBenchmarks) loopMark1 = System.currentTimeMillis();
    if(trialStep % messageFrequency == 0){
      String message = String.valueOf((numberOfIterations-trialStep)/100);
      println(message);
      sentATime = System.currentTimeMillis();
      getStateSetMessage(1, message);
      
      sentBTime = System.currentTimeMillis();
      getStateSetMessage(2, message);
    }
    else{
      sentATime = System.currentTimeMillis();
      getState(1);
      sentBTime = System.currentTimeMillis();
      getState(2);
    }
    //wait for reply
    waitForReply(9);
    if(logBenchmarks) loopMark2 = System.currentTimeMillis();
    
    if(newDataFromA) {
      responseTimeA = System.currentTimeMillis()-sentATime;
      userAPos += userA.XChange;
      newDataFromA = false;
    }
    if(newDataFromB){
      responseTimeB = System.currentTimeMillis()-sentBTime;
      userBPos += userB.XChange;
      newDataFromB = false;
    }
    
    //Then update the trial
    if(logBenchmarks) loopMark3 = System.currentTimeMillis();
    updateEnvironment();
    //then set any haptics
    if(userAContact) userA.hapticStrength1 = 1023;
    else userA.hapticStrength1 = 0;

    if(userBContact) userB.hapticStrength1 = 1023;
    else userB.hapticStrength1 = 0;
    
    if(logBenchmarks) loopMark4 = System.currentTimeMillis();
    setHaptics(1);
    setHaptics(2);
    
    if(animateTrials) drawGraphics();
    
    while( System.currentTimeMillis() < lastStepStart+millisecondsBetweenSteps){
      delay(1);
    } //wait here until it is time for the next iteration
    incrimentalTime += lastStepTime;
    //work out exactly how much time elapsed just in case it was more than the required timestep
    lastStepTime = System.currentTimeMillis() - lastStepStart;
    //finally log the data
    
    if(logBenchmarks) loopEndMark = System.currentTimeMillis();
    logTrialData();
    trialStep++;
  }
  haltTrial();
  trialActive = false;
}

void waitForReply(int timeout){
  //wait for a reply
  
  int timeoutTimer = 0;
  while(waitingForA == true || waitingForB == true){
    if(surpressA) waitingForA = false;
    if(surpressB) waitingForB = false;
    //Wait for new data
    timeoutTimer++;
    delay(1);
    if(timeoutTimer > timeout){
      if(newDataFromA == false) timeoutsA++;
      if(newDataFromB == false) timeoutsB++;
      return;
    }
  }
}

void haltTrial(){
  //halt the trial now
  String haltMessage = "Trial Stopped";
  sendEndTrial(1, haltMessage);
  sendEndTrial(2, haltMessage);
}

void updateEnvironment(){
  if(userAPos < 0) userAPos = envWidth+userAPos;
  if(userBPos < 0) userBPos = envWidth+userBPos;
  userA.move(userAPos);
  userB.move(userBPos);
  checkCollisions();
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
  
  if(userATouchingStatic||bothUsersTouching||userATouchingLure) userAContact = true;
  else userAContact = false;
  if(userBTouchingStatic||bothUsersTouching||userBTouchingLure) userBContact = true;
  else userBContact = false;
}