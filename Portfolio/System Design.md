# System Design

**Contents**

- [Architecture of the entire system](#architecture-of-the-entire-system)
- [The design of 3 key systems](#the-design-of-3-key-systems)
- [User stories](#user-stories)
- [The evolution of Wireframes](#the-evolution-of-UI-wireframes)
- [Communication Protocols](#communication-protocols)
- [Data persistence mechanisms](#data-persistence-mechanisms)
- [Web Technologies](#web-technologies)













## Architecture of the entire system  

![architecture](images/architecture.png)

The main purpose of this project is to build a simple library management system, with the functions of user query and reservation. Also, the librarian can update the status of the book in real time, and notify the user that the borrowed book is now available.

The following are the roles played by each character in this system:

User can register account, login, query and check the status of books or book them on the web page. Librarian can scan the code on book to receive the message from administrator by m5stack, and return the book to the right bookshelf or notify the user who has booked this book. Administrator can response the query from user, send message to m5stack, and use various functions of the library management system interface to display information such as book status and inventory.

Web page, M5stack, desktop connect and send query or response by MQTT.
    
## The design of 3 key systems
    详细描述三端 会用上代码和图
    
    
    
M5stack:

After m5stack is turned on, it will be able to:
(1)	display the theme and LOGO
(2)	connect to Wi-Fi and MQTT
(3)	scan the barcode of book
(4)	send book id to MQTT & receive the message from the desktop by MQTT
(5)	display the book information
(6)	decide whether to send the reminder according to the status of the book



(1)	display the theme and LOGO
![architecture](images/M5stack_1.jpg =250x250)
![architecture](images/M5stack_2.jpg =250x250)

The theme and logo are dynamically displayed on the screen through the use of delay function.

   
## User stories
    分别描述三端用户可能产生的情况
   
## The evolution of UI Wireframes
    UI的改良（但是我们没有用户反馈得编了TT）
   
## Communication Protocols
We use MQTT as our communication protocol because MQTT is a machine-to-machine (M2M)/"Internet of Things"  connectivity protocol. It was designed as an extremely lightweight publish/subscribe messaging transport. It is useful for connections with remote locations where a small code footprint is required and/or network bandwidth is at a premium. 

Our system requires multiple communications in different directions between different devices. Due to the complex communication design of our system, we decided to use multiple different subscriptions in order to clearly publish which messages to which application as following:

### (a) Desktop <——> web
**Web  —— query ——> Desktop** 

*Topic: "WEB_query"*
There are three different conditions when a user query a book information from desktop.
1. only use book_name to query;
2. only use author_name to query;
3. use book_name and author_name to query, e.g:
```
{
  "query_id": "00000001",
  "user_id": "stu190001",
  "book_name": "java",
  "author_name": "Andrew",
  "book_status": "null"
}
```

**Web  —— booking ——> Desktop** 

*Topic: "WEB_query"*
The booking request must include book_name and author_name, and the book_status would change to “booking”.
```
{
  "query_id": "00000001",
  "user_id": "stu190001",
  "book_name": "java",
  "author_name": "Andrew",
  "book_status": "booking"
}
```

**Desktop ——query_response——> web** 

*Topic: "response_to_WEB"*
If desktop could find the corresponding book, it would send the information to the web:
<img src="./images/response2web.png" width = "300" height = "230" alt="response2web" align=center />

Otherwise, the desktop would send { "book_name": "null" } to the web.

**Desktop ——booking_response——> web** 

*Topic: "response_to_WEB"*
If desktop could find the corresponding book and the status of the book is available, it would change the "book_status" to "booked" and set the value of “booked” is "user_id", then send the updating information to the web.

### (b) Desktop <——> M5 stack
**M5 stack —— query ——> Desktop** 

*Topic: "M5_query"*
M5 stack using book_id to query the information of the book.

**Desktop ——response——> M5 stack** 

*Topic: "topic："response_to_M5""*
M5 stack using book_id to query the information of the book.
<img src="./images/response2m5.png" width = "230" height = "180" alt="response2m5" align=center />

Otherwise, the desktop would send { "book_id": "null" } to the M5 stack.

### (c) M5 stack ——> Web

If the booked field in the desktop reply message received by M5 stack after scanning a book is not empty, M5 stack would send a prompt message with the topic of the current user_id to the Wed (a user). The user receives the reminder and knows he can go to borrow the book now.
   
## Data persistence mechanisms
    如何储存数据
   
## Web Technologies
    写网页用的技术和为什么选择
