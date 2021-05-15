# VaccineDB

A database facilitating the management of the COVID vaccination distribution process in Quebec.

# Details 
A priority system ensures that registered Quebec residents are vaccinated accordingly to their risk group. The database stores information about registered users, nurses, doctors, hospitals, vaccines, the number of doses, pharmaceutical companies,  batches of vaccines received at a specific location as well as slots attributed at a specific time, date and location. The system allows to track down the nurse administating a shot, the shot, the registered person, time, date, and location.

# Notes
- The provided files are written in PostgresSQL;
- The **createtbl.sql** contains all the description of all the tables;
- The **droptbl.sql** allows to drop all created tables at once;
- The **loadata.sql** contains data to fill the database;
- VaccineApp.java is a user-friendly interface allowing one to interact with a database through a java application. The latter can **add a person, assign a slot, enter vaccination information, and exit the application**. It also addresses courner cases for each applicable operation. For instance, if one would like to assign a slot (i.e. register), the program prompts the user to type their personal information, and it then verifies if the user is registered, if they received all of their vaccines, and if they are not already registered. If one the latter cases fails, an error message displays explaining the next step. 
- The program design is simplified in certain aspects.


# Relational Diagram

![Relational Diagram](https://user-images.githubusercontent.com/35566602/118346060-d3a26a80-b506-11eb-81a8-66ef79fcd099.jpg)

