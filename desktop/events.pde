// User interaction logic calling data (model) and views

String expanded_order; //ID of order in focus
String MQTT_topic = "book_orders";
int button_state = 0;
int flag = 0;

void clientConnected() {
    println("client connected to broker");
    client.subscribe(MQTT_topic);
}

void connectionLost() {
    println("connection lost");
}

void messageReceived(String topic, byte[] payload) {
    JSONObject json = parseJSONObject(new String(payload));
    if (json == null) {
        println("Order could not be parsed");
    } else {
        api.saveOrdertoDB(json);
        refreshData();
    }
    refreshDashboardData();
}

void controlEvent(ControlEvent theEvent) {
    // expand order if clicked via API call
    if (theEvent.getController().getValueLabel().getText().contains("O") == true) {
        // call the api and get the JSON packet
        expanded_order = api.getOrdersByStatus(theEvent.getController().getName())[(int) theEvent.getController().getValue()].getString("query_id");
       // view.build_expanded_order(expanded_order);
       
    }
    //println(theEvent.getController().getName());
   /* if (theEvent.getController().getName().equals("tatal_amount") == true ) {
      println("name1: "+theEvent.getController().getName());
      tatal_amount();
    }
    if (theEvent.getController().getName().equals("available_amount") == true) {
          println("name2: "+theEvent.getController().getName());
          available_amount();*/
         /* if (flag == 0) {
            println("flag from 0 to 1");
            flag = 1;
          }
         else {
           println("flag from 1 to 0");
           flag = 0;
         }*/
    
    
}

public void tatal_amount() {
  flag = 0;
  //refreshDashboardData();
 // refreshDashboardData();
 //updateDashboardData();
  println("flag1:"+flag);
}

public void available_amount() {
  flag = 1;
 // refreshDashboardData();
  //refreshDashboardData();
  println("flag2:"+flag);
}



/*

// call back on button click
public void accept(int theValue) {
    if (button_state > 2) {
        api.updateOrderStatus(expanded_order, Status.AVAILABLE);
    }
    
    
    button_state = button_state + 1;
}

// call back on button click
public void cancel(int theValue) {
    if (button_state > 2) {
        api.updateOrderStatus(expanded_order, Status.BORROWED);
    }
    button_state = button_state + 1;
}

// call back on button click
public void ready(int theValue) {
    if (button_state > 2) {
        api.updateOrderStatus(expanded_order, Status.EXCEPTIONAL);
    }
    button_state = button_state + 1;
}*/
