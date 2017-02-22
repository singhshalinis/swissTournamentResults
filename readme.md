Tournament Results
==================

What is it? (Functionality)
---------------------------
This project is a Python module that uses the PostgreSQL database to keep track of players and matches in a game tournament.
The game tournament uses the Swiss system for pairing up players in each round: players are not eliminated, and each player should be paired with another player with the same number of wins, or as close as possible. This project has two parts: defining the database schema (SQL table definitions), and writing the code that will use it.


Last Update Date
-----------------
22 February, 2017


System-specific Notes
----------------------
*   Developed on Python 2.7
*   PostgreSQL is used to persist data


Package Details (Files involved)
--------------------------------
Below is a brief description of the folders/files that have been used for this project.
1.  tournament.sql: It contains the psql and SQL commands to setup the database environment.
2.  tournament.py: It contains the python code that uses the underlying database objects for this project.
3.  tournament_test.py: It contains the test cases to be run on the code.


How to run
------------
1. Setup the database environment
    Connect to psql environment and execute below command:
    \i tournament.sql
    
2. Run the test cases from tournament_test.py
    On the virtual machine, run below command (assuming python is installed on that system)
    ./tournament_test.py
    

Known Issues/Assumptions
-------------------------
1.  It is assumed that there are even number of players for the tournament.


References, Credits & Acknowledgements
---------------------------------------
1.  https://www.postgresql.org/docs

2.  https://docs.python.org

3.  http://stackoverflow.com/

4.  Validators - http://pep8online.com/	- For Python

Contact Information
--------------------
For any comments, queries, issues, and bugs, please contact singhshalinis@gmail.com.