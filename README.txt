COMP3005 Term Project:  Health and Fitness Monitoring App
Name: Argyle Tad-y
Student No. 101145909

Note: I did explain this in my video but since the spec change this is only partially done.


How to Run:
Prerequisites: 
PostgreSQL installed on system: https://www.postgresql.org/download/
Node and NPM: https://nodejs.org/en/download

(1) Create the 'T4' database in PostgreSQL
    Run the DDL.sql File
    Run the insertInitData.sql File (you may want to watch the video first as they need to be done in order)

(2) In the 'postgres-node' folder, within a terminal, type the command 'npm ci'. Then after, run the command 'node server.js'.
Then open http://127.0.0.1:3000/ on any browser.

Important Files / Directory:
- DDL.sql: creates table based on given schema
- insertInitData.sql: inserts initial data, as well as test queries I wrote
- server.js: the serverside code; this is what actually connects to the PostgreSQL database and queries it 
- resources:
-- app.js: client side code that sends requests to server and displays results onto DOM
-- app.css: client side styling
-- app.html: client side html page


Video:
Google Drive URL: https://drive.google.com/file/d/1YIYbmfP4-VhW2vvPGZZAvP69ySFTIZ76/view?usp=sharing
Vimeo URL: https://vimeo.com/893244602?share=copy


Resources Used / Citations:
Youtube Video: https://www.youtube.com/watch?v=O4bNwkC1ZxA
Node article: https://node-postgres.com/features/queries
