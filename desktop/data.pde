// Data focused on reading, writing and preparing data
static abstract class Status {
  static final String[] LIST = {
    Status.AVAILABLE, 
    Status.BORROWED, 
    Status.EXCEPTIONAL, 
  };
  static final String AVAILABLE = "available";
  static final String BORROWED = "borrowed";
  static final String EXCEPTIONAL = "exceptional";
}

static abstract class Area {
  static final String[] LIST = {
    Area.A, 
    Area.B, 
    Area.C, 
  };
  static final String A = "A";
  static final String B = "B";
  static final String C = "C";
}


// Example use of public class for metric as we use multiple (modular design)
public class Metric {
  public String name;
  public float value;
  // The Constructor
  Metric(String _name, float _value) {
    name = _name;
    value = _value;
  }
}
// Simulate SoC b/w API and Database
private class Database {
  int max_orders = 100; //max order number is 100;
  JSONObject[] orders = new JSONObject[max_orders];
  Database() {
  }
  int max_orders() {
    return max_orders;
  }
}

// copy all JSON objects on disk into working memory
void refreshData() {
  File dir;
  File[] files;
  dir = new File(dataPath(""));
  files = dir.listFiles();
  JSONObject json;
  if (files != null) {
    for (int i = 0; i <= files.length - 1; i++) {
      String path = files[i].getAbsolutePath();
      if (path.toLowerCase().endsWith(".json")) {
        json = loadJSONObject(path);
        if (json != null) {
          db.orders[i] = json;
        }
      }
    }
  }
}
// this is our API class to ensure separation of concerns. User -> API -> DB
public class OrderData {
  
  //get Orders By Status
  JSONObject[] getOrdersByStatus(String status) {
    JSONObject[] ret = new JSONObject[0];
    for (JSONObject order : db.orders) {
      if (order != null) {
        if (status.contains(order.getString("book_status"))) {
          ret = (JSONObject[]) append(ret, order);
        }
      }
    }
    return ret;
  }
  
  //get Orders By Area
  JSONObject[] getOrdersByArea(String area) {
    JSONObject[] ret = new JSONObject[0];
    for (JSONObject order : db.orders) {
      if (order != null) {
        if (area.contains(order.getString("area"))) {
          ret = (JSONObject[]) append(ret, order);
        }
      }
    }
    return ret;
  }
  //get Orders By Area and status = available
  JSONObject[] getOrdersByAreaAndStatus(String area) {
    JSONObject[] ret = new JSONObject[0];
    for (JSONObject order : db.orders) {
      if (order != null) {
        if (area.contains(order.getString("area"))) {
          println("1111"+order.getString("book_status"));
          if (order.getString("book_status").equals("available")) {
          ret = (JSONObject[]) append(ret, order);
          }
        }
      }
    }
    return ret;
  }
  
  // get Order By book ID
  JSONObject getOrderByID(String id) {
    JSONObject ret = new JSONObject();
    for (JSONObject order : db.orders) {
      if (order != null) {
        if (id.contains(order.getString("book_id"))) {
          ret = order;
        }
      }
    }
    return ret;
  }
  // save order to database
  void saveOrdertoDB(JSONObject order) {
    if (order == null) {
      return;
    } else {
      saveJSONObject(order, "data/" + order.getString("book_id") + ".json");
    }
  }
  // update Order Status
  void updateOrderStatus(String id, String newstatus) {
    JSONObject[] ret = new JSONObject[db.max_orders()];

    JSONObject order = getOrderByID(id);
    // key, value
    order.setString("book_status", newstatus);
    client.publish(MQTT_topic, order.toString());
  }
}
