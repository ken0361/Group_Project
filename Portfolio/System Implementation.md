# System Implementation

**contents**
- [Breakdown of project into sprints](#breakdown-of-project-into-sprints)
- [Evaluation designs](#evaluation-designs)
- [Social and Ethical Implications](#social-and-ethical-implications)


## Breakdown of project into sprints
### Sprint1

In sprint1 our group create a original idea about the whole library system, design the UI of each system, draw a paper prototypes to help to develop the following several sprints. At this stage we achieve several goals:

- Target the users’ requirements and build a clear structure and function of the system.
- Reach a consensus on the basic UI ,design our logo and create our version1 paper prototypes.
- Gather the feedback from volunteers based on the Wizard of Oz techniques to improve our UI and create our version2 prototypes
- Discuss the which system the M5stack can be applied in to make sure the system can work efficiently.

Sprint1 was mainly focused on the abstract design. We decide the purpose of our system is helping students who have difficulties in looking for the details and location of books quicker. Structure was built but there are little specific functions added to the framework. After inviting the volunteers who are unfamiliar with our system to test whether out idea is feasible, we had a group meeting to improve the UI by adding sign up function and auto notifying function to the web. Meanwhile, we design a logo “glasses” as our logo on M5stack to make our product more impressive. Considering that it is unrealistic for each student to hold an M5 stack and the administrators can complete their task only by computer, we came to the decision that librarian is the best choice to hold the M5stack so that they can scan the barcode of each book.

### Sprint2

After solving the basic design problem, in sprint2, our group focused on implementation of the communication circle between 3 systems and database. At this stage we achieved following goals:

- Decide MQTT as our communication protocol of each section
- Decide the detailed data and the direction of data transferring via MQTT
- Test and simplify the form of data transferring and storage

Sprint2 mainly focused on solving the communication bug and optimize the logical system settled in sprint1. For the Desktop system, according to the volunteers experience, it is vital to store the data which represents location, changing book status and the statistic of available/unavailable books by generating classes and objects. Our initial transfer plan between web and desktop is (  ), after testing, we simplify this process to (  ) in order to improve the efficiency.(其他方向如果有改进也可以简单写一下你们讨论的过程，例如如何把database简化掉的)

### Sprint3

In sprint3 our group optimized and integrated the final version of 3 systems also the UI was slightly changed according to the volunteer‘s advice. At this stage we achieved following goals:

- Implement server.js
- Change the color of book information display on M5stack to make it elegant
- Final test without bugs

(implement server.js 需要web的同学写两三句做的过程)

After implementing server.js, most work of our system were completed, these 3 subsystems were used by 3 different volunteers to observe whether the whole system could work as we expected. We collected the feedback and decided to make slight change on M5stack display. We use red box represents book id, blued box represents booked person id，green box represents book position, instead of three white boxes. With our final test running without bugs, the library management system is finished.

    

## Evaluation designs
    technique：Wizard of Oz
    用户调查
    lockdown限制
    （剩下的limitation可能需要大家一起想一下）
    （SWOt分析如果有时间我就做一下）

## Social and Ethical Implications
    关于用户调查和用户隐私方面 做了什么保证用户隐私 数据不被泄露
    对于不使用这个系统的其他同学会不会造成损失
    图书的预定会不会产生冲突
