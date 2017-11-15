
#define LCDOK

#define USB Serial
#define SERIAL_SPEED 115200
#define COMMA   ','
#define NEWLINE '\n'
#define RETURN  '\r'
#define BUFFERSIZE 128
char serialBuffer[BUFFERSIZE];
int bufferIndex = 0;
boolean newData = 0;
#define SERIAL_COMMAND 0
unsigned long packetsReceived = 0;

volatile long xCountTotal = 0;
volatile long yCountTotal = 0;
long oldXCount = 0;
long oldYCount = 0;

elapsedMillis printTimer = 0;
unsigned long printTime = 50;

elapsedMillis dataSendTimer = 0;
boolean buttonState = 0;
int LEDBrightness = 0;

//Haptics haptic1;
//Haptics haptic2;

uint16_t hapticRate1 = 0, hapticRate2 = 0;
//LCD
uint8_t nRows = 2;      //number of rows on LCD
uint8_t nColumns = 16;  //number of columns
char LCDText[33];


unsigned long beepStart = 0, beepEnd = 0;
unsigned long flashStart = 0, flashEnd = 0;
bool flashActive = 0;

unsigned long beepLengthCommand = 0;
unsigned long flashLengthCommand = 0;