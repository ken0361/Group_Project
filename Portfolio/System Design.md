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
   
## User stories
    分别描述三端用户可能产生的情况
   
## The evolution of UI Wireframes
    UI的改良（但是我们没有用户反馈得编了TT）
   
## Communication Protocols
    MQTT
    简单描述 画个图字就可以少写点
We choose to use MQTT as our communication protocol because MQTT is a machine-to-machine (M2M)/"Internet of Things"  connectivity protocol. It was designed as an extremely lightweight publish/subscribe messaging transport. It is useful for connections with remote locations where a small code footprint is required and/or network bandwidth is at a premium. 

Our system requires multiple communications in different directions between different devices. Due to the complex communication design of our system, we decided to use multiple different subscriptions in order to clearly publish which messages to which application as following:



   
## Data persistence mechanisms
    如何储存数据
   
## Web Technologies
    写网页用的技术和为什么选择
