void initPins(){

  pinMode(TRACKERBALL_XA, INPUT);
  pinMode(TRACKERBALL_XB, INPUT);
  
  pinMode(TRACKERBALL_YA, INPUT);
  pinMode(TRACKERBALL_YB, INPUT);

  pinMode(LCD4, OUTPUT);
  pinMode(LCD5, OUTPUT);
  pinMode(LCD6, OUTPUT);
  pinMode(LCD7, OUTPUT);
  pinMode(LCDRS, OUTPUT);
  pinMode(LCDEN, OUTPUT);
  pinMode(LCDRW, OUTPUT);
  pinMode(H1ENABLE, OUTPUT);
  pinMode(H1PWMPIN, OUTPUT);

  pinMode(USER_SWITCH_PIN, INPUT_PULLUP);
  pinMode(USER_LED_PIN, OUTPUT);
  pinMode(SOUNDER_PIN, OUTPUT);
}

void initSerial(){
  USB.begin(SERIAL_SPEED);
  
  while(!USB);
  //USB.println(F("Started!"));
}

void initLCD(){
  // 7 pin connection (fast): normal LCD, single HD44780 controller
  //LiquidCrystalFast(uint8_t rs, uint8_t rw, uint8_t enable, uint8_t d4, uint8_t d5, uint8_t d6, uint8_t d7) 
  #ifdef LCDOK
    lcd.begin(nColumns, nRows);
    // Print a message to the LCD.
    lcd.print("System Online!");
  #endif
}

