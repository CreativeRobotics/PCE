//Piezo sounder drivers
//int beepTimer = 0;
//int beepLimit = 0;


void beepX(unsigned long duration){
  //blocking version for startup
  digitalWrite(SOUNDER_PIN, 1);
  for(unsigned long n = 0; n < duration; n++) delay(1);
  digitalWrite(SOUNDER_PIN, 0);
}
void beep(unsigned long duration){
 // tone(SOUNDER_PIN, ppitch, duration);
  beepON();
  beepStart = millis();
  beepEnd = beepStart+ duration;
}

void updateBeep(){
  if(millis() > beepEnd) beepOFF();
}


void beepON(){
  digitalWrite(SOUNDER_PIN, 1);
}

void beepOFF(){
  digitalWrite(SOUNDER_PIN, 0);
}