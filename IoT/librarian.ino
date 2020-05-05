
/*******************************************************************************************
 *
 * Library includes.
 *
 ******************************************************************************************/

// M5 Stack system.
#include <M5Stack.h>


// M5 Stack Wifi connection.
#include <WiFi.h>
#include <esp_wifi.h>
WiFiClient wifi_client;

// PubSubClient external library.
#include <PubSubClient.h>
PubSubClient ps_client( wifi_client );


// Extra, created by SEGP team
#include "Timer.h"



/*******************************************************************************************
 *
 * Global Variables
 *
 ******************************************************************************************/

uint8_t guestMacAddress[6] = {0xA4, 0x02, 0xB9, 0xDF, 0x58, 0x04};

// Wifi settings
const char* ssid = "UoB Guest";                 // Set name of Wifi Network
const char* password = "";                      // No password for UoB Guest


// MQTT Settings
const char* MQTT_clientname = "SEGP_GROUP7"; // Make up a short name
const char* MQTT_sub_topic = "SEGP_GROUP7"; // pub/sub topics
const char* MQTT_pub_topic = "SEGP_GROUP7"; // You might want to create your own

// Please leave this alone - to connect to HiveMQ
const char* server = "broker.mqttdashboard.com";
const int port = 1883;


// Instance of a Timer class, which allows us
// a basic task scheduling of some code.  See
// it used in Loop().
// See Timer.h for more details.
// Argument = millisecond period to schedule
// task.  Here, 2 seconds.
Timer publishing_timer(2000);





/*******************************************************************************************
 *
 * Setup() and Loop()
 *
 ******************************************************************************************/

// Standard, one time setup function.
void setup()
{
    M5.begin();
    M5.Power.begin();

    // title page
    titlePage();
    

    // logo
    drawLogo();

    // scan book
    scanBook();

    // connecting page
    M5.Lcd.clear(BLACK);   
    M5.Lcd.setTextSize(2);
    M5.Lcd.setCursor( 10, 10 );
    M5.Lcd.setTextColor( WHITE );
    M5.Lcd.println("Reset, connecting ...");

    // Setup a serial port, good for debugging.
    // You can view data with the Arduino IDE
    // serial monitor.
    Serial.begin(115200);
    delay(10);
    Serial.println("*** RESET ***\n");


    // Use this with no wifi password set.
    // e.g., UoB Guest network.
    setupWifi();
    

    // Sets up a connection to hiveMQ.
    // Sets up a call back function to run
    // which checks for new messages.
    setupMQTT();


    // Maybe you need to write your own
    // setup code after this...
}


// Standard, iterative loop function (main)
void loop()
{
  // Leave this code here.  It checks that you are
  // still connected, and performs an update of itself.
  if (!ps_client.connected())
  {
    reconnect();
  }
  
  ps_client.loop();


  // This is an example of using our timer class to
  // publish a message every 2000 milliseconds, as
  // set when we initalised the class above.
  /*if( publishing_timer.isReady() && M5.BtnB.wasReleased()) {

      // Prepare a string to send.
      // Here we include millis() so that we can
      // tell when new messages are arrive in hiveMQ
      String new_string = "hello?";
      new_string += millis();
      publishMessage( "hihi this is test !!" );

      // Remember to reset your timer when you have
      // used it. This starts the clock again.
      publishing_timer.reset();
  }*/




  // Just incase we print so much text we run off the
  // screen!  Clear screen, set cursor back to the top.
  if( M5.Lcd.getCursorY() > M5.Lcd.height() ) {
    M5.Lcd.fillScreen( BLACK );
    M5.Lcd.setCursor( 0, 10 );
  }
}





/*******************************************************************************************
 *
 * Helper functions after this...
 *
 ******************************************************************************************/


// Use this function to publish a message.  It currently
// checks for a connection, and checks for a zero length
// message.  Note, it doens't do anything if these fail.
//
// Note that, it publishes to MQTT_topic value
//
// Also, it doesn't seem to like a concatenated String
// to be passed in directly as an argument like:
// publishMessage( "my text" + millis() );
// So instead, pre-prepare a String variable, and then
// pass that.
void publishMessage( String message )
{

  if( ps_client.connected() ) {

    // Make sure the message isn't blank.
    if( message.length() > 0 ) {

      // Convert to char array
      char msg[ message.length() ];
      message.toCharArray( msg, message.length() );

      M5.Lcd.print(">> Tx: ");
      M5.Lcd.println( message );

      // Send
      ps_client.publish( MQTT_pub_topic, msg );
    }

  } else {
    Serial.println("Can't publish message: Not connected to MQTT :( ");

  }


}

// This is where we pick up messages from the MQTT broker.
// This function is called automatically when a message is
// received.
//
// Note that, it receives from MQTT_topic value.
//
// Note that, you will receive messages from yourself, if
// you publish a message, activating this function.

void callback(char* topic, byte* payload, unsigned int length)
{

  Serial.print("Message arrived [");
  Serial.print(topic);
  Serial.print("] ");

  String in_str = "";
  char input[length+1];

  // Copy chars to a String for convenience.
  // Also prints to USB serial for debugging
  for (int i=0;i<length;i++) {
    in_str += (char)payload[i];
    input[i] = (char)payload[i];
    Serial.print((char)payload[i]);
  }
  in_str += '\0';
  input[length] = '\0';
  Serial.println();
  
  //M5.Lcd.println(">> message from computer: " );
  //M5.Lcd.println( in_str );

  splitAndPrintBookInfo(input);

}

void splitAndPrintBookInfo(char input[])
{
  char* bookName;
  char* bookStatus;
  char* positions;
  char delimiter[] = ",";
  char* ptr = strtok(input, delimiter);

  while(ptr != NULL)
  {
    String temp = String(ptr);
    if(temp.indexOf("book_name") >= 0)
    {
      bookName = ptr;
    }
    else if(temp.indexOf("book_status") >= 0)
    {
      bookStatus = ptr;
    }
    else if(temp.indexOf("position") >= 0)
    {
      positions = ptr;
    }
    ptr = strtok(NULL, delimiter);
  }

  printBookInfo(bookName, bookStatus, positions);
}

void printBookInfo(char* bookName, char* bookStatus, char* positions)
{
    M5.Lcd.clear(BLACK);
    
    M5.Lcd.fillRect(0, 0, 320, 80, RED);
    M5.Lcd.fillRect(10, 10, 300, 60, BLACK);
    M5.Lcd.fillRect(0, 80, 320, 80, DARKGREY);
    M5.Lcd.fillRect(10, 90, 300, 60, BLACK);
    M5.Lcd.fillRect(0, 160, 320, 80, DARKGREEN);
    M5.Lcd.fillRect(10, 170, 300, 60, BLACK);
    
    M5.Lcd.setTextSize(2);
    M5.Lcd.setTextColor(WHITE);
    M5.Lcd.setCursor(10, 30);
    M5.Lcd.println(bookName);

    M5.Lcd.setTextColor(WHITE);
    M5.Lcd.setCursor(10, 110);
    M5.Lcd.println(bookStatus);

    M5.Lcd.setTextColor(WHITE);
    M5.Lcd.setCursor(10, 190);
    M5.Lcd.println(positions);
}

void scanBook()
{
    M5.Lcd.clear(BLACK);
    M5.Lcd.setTextSize(3);
    M5.Lcd.setTextColor(YELLOW);
    M5.Lcd.setCursor(120, 30);
    M5.Lcd.println("Scan");
    M5.Lcd.drawRect(100, 80, 120, 120, BLUE);

    while(true)
    {
      delay(10);
      if(M5.BtnB.wasReleased())
      {
        M5.Lcd.fillRect(100, 80, 120, 120, BLUE);
        delay(2000);
        break;
      }
      M5.update();
    }
}

void titlePage()
{
    M5.Lcd.fillScreen(BLACK);
    M5.Lcd.setTextColor(YELLOW);
    M5.Lcd.setTextSize(3);
    M5.Lcd.setCursor(60, 60);
    M5.Lcd.println("Library");
    M5.Lcd.setCursor(60, 90);
    M5.Lcd.println("Management");
    M5.Lcd.setCursor(60, 120);
    M5.Lcd.println("System");
    delay(500);
    M5.Lcd.setTextSize(2);
    M5.Lcd.setTextColor(WHITE);
    M5.Lcd.setCursor(200, 160);
    M5.Lcd.println("Group 7");
    delay(2500);
}

void drawLogo()
{
    M5.Lcd.clear(BLACK);
    M5.Lcd.setTextSize(3);
    M5.Lcd.setTextColor(YELLOW);
    M5.Lcd.setCursor(120, 30);
    M5.Lcd.println("Librarian");
    delay(500);
    M5.Lcd.drawLine(40, 155, 100, 80, TFT_WHITE);
    delay(500);
    M5.Lcd.drawCircle(80, 160, 40, WHITE);
    delay(500);
    M5.Lcd.drawLine(120, 160, 160, 160, TFT_WHITE);
    delay(500);
    M5.Lcd.drawCircle(200, 160, 40, WHITE);
    delay(500);
    M5.Lcd.drawLine(240, 160, 280, 90, TFT_WHITE);
    delay(500);
    M5.Lcd.fillCircle(80, 160, 40, WHITE);
    M5.Lcd.fillCircle(200, 160, 40, WHITE);
    delay(1500);
}



/*******************************************************************************************
 *
 *
 * You shouldn't need to change any code below this point!
 *
 *
 *
 ******************************************************************************************/


void setupMQTT() {
    ps_client.setServer(server, port);
    ps_client.setCallback(callback);
}

void setupWifi() {

    byte mac[6];
    Serial.println("Original MAC address: " + String(WiFi.macAddress()));
    esp_base_mac_addr_set(guestMacAddress);
    Serial.println("Borrowed MAC address: " + String(WiFi.macAddress()));

    Serial.println("Connecting to network: " + String(ssid));
    WiFi.begin(ssid );
    while (WiFi.status() != WL_CONNECTED) delay(500);
    Serial.println("IP address allocated: " + String(WiFi.localIP()));
}

void setupWifiWithPassword( ) {

    byte mac[6];
    Serial.println("Original MAC address: " + String(WiFi.macAddress()));
    esp_base_mac_addr_set(guestMacAddress);
    Serial.println("Borrowed MAC address: " + String(WiFi.macAddress()));

    Serial.println("Connecting to network: " + String(ssid));
    WiFi.begin(ssid, password);

    while (WiFi.status() != WL_CONNECTED) delay(500);
    Serial.println("IP address allocated: " + String(WiFi.localIP()));

}



void reconnect() {

  // Loop until we're reconnected
  while (!ps_client.connected()) {

    Serial.print("Attempting MQTT connection...");

    // Attempt to connect
    // Sometimes a connection with HiveMQ is refused
    // because an old Client ID is not erased.  So to
    // get around this, we just generate new ID's
    // every time we need to reconnect.
    String new_id = generateID();

    Serial.print("connecting with ID ");
    Serial.println( new_id );

    char id_array[ (int)new_id.length() ];
    new_id.toCharArray(id_array, sizeof( id_array ) );

    if (ps_client.connect( id_array ) ) {
      Serial.println("connected");

      // Once connected, publish an announcement...
      ps_client.publish( MQTT_pub_topic, "reconnected");
      // ... and resubscribe
      ps_client.subscribe( MQTT_sub_topic );
    } else {
      if( M5.Lcd.getCursorY() > M5.Lcd.height() )
      {
        M5.Lcd.fillScreen( BLACK );
        M5.Lcd.setCursor( 0, 10 );
      }
      M5.Lcd.println(" - Coudn't connect to HiveMQ :(");
      M5.Lcd.println("   Trying again.");
      Serial.print("failed, rc=");
      Serial.print(ps_client.state());
      Serial.println(" try again in 5 seconds");
      // Wait 5 seconds before retrying
      delay(5000);
    }
  }
  M5.Lcd.println(" - Success!  Connected to HiveMQ\n\n");
}

String generateID() {

  String id_str = MQTT_clientname;
  id_str += random(0,9999);

  return id_str;
}
