void printMessage(){
  #ifdef LCDOK
    lcd.clear();
    //lcd.home();
    lcd.setCursor(0, 0);
    lcd.print(LCDText);
   #endif
}

