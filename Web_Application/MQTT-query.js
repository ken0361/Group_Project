// Create a client instance, we create a random id so the broker will allow multiple sessions
client_query = new Paho.MQTT.Client("broker.mqttdashboard.com", 8000, "clientId" + makeid(3) );
var queryTopic = "test_Bookquery";
var bookingTopic = "test_response_to_WEB";

// set callback handlers
client_query.onConnectionLost = onConnectionLost;
client_query.onMessageArrived = onMessageArrived;

// connect the client
client_query.connect({onSuccess:onConnect});

// called when the client loses its connection
function onConnectionLost(responseObject) {
    if (responseObject.errorCode !== 0) {
        console.log("onConnectionLost:"+responseObject.errorMessage);
    }
}

// called when a message arrives
function onMessageArrived(message) {
    console.log("onMessageArrived:"+message.payloadString);
}

// called when the client connects
function onConnect() {
    // Once a connection has been made report.
    console.log("Connected");
}

function queryBookOrder() {
    var x = document.getElementById("queryForm");
    var text = "";

    var newOrder = {
        query_id: "Q" + makeQueryid(7),
        user_id:  "stu" + makeQueryid(6),
        book_name:    x.elements[0].value,
        author_name:  x.elements[1].value,
        book_status:  "null"
    };

    onSubmit(JSON.stringify(newOrder));
    console.log(client_query);
  }

// called when the client connects
function onSubmit(payload) {
    // Once a connection has been made, make a subscription and send a message.
    console.log("onSubmit");
    // client_query.subscribe(bookingTopic);
    client_query.subscribe(bookingTopic);
    message = new Paho.MQTT.Message(payload);
    message.destinationName = queryTopic;
    client_query.send(message);
  }

  
// called to generate the Client IDs
function makeid(length) {
    var result           = '';
    var characters       = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    var charactersLength = characters.length;
    for ( var i = 0; i < length; i++ ) {
        result += characters.charAt(Math.floor(Math.random() * charactersLength));
    }
    return result;
}

// called to generate the IDs
function makeQueryid(length) {
    var result           = '';
    var characters       = '0123456789';
    var charactersLength = characters.length;
    for ( var i = 0; i < length; i++ ) {
        result += characters.charAt(Math.floor(Math.random() * charactersLength));
    }
    return result;
}

// function updateTable(payload){
//     var tr;
//     tr = $('<tr/>');
//     tr.append("<td>" + json[0].order_id + "</td>");
//     tr.append("<td>" + json[1].status + "</td>");
//     tr.append("<td>" + json[4].delivery_address + "</td>");
//     $('table').append(tr);
// }

// 
client_query.onMessageArrived = function (message) {
    //Do something with the push message you received
$('#messages').append(message.payloadString);
    var data = JSON.parse(message.payloadString);
    // Find a <table> element with id="myTable":
    var table = document.getElementById("table");
    // Create an empty <tr> element and add it to the last position of the table:
    var row = table.insertRow();
    // Insert new cells (<td> elements) at the 1st and 2nd position of the "new" <tr> element:
    var book_id = row.insertCell(0);
    var book_name = row.insertCell(1);
    var author_name = row.insertCell(2);
    var book_status = row.insertCell(3);
    // Add some text to the new cells:
    book_id.innerHTML = data.book_id;
    book_name.innerHTML = data.book_name;
    author_name.innerHTML = data.author_name;
    book_status.innerHTML = data.book_status;
};
        
