// Data focused on reading, writing and preparing data
static abstract class Status {
  static final String[] LIST = {
    Status.AVAILABLE, 
    Status.BORROWED, 
    Status.EXCEPTIONAL, 
    Status.RESERVED,
  };
  static final String AVAILABLE = "available";
  static final String BORROWED = "borrowed";
  static final String EXCEPTIONAL = "exceptional";
  static final String RESERVED = "reserved";
}

static abstract class Area {
  static final String[] LIST = {
    Area.A, 
    Area.B, 
    Area.C, 
    Area.D, 
    
  };
  static final String A = "A";
  static final String B = "B";
  static final String C = "C";
  static final String D = "D";
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
          //println("1111"+order.getString("book_status"));
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
  void saveBooktoDB(JSONObject order) {
    if (order == null) {
      return;
    } else {
      saveJSONObject(order, "data/" + order.getString("book_id") + ".json");
    }
  }
  
  // update Order Status
  void updateBookStatus(String id, String newstatus) {
    JSONObject target = getOrderByID(id);
    JSONObject newFile = new JSONObject();

    newFile.setString("book_id",id);
    newFile.setString("book_name",target.getString("book_name"));
    newFile.setString("author_name",target.getString("author_name"));
    newFile.setString("book_status",newstatus);
    newFile.setString("booked",target.getString("booked"));
    newFile.setString("last_borrowed_time",target.getString("last_borrowed_time"));
    newFile.setString("last_return_time",target.getString("last_return_time"));
    newFile.setString("last_warehouse-in_time",target.getString("last_warehouse-in_time"));
    newFile.setString("area",target.getString("area"));
    newFile.setString("position",target.getString("position"));
 
    saveBooktoDB(newFile);
    // key, value
    client.publish(MQTT_topic_send, newFile.toString());//just publish status
  }
}
