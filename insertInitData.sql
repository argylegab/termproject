delete from admin;
delete from billings;
delete from exerciseroutines;
delete from exercises;
delete from fitnessgoals;
delete from groupevents;
delete from groupeventsregistrants;
delete from healthmetrics;
delete from healthmetrictypes;
delete from members;
delete from rooms;
delete from sessions;
delete from trainergroups;
delete from trainers;
delete from useraccounts;

-- (1) let's create the rooms
INSERT INTO rooms (roomName, bookable) VALUES
('1A', TRUE),
('1B', TRUE),
('1C', TRUE),
('2A', TRUE),
('2B', TRUE),
('2C', FALSE),
('3A', TRUE),
('3B', TRUE),
('3C', TRUE);

--  (2) let's create 3 members

INSERT INTO useraccounts (username, password, firstname, lastname, accounttype) VALUES
('buttercupd','123','Buttercup', 'Doe', 1),
('blossoms','456','Blossom', 'Smith', 1),
('bubblesb','789','Bubbles', 'Beam', 1);

INSERT INTO members (username) VALUES
('buttercupd'),
('blossoms'),
('bubblesb');

-- (3) let's create a trainer and an admin that has both billing and room management privilleges

INSERT INTO useraccounts (username, password, firstname, lastname, accounttype) VALUES
('mayakeane','111','Maya', 'Keane', 2);


INSERT INTO trainers (username) VALUES
('mayakeane');

INSERT INTO useraccounts (username, password, firstname, lastname, accounttype) VALUES
('alexadmin','222','Alex', 'Marsh', 3);

INSERT INTO admin (username, managebillings, managerooms) VALUES
('alexadmin', TRUE, TRUE)
-- {}

-- (4) let's add fitness goals for ButterCup Doe
INSERT INTO fitnessgoals (fitnessgoalname, fitnessgoaldescription, percentage, dateStarted, dateDone, username) VALUES
('5k', 'Train for 5k in March; run daily for 4 months', 5, '2023-12-01', '2024-03-01', 'buttercupd'),
('Deadlift', 'Deadlift more than body weight', 100, '2023-10-25', '2023-11-15', 'buttercupd');

-- (5) let's add a health metric type (this is something that would be done by admin)
INSERT INTO healthmetrictypes (minvalue, maxvalue, healthmetricname) VALUES
(0, 24, 'Nightly Sleep'),
(0, 10, 'Emotional Wellbeing');

------- you may need to change the health metric type below in all the health metric tuples to match the serialized PK of health metric types

-- (6) then let's give ButterCup Doe some health metric history
INSERT INTO healthmetrics (healthmetrictype, healthmetricvalue, healthmetricdate, username) VALUES
(1, 6, '2023-10-01', 'buttercupd'),
(1, 7, '2023-10-03', 'buttercupd'),
(1, 8, '2023-10-04', 'buttercupd'),
(1, 7, '2023-10-25', 'buttercupd'),
(1, 5, '2023-11-11', 'buttercupd'),
(1, 9, '2023-11-19', 'buttercupd'),
(1, 7, '2023-11-28', 'buttercupd'),
(2, 7, '2023-11-21', 'buttercupd'),
(2, 5, '2023-11-24', 'buttercupd'),
(2, 9, '2023-11-27', 'buttercupd'),
(2, 8, '2023-12-03', 'buttercupd');

-- (7) let's then set up some exercise routines for buttercup
INSERT INTO exerciseroutines (username) VALUES
('buttercupd');

-- (8) then the individual exercises

INSERT INTO exercises (exerciseroutineid, exerciseid, exercisedescription, reps, exercisesets) VALUES
(1, 1, 'Ab Abductor', 10, 3),
(1, 2, 'Crunches', 15, 3),
(1, 3, 'Bicycle Crunches', 20, 3),
(1, 4, 'Leg Lifts', 15, 4),
(1, 5, 'Wheel Rollout', 8, 5);

-- (9) let's assign ButterCup Doe a trainer
INSERT INTO trainergroups (memberid, trainerid) VALUES
('buttercupd', 'mayakeane');

-- (10) let's create an event and then a training session for Buttercup Doe
INSERT INTO events (eventtype, eventtime, eventdate, roomname) VALUES
(1, '13:30', '2023-12-16', '1A');

-- (11) then the session itself
INSERT INTO sessions (eventid, trainerid, memberid, notes) VALUES
(1, 'mayakeane', 'buttercupd', 'no notes yet');


-- (12) let's now bill ButterCup Doe for the session, and let's bill for the membership while we're here
INSERT INTO billings (username, billitemname, datedue, amount, paid) VALUES
('buttercupd', 'Membership Charge', '2023-12-01', 125.67, TRUE),
('buttercupd', 'PT Training Session with Maya Keane', '2024-01-16', 125.67, FALSE);

-- (13) we can also create an group event that all 3 current members can attend
INSERT INTO events (eventtype, eventtime, eventdate, roomname) VALUES
(2, '17:30', '2023-12-20', '2B');

-- (14) and then the individual group event
INSERT INTO groupevents (eventid, groupeventdescription, maxpersons) VALUES
(2, 'Holiday Cheer Cycling Workshop', 15);

-- (15) and then the reigistrants
INSERT INTO groupeventsregistrants (eventid, memberid) VALUES
(2, 'buttercupd'),
(2, 'blossoms'),
(2, 'bubblesb');


------------------ other test queries
-- (16) since we just registered some users to an event, let's pull up the list of attendees
SELECT * FROM groupeventsregistrants WHERE eventid = 2

-- what if a pipe burst in room 2B and the room for the workshop now needs to be move to another room?
-- (17) first let's check which rooms are bookable (not under construction or closed)
SELECT * FROM rooms where bookable = TRUE
-- (18) then let's switch the workshop's room to 1B
UPDATE events SET roomname = '1B' WHERE eventid = 2

-- (19) let's also try out querying Buttercup Doe's Bills
SELECT * FROM billings WHERE username = 'buttercupd'

-- (20) let's try to query one of Buttercup Doe's exercise routines
SELECT * FROM exercises WHERE exerciseroutineid = 1



