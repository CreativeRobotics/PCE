int boolToInt(boolean b) {
    return Boolean.compare(b, false);
}
void writeFileHeader(){
  if(logCombinedOpen == true){
    LogFileCombined.print("Step" + ',');
    LogFileCombined.print("System Time" + ',');
    //LogFileCombined.print(String.valueOf(dataStoreTime) + ',');
    LogFileCombined.print("Target step time" + ',');
    LogFileCombined.print("Last step time" + ',');
    LogFileCombined.print("UserA-Static" + ',');
    LogFileCombined.print("UserB-Static" + ',');
    LogFileCombined.print("UserA-Lure" + ',');
    LogFileCombined.print("UserB-Lure" + ',');
    LogFileCombined.print("Users Touching" + ',');
    LogFileCombined.print("A"                                   + ',');
    LogFileCombined.print("A-SerialErrors"           + ','); 
    LogFileCombined.print("A-Serial Timeouts"             + ',');
    LogFileCombined.print("A-Response Time"        + ','); //time between sending a data request and getting a reply
    LogFileCombined.print("A-Position"    + ',');
    LogFileCombined.print("A-Elapsed time"     + ','); //elapsed time since the device sent the last packet of data (as measured by the device)
    LogFileCombined.print("A-Tracker X"         + ',');
    LogFileCombined.print("A-Tracker Y"        + ',');
    LogFileCombined.print("A-Buttonstate"    + ',');
    LogFileCombined.print("A-Led Value"   + ',');
    LogFileCombined.print("A-Haptic 1" + ',');
    LogFileCombined.print("A-Haptic 2" + ',');
    LogFileCombined.print("B"                                   + ',');
    LogFileCombined.print("B-SerialErrors"           + ','); 
    LogFileCombined.print("B-Serial Timeouts"             + ',');
    LogFileCombined.print("B-Response Time"        + ','); //time between sending a data request and getting a reply
    LogFileCombined.print("B-Position"    + ',');
    LogFileCombined.print("B-Elapsed time"     + ','); //elapsed time since the device sent the last packet of data (as measured by the device)
    LogFileCombined.print("B-Tracker X"         + ',');
    LogFileCombined.print("B-Tracker Y"        + ',');
    LogFileCombined.print("B-Buttonstate"    + ',');
    LogFileCombined.print("B-Led Value"   + ',');
    LogFileCombined.print("B-Haptic 1" + ',');
    LogFileCombined.println("B-Haptic 2" + ',');
  }

  
}
void logTrialData(){
  //save everything to the files

  
  if(logCombinedOpen == true){
    LogFileCombined.print(String.valueOf(trialStep) + ',');
    LogFileCombined.print(String.valueOf(System.currentTimeMillis()) + ',');
    //LogFileCombined.print(String.valueOf(dataStoreTime) + ',');
    LogFileCombined.print(String.valueOf(millisecondsBetweenSteps) + ',');
    LogFileCombined.print(String.valueOf(lastStepTime) + ',');
    LogFileCombined.print(String.valueOf(boolToInt(userATouchingStatic)) + ',');
    LogFileCombined.print(String.valueOf(boolToInt(userBTouchingStatic)) + ',');
    LogFileCombined.print(String.valueOf(boolToInt(userATouchingLure)) + ',');
    LogFileCombined.print(String.valueOf(boolToInt(userBTouchingLure)) + ',');
    LogFileCombined.print(String.valueOf(boolToInt(bothUsersTouching)) + ',');
    LogFileCombined.print("A"                                   + ',');
    LogFileCombined.print(String.valueOf(errorCountA)           + ','); 
    LogFileCombined.print(String.valueOf(timeoutsA)             + ',');
    LogFileCombined.print(String.valueOf(responseTimeA)         + ','); //time between sending a data request and getting a reply
    LogFileCombined.print(String.valueOf(userA.userPosition)    + ',');
    LogFileCombined.print(String.valueOf(userA.ElapsedTime)     + ','); //elapsed time since the device sent the last packet of data (as measured by the device)
    LogFileCombined.print(String.valueOf(userA.XChange)         + ',');
    LogFileCombined.print(String.valueOf(userA.YChange)         + ',');
    LogFileCombined.print(String.valueOf(userA.buttonState)     + ',');
    LogFileCombined.print(String.valueOf(userA.LEDBrightness)   + ',');
    LogFileCombined.print(String.valueOf(userA.hapticStrength1) + ',');
    LogFileCombined.print(String.valueOf(userA.hapticStrength2) + ',');
    LogFileCombined.print("B"                                   + ',');
    LogFileCombined.print(String.valueOf(errorCountB)           + ',');
    LogFileCombined.print(String.valueOf(timeoutsB)             + ',');
    LogFileCombined.print(String.valueOf(responseTimeB)         + ',');
    LogFileCombined.print(String.valueOf(userB.userPosition)    + ',');
    LogFileCombined.print(String.valueOf(userB.ElapsedTime)     + ',');
    LogFileCombined.print(String.valueOf(userB.XChange)         + ',');
    LogFileCombined.print(String.valueOf(userB.YChange)         + ',');
    LogFileCombined.print(String.valueOf(userB.buttonState)     + ',');
    LogFileCombined.print(String.valueOf(userB.LEDBrightness)   + ',');
    LogFileCombined.print(String.valueOf(userB.hapticStrength1) + ',');
    if(logBenchmarks){
      LogFileCombined.print(String.valueOf(userB.hapticStrength2) + ',' );
      LogFileCombined.print(String.valueOf(loopStartMark) + ',');
      LogFileCombined.print(String.valueOf(loopMark1-loopStartMark) + ',');
      LogFileCombined.print(String.valueOf(loopMark2-loopStartMark) + ',');
      LogFileCombined.print(String.valueOf(loopMark3-loopStartMark) + ',');
      LogFileCombined.print(String.valueOf(loopMark4-loopStartMark) + ',');
      LogFileCombined.println(String.valueOf(loopEndMark-loopStartMark));
    }
    else LogFileCombined.println(String.valueOf(userB.hapticStrength2) );
  }
}


void startLogs(){
  //startLogA();
  //startLogB();
  startLogCombined();
}

void stopLogs(){
  //stopLogA();
  //stopLogB();
  stopLogCombined();
}
void startLogCombined(){
  //Open a new file wigh the name bLog and appended with the date
  if(logCombinedOpen == true) {
    println("Error combined log already open");
    return;
  }
  String filedate = hour() + "," + minute() + "," + second() + " " + day() + "-" + month() + "-" + year();
  String filename = "PCE_COMBINED_LOG " + filedate + ".csv";
  println("Starting combined log");
  LogFileCombined = createWriter(filename);
  logCombinedOpen = true;
  writeFileHeader();
}

void stopLogCombined(){
  //close the file
  if(logCombinedOpen == false) {
    println("Error combined log already closed");
    return;
  }
  println("Stopping combined log");
  LogFileCombined.flush();  // Writes the remaining data to the file
  LogFileCombined.close();
  logCombinedOpen = false;
}

void startLogA(){
  //Open a new file wigh the name bLog and appended with the date
  if(logAOpen == true) {
    println("Error Log A already open");
    return;
  }
  String filedate = hour() + "," + minute() + "," + second() + " " + day() + "-" + month() + "-" + year();
  String filename = "PCE_LOGA " + filedate + ".csv";
  println("Starting Log A");
  LogFileA = createWriter(filename);
  logAOpen = true;
}


void stopLogA(){
  //close the file
  if(logAOpen == false) {
    println("Error Log A already closed");
    return;
  }
  println("Stopping Log A");
  LogFileA.flush();  // Writes the remaining data to the file
  LogFileA.close();
  logAOpen = false;
}

void startLogB(){
  //Open a new file wigh the name bLog and appended with the date
  if(logBOpen == true) {
    println("Error Log B already open");
    return;
  }
  String filedate = hour() + "," + minute() + "," + second() + " " + day() + "-" + month() + "-" + year();
  String filename = "PCE_LOGA " + filedate + ".csv";
  println("Starting Log B");
  LogFileB = createWriter(filename);
  logBOpen = true;
}

void stopLogB(){
  //close the file
  if(logBOpen == false) {
    println("Error Log B already closed");
    return;
  }
  println("Stopping Log B");
  LogFileB.flush();  // Writes the remaining data to the file
  LogFileB.close();
  logBOpen = false;
}

void logDataCombined(String dataLine){
   if(logCombinedOpen == false) return;
   LogFileCombined.append(dataLine);
}

void logDataA(String dataLine){
   if(logAOpen == false) return;
   LogFileA.append(dataLine);
}

void logDataB(String dataLine){
   if(logBOpen == false) return;
   LogFileB.append(dataLine);
}