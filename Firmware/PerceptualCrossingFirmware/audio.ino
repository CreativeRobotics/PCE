//Piezo sounder drivers
//int beepTimer = 0;
//int beepLimit = 0;
long beepStart = 0, beepEnd = 0;

void beepX(int duration){
  //blocking version for startup
  digitalWrite(SOUNDER_PIN, 1);
  for(int n = 0; n < duration; n++) delay(1);
  digitalWrite(SOUNDER_PIN, 0);
}
void beep(int duration){
 // tone(SOUNDER_PIN, ppitch, duration);
  digitalWrite(SOUNDER_PIN, 1);
  beepStart = millis();
  beepEnd = beepStart+ duration;
}

void updateBeep(){
  if(millis() > beepEnd) digitalWrite(SOUNDER_PIN, 0);
}

