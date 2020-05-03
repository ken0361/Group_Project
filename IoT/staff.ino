#include <M5Stack.h>

void setup() {
  
  M5.begin();

  M5.Power.begin();

  M5.Lcd.clear(BLACK);
  M5.Lcd.setTextColor(YELLOW);
  M5.Lcd.setTextSize(2);
  M5.Lcd.setCursor(60, 10);
  M5.Lcd.println("Library Management");
  M5.Lcd.setCursor(120, 30);
  M5.Lcd.println("System");
  M5.Lcd.setCursor(3, 200);
  M5.Lcd.println("Press button B to continue");
  M5.Lcd.setTextColor(RED);
}

// Add the main program code into the continuous loop() function
void loop() {
  // update button state
  M5.update();
 
  // if you want to use Releasefor("was released for"), use .wasReleasefor(int time) below
  if (M5.BtnA.wasReleased()) {
    M5.Lcd.print('A');
  } else if (M5.BtnB.wasReleased()) {
    M5.Lcd.print('B');
  } else if (M5.BtnC.wasReleased()) {
    M5.Lcd.print('C');
  } else if (M5.BtnB.wasReleasefor(700)) {
    M5.Lcd.clear(BLACK);
    M5.Lcd.setCursor(0, 0);
  }
}
