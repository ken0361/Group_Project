
import mqtt.*; 
import controlP5.*;

ControlP5 cp5;
MQTTClient client;
Dashboard_view view = new Dashboard_view();
OrderData api = new OrderData();
Database db = new Database(); //Simulate Database, each database can store up to 100 orders
PImage img;
//circle
Dong[][] d;
int nx = 10;
int ny = 10;
//label
Textlabel myTextlabelA;
Textlabel myTextlabel1;
Textlabel myTextlabel2;

void setup() {
    cp5 = new ControlP5(this); 
    smooth();
    
    size(900, 600);
    // connect to the broker
    client = new MQTTClient(this);
    // connect to the broker and use a random string for clientid
    client.connect("mqtt://try:try@broker.hivemq.com", "processing_desktop" + str(random(3)));
    delay(100);
    // refresh the dashboard with the information
    updateDashboardData();
    
    img = loadImage("1.jpg");
    //image(img, 0, 0);
    //circle
    d = new Dong[nx][ny];
    for (int x = 0;x<nx;x++) {
      for (int y = 0;y<ny;y++) {
        d[x][y] = new Dong();
      }
    }  
    //label
    myTextlabelA = cp5.addTextlabel("labelA")
                    .setText("Library Management System")
                    .setPosition(400,50)
                    .setColorValue(#2173DB)
                    .setFont(createFont("Georgia",30))
                    ;
    myTextlabel1 = cp5.addTextlabel("label")
                    .setText("A          B         C")
                    .setPosition(100,500)
                    .setColorValue(#BF1F3C)
                    .setFont(createFont("Georgia",30))
                    ;               
  


  
     
}

// we don't really use the draw function as controlP5 does the work
void draw() {
    
  background(0);
  image(img, 0, 0);
  //circle
  fill(141,176,222);
  pushMatrix();
  translate(width/2 - 250, height/2 - 100);
  rotate(frameCount*0.001);
  for (int x = 0;x<nx;x++) {
    for (int y = 0;y<ny;y++) {
      d[x][y].display();
    }
  }
  popMatrix();
   
}

class Dong {
  float x, y;
  float s0, s1;

  Dong() {
    float f= random(-PI, PI);
    x = cos(f)*random(100, 150);
    y = sin(f)*random(100, 150);
    s0 = random(2, 10);
  }

  void display() {
    s1 += (s0-s1)*0.1;
    ellipse(x, y, s1, s1);
  }

  void update() {
    s1 = 50;
  }
}
