void startTrackerball(){
  xCountTotal = 0;
  yCountTotal = 0;
  attachInterrupt(TRACKERBALL_XA, chA_X_ISR, CHANGE);
  attachInterrupt(TRACKERBALL_XB, chB_X_ISR, CHANGE);
  attachInterrupt(TRACKERBALL_YA, chA_Y_ISR, CHANGE);
  attachInterrupt(TRACKERBALL_YB, chB_Y_ISR, CHANGE);

}
void stopTrackerball(){
  detachInterrupt(TRACKERBALL_XA);
  detachInterrupt(TRACKERBALL_XB);
  detachInterrupt(TRACKERBALL_YA);
  detachInterrupt(TRACKERBALL_YB);

}

void chA_X_ISR(){
  boolean stateA = 0, stateB = 0;
  stateA = digitalReadFast(TRACKERBALL_XA);
  stateB = digitalReadFast(TRACKERBALL_XB);
  if(stateA && stateB)        xCountTotal--;
  else if(stateA && !stateB)  xCountTotal++;
  else if(!stateA && stateB)  xCountTotal++;
  else if(!stateA && !stateB) xCountTotal--;
  //USB.println(leftCountTotal);
  return;
}

//----------------------------------------------------
void chB_X_ISR(){
  boolean stateA = 0, stateB = 0;
  stateA = digitalReadFast(TRACKERBALL_XA);
  stateB = digitalReadFast(TRACKERBALL_XB);
  if(stateA && stateB)        xCountTotal++;
  else if(stateA && !stateB)  xCountTotal--;
  else if(!stateA && stateB)  xCountTotal--;
  else if(!stateA && !stateB) xCountTotal++;
  //USB.println(leftCountTotal);
  return;
}

void chA_Y_ISR(){
  boolean stateA = 0, stateB = 0;
  stateA = digitalReadFast(TRACKERBALL_YA);
  stateB = digitalReadFast(TRACKERBALL_YB);
  if(stateA && stateB)        yCountTotal++;
  else if(stateA && !stateB)  yCountTotal--;
  else if(!stateA && stateB)  yCountTotal--;
  else if(!stateA && !stateB) yCountTotal++;
  //USB.println(leftCountTotal);
  return;
}

//----------------------------------------------------
void chB_Y_ISR(){
  boolean stateA = 0, stateB = 0;
  stateA = digitalReadFast(TRACKERBALL_YA);
  stateB = digitalReadFast(TRACKERBALL_YB);
  if(stateA && stateB)        yCountTotal--;
  else if(stateA && !stateB)  yCountTotal++;
  else if(!stateA && stateB)  yCountTotal++;
  else if(!stateA && !stateB) yCountTotal--;
  //USB.println(leftCountTotal);
  return;
}
