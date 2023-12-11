CREATE TABLE UserAccounts( 
username text PRIMARY KEY,
password text NOT NULL,
firstName text NOT NULL,
lastName text NOT NULL UNIQUE,
accountType int
);

CREATE TABLE Members( 
username text PRIMARY KEY REFERENCES UserAccounts (username)
);

CREATE TABLE Trainers( 
username text PRIMARY KEY REFERENCES UserAccounts(username)
);

CREATE TABLE Admin( 
username text PRIMARY KEY REFERENCES UserAccounts(username),
manageBillings boolean NOT NULL,
manageRooms boolean NOT NULL
);

CREATE TABLE Billings( 
billID SERIAL PRIMARY KEY,
username text NOT NULL REFERENCES Members(username),
billItemName text NOT NULL,
dateDue date NOT NULL,
amount NUMERIC(6, 2) NOT NULL,
paid boolean NOT NULL
);

CREATE TABLE Rooms( 
roomName text PRIMARY KEY,
bookable boolean NOT NULL
);

CREATE TABLE FitnessGoals( 
fitnessGoalID SERIAL PRIMARY KEY,
fitnessGoalName VARCHAR(10) NOT NULL,
fitnessGoalDescription text NOT NULL,
percentage int NOT NULL,
dateStarted date NOT NULL,
dateDone date NOT NULL,
username text NOT NULL REFERENCES Members(username)
);

CREATE TABLE HealthMetricTypes( 
healthMetricType SERIAL PRIMARY KEY,
minValue int NOT NULL,
maxValue int NOT NULL,
healthMetricName text NOT NULL
);

CREATE TABLE HealthMetrics( 
healthMetricID SERIAL PRIMARY KEY,
healthMetricType int NOT NULL  REFERENCES HealthMetricTypes(healthMetricType),
healthMetricValue int NOT NULL,
healthMetricDate date NOT NULL,
username text NOT NULL REFERENCES Members(username)
);


CREATE TABLE ExerciseRoutines( 
exerciseRoutineID SERIAL PRIMARY KEY,
username text NOT NULL REFERENCES Members(username)
);

CREATE TABLE Exercises( 
exerciseRoutineID int NOT NULL REFERENCES ExerciseRoutines(exerciseRoutineID),
exerciseID int NOT NULL,
exerciseDescription text NOT NULL,
reps int NOT NULL,
exerciseSets int NOT NULL,
PRIMARY KEY (exerciseRoutineID, exerciseID)
);

CREATE TABLE TrainerGroups( 
memberID text NOT NULL REFERENCES Members(username),
trainerID text NOT NULL REFERENCES Trainers(username),
PRIMARY KEY (memberID)
);

CREATE TABLE Events( 
eventID SERIAL PRIMARY KEY,
eventType int NOT NULL,
eventTime time NOT NULL,
eventDate date NOT NULL,
roomName text NOT NULL REFERENCES Rooms(roomName)
);

CREATE TABLE Sessions( 
eventID int REFERENCES Events(eventID),
trainerID text NOT NULL REFERENCES Trainers(username),
memberID text NOT NULL REFERENCES Members(username),
notes text NOT NULL,
PRIMARY KEY (eventID)
);


CREATE TABLE GroupEvents( 
eventID int NOT NULL REFERENCES Events(eventID),
groupEventDescription text NOT NULL,
maxPersons int NOT NULL,
PRIMARY KEY (eventID)
);

CREATE TABLE GroupEventsRegistrants( 
eventID int NOT NULL REFERENCES Events(eventID),
memberID text NOT NULL REFERENCES Members(username),
PRIMARY KEY (eventID, memberID)
);
