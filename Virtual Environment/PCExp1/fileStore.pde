void startLogs(){
  startLogA();
  startLogB();
}

void stopLogs(){
  stopLogA();
  stopLogB();
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

void logDataA(String dataLine){
   if(logAOpen == false) return;
   LogFileA.append(dataLine);
}

void logDataB(String dataLine){
   if(logBOpen == false) return;
   LogFileB.append(dataLine);
}