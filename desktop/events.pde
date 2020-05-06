// User interaction logic calling data (model) and views

String book_details; //ID of order in focus
String MQTT_topic_receive = "book_orders";
String MQTT_topic_send = "send_info";
int button_state1 = 0;
int button_state2 = 0;
int flag = 0;

void clientConnected() {
    println("client connected to broker");
    client.subscribe(MQTT_topic_receive);
}

void connectionLost() {
    println("connection lost");
}

void messageReceived(String topic, byte[] payload) {
    JSONObject json = parseJSONObject(new String(payload));
    if (json == null) {
        println("Order could not be parsed");
    } else {
        api.updateBookStatus(json.getString("book_id"), json.getString("book_status"));
        refreshData();
    }
    refreshDashboardData();
}

void controlEvent(ControlEvent theEvent) {
    // expand order if clicked via API call
    println("action: ");
    println(theEvent.getController().getValueLabel().getText());
    if (theEvent.getController().getValueLabel().getText().contains("Q") == true) {
        // call the api and get the JSON packet
        println("name: " + theEvent.getController().getName());
        println("[]: "+(int) theEvent.getController().getValue());
        book_details = api.getOrdersByStatus(theEvent.getController().getName())[(int) theEvent.getController().getValue()].getString("book_id");
        println("book_details: "+book_details);
        view.build_book_details(book_details);
       
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
  if (button_state2 > 2) {
  flag = 0;
  refreshDashboardData();
  println("flag1:"+flag);
  }
  button_state2 = button_state2 + 1;
  //
 //updateDashboardData();
  
}

public void available_amount() {
  if (button_state2 > 2) {
  flag = 1;
  refreshDashboardData();
  println("flag2:"+flag);
  }
  button_state2 = button_state2 + 1;
}



// call back on button click
public void toAvailable() {
    if (button_state1 > 3) {
        api.updateBookStatus(book_details, Status.AVAILABLE);
        refreshDashboardData();
    }
    button_state1 = button_state1 + 1;
}

// call back on button click
public void toBorrowed() {
    if (button_state1 > 3) {
        api.updateBookStatus(book_details, Status.BORROWED);
        refreshDashboardData();
    }
    button_state1 = button_state1 + 1;
}

// call back on button click
public void toExceptional() {
    if (button_state1 > 3) {
        api.updateBookStatus(book_details, Status.EXCEPTIONAL);
        refreshDashboardData();
    }
    button_state1 = button_state1 + 1;
}

// call back on button click
public void toReserved() {
  println("call reserved!!! ");
    if (button_state1 > 3) {
        api.updateBookStatus(book_details, Status.RESERVED);
        refreshDashboardData();
    }
    button_state1 = button_state1 + 1;
}
