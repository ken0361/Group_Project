# System Implementation

**contents**
- [Breakdown of project into sprints](#breakdown-of-project-into-sprints)
- [Evaluation designs](#evaluation-designs)
- [Social and Ethical Implications](#social-and-ethical-implications)


## Breakdown of project into sprints
### Sprint1

In sprint1, our group create an original idea about the whole library system, design the UI of each system, draw a paper prototype to help to develop the following several sprints. At this stage, we achieve several goals:

- Target the users’ requirements and build a clear structure and function of the system.
- Reach a consensus on the basic UI, design our logo and create our version1 paper prototypes.
- Gather the feedback from volunteers based on the Wizard of Oz techniques to improve our UI and create our version2 prototypes
- Discuss which system the M5stack can be applied in to make sure the system can work efficiently.

Sprint1 was largely focused on abstract design. We decide the purpose of our system is helping students who have difficulties in looking for the details and location of books quicker. The structure was built, but there are little specific functions added to the framework. After inviting the volunteers who are unfamiliar with our system to test whether our idea is feasible, we had a group meeting to improve the UI by adding a sign-up function and auto notifying function to the web. Meanwhile, we design a logo “glasses” as our logo on M5stack to make our product more impressive. Considering that it is unrealistic for each student to hold an M5 stack and the administrators can complete their task only by computer, we came to the decision that librarian is the best choice to hold the M5stack so that they can scan the barcode of each book.

### Sprint2

After solving the basic design problem, in sprint2, our group concentrated on the implementation of the communication circle between 3 systems and database. At this stage, we achieved the following goals:

- Decide MQTT as our communication protocol of each section
- Decide the detailed data and the direction of data transferring via MQTT
- Test and simplify the form of data transferring and storage

Sprint2 mainly focused on solving the communication bug and optimize the logical system settled in sprint1. For the Desktop system, according to the volunteer's experience, it is vital to store the data which represents location, changing book status and the statistic of available/unavailable books by generating classes and objects. Our initial transfer plan between web and desktop is using one more JSON item to represent the book status (reserved or not), after testing, we simplify this process to add this information in user ID in order to improve the efficiency. Apart from that, we tried to solve this problem by passing the "null" information. The web application could send the empty string directly instead of "null", and the desktop side could simply use it in the JSON message.



### Sprint3

In sprint3, our group optimized and integrated the final version of 3 systems; also, the UI was slightly changed according to the volunteer‘s advice. At this stage we achieved following goals:

- Implement server.js
- Change the colour of book information display on M5stack to make it elegant
- Final test without bugs

As we mentioned in the web applications part, we used Node.js to build a local web server and use the port 3000 as our localhost. After implementing server.js, most works of our system were completed, then three subsystems were used by three different volunteers to observe whether the whole system could work as we expected. We collected the feedback and decided to make a slight change on M5stack display. We use red box represents book id, the blue box represents booked person id，green box represents book position, instead of three white boxes. With our final test running without bugs, the library management system is finished.

    

## Evaluation designs
The first evaluation technique was Wizard of Oz, which we conducted during workshops. This technique enabled us to observe how users would interact with this product by using role-playing. This helped us gather feedback and reaction easily and quickly so that we can apply this information to improve our paper prototype. The role players pointed out several shortcomings of our initial product model, which provide us with a wide range of ideas to perfect our structure. However, all the participants are peers, and the feedback can be affected by personal emotion, which means they may be more tolerable to some of our disadvantages compared to strangers.

We also turn to our tutors for advice when creating our system idea, using their comment toward our system as one of the criteria to judge our product. Unlike peer’s review, tutors’ advice tends to be more professional, which save us amount of time in solving some severe problems. Nevertheless, this kind of suggestions only gave us the direction to modify our system, and if we want to more specific details, we must combine with more users’ feedback.

On account of the factors mentioned above, user testing is necessary for the improvement of our product. Depend on the samples we gather at the beginning of our project, and we worked well to build the original system. Nevertheless, due to the lockdown in March, we were unable to collect more subjects and forced to develop our rest part of the system based on the previous data. Though our flatmates were willing to help us to test the system, the feedbacks were still limited. 




## Social and Ethical Implications
As for the ethic of our project research, we referred to the ethic form offered by the university to make sure our study is not against the guideline. Before the research, there would be an initial explanation of the study and an opportunity to ask questions. After that, the participants would be asked for consent. If they had any questions during our research, we would answer them until they figured out.
There are no potential risks to our participant during all procedures. We would not ask for their personal information so their privacy would be protected. The device used in research is M5stack, smartphone and desktop, which would not be harmful to people’s physical and psychological health.
In terms of personal feedback and reaction, all information will be recorded confidentially and only be used in a research report. 

Though our product is not fully finished yet, the data of student account and the book they borrow should be protected considering future development. We could add a statement before the user sign up that we would only use their account information in the library system and the details of their personal information can only be stored by the university and the user have opportunity whether to give the consent to our system.

In terms of social issues, our product aims to help the student find books more efficiently and avoid them wasting more time to find the location of the book among hundreds of bookshelves. It is designed based on the university library system, which means even though some students do not use our product, the system would still provide the information they need. Besides, even the books are not borrowed via our system, the book status in the administrator database can also be updated instantly, so there would not be a conflict that two students reserve the same book. 
