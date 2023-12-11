const { query } = require('express');
const path = require('path');
const http = require("http");
const fs = require("fs");

const resourcesPathString = "../postgres-node/resources/";

require('dotenv').config({
    override: true,
    path: path.join(__dirname, 'development.env')
});

const {Pool, Client} = require('pg');

const pool = new Pool({
    user: process.env.USER,
    host: process.env.HOST,
    database: process.env.DATABASE,
    password: process.env.PASSWORD,
    port: process.env.PORT
});


const server = http.createServer(function (request, response) {
	console.log(request.url);
	let receivedData = "";

	request.on("data", function(chunk) {
		receivedData += chunk
	});
	request.on("end", function() {

		if(request.method === "GET"){
			if(request.url === "/"){
				fs.readFile(resourcesPathString + "app.html", function(err, data){
					if(err){
						console.log(err);
						response.statusCode = 500;
						response.write("Server error.");
						response.end();
						return;
					}
					response.statusCode = 200;
					response.setHeader("Content-Type", "text/html");
					response.write(data);
					response.end();
				});
			}else if((request.url).includes("/member") && !(request.url == "/member/app.css")&& !(request.url == "/member/app.js")){
				fs.readFile(resourcesPathString + "members.html", function(err, data){
					if(err){
						console.log(err);
						response.statusCode = 500;
						response.write("Server error.");
						response.end();
						return;
					}
					response.statusCode = 200;
					response.setHeader("Content-Type", "text/html");
					response.write(data);
					response.end();
				});
			}else if((request.url).includes("/fitnessGoals")){
				let thisUser = (request.url).slice(14);
				(async () => {
					const client = await pool.connect();
					try {
						const qStr = {
							text: 'SELECT * FROM fitnessgoals WHERE username = $1',
							values: [thisUser],
							rowMode: 'array',
						  }	
						const {rows} = await client.query(qStr);
						console.log(rows);
						resultRows = rows;
						response.statusCode = 200;
						response.setHeader("Content-Type", "application/json");
						response.end(JSON.stringify(resultRows));
					return;
				
					} catch (err) {
						console.error(err);
					} finally {
						client.release();
					}
				})();
			}else if((request.url).includes("/healthMetrics")){
				let thisUser = (request.url).slice(15);
				(async () => {
					const client = await pool.connect();
					try {
						const qStr = {
							text: 'SELECT * FROM healthmetrics WHERE username = $1',
							values: [thisUser],
							rowMode: 'array',
						  }	
						const {rows} = await client.query(qStr);
						console.log(rows);
						resultRows = rows;
						response.statusCode = 200;
						response.setHeader("Content-Type", "application/json");
						response.end(JSON.stringify(resultRows));
					return;
				
					} catch (err) {
						console.error(err);
					} finally {
						client.release();
					}
				})();
			}else if((request.url).includes('/trainer') && !(request.url == "/trainer/app.css")&& !(request.url == "/trainer/app.js")){
				fs.readFile(resourcesPathString + "trainers.html", function(err, data){
					if(err){
						console.log(err);
						response.statusCode = 500;
						response.write("Server error.");
						response.end();
						return;
					}
					response.statusCode = 200;
					response.setHeader("Content-Type", "text/html");
					response.write(data);
					response.end();
				});
			}else if((request.url).includes('/admin') && !(request.url == "/admin/app.css")&& !(request.url == "/admin/app.js")){
				fs.readFile(resourcesPathString + "admin.html", function(err, data){
					if(err){
						console.log(err);
						response.statusCode = 500;
						response.write("Server error.");
						response.end();
						return;
					}
					response.statusCode = 200;
					response.setHeader("Content-Type", "text/html");
					response.write(data);
					response.end();
				});
			}else if(request.url === "/app.js" || request.url === "/member/app.js"|| request.url === "/trainer/app.js" || request.url === "/admin/app.js"){
				fs.readFile(resourcesPathString + "app.js", function(err, data){
					if(err){
						response.statusCode = 500;
						response.write("Server error.");
						response.end();
						return;
					}
					response.statusCode = 200;
					response.setHeader("Content-Type", "application/javascript");
					response.write(data);
					response.end();
				});

			// GET: styling
			}else if(request.url === "/app.css" || request.url === "/member/app.css" || request.url === "/trainer/app.css" || request.url === "/admin/app.css"){
				fs.readFile(resourcesPathString + "app.css", function(err, data){
					if(err){
						response.statusCode = 500;
						response.write("Server error.");
						response.end();
						return;
					}
					response.statusCode = 200;
					response.setHeader("Content-Type", "text/css");
					response.write(data);
					response.end();
				});
			}else{
				response.statusCode = 404;
				response.write("Unknwn resource.");
				response.end();
			}

		} else if(request.method === "POST"){
			if(request.url === "/login"){
				(async () => {
					const client = await pool.connect();
					try {
						const {rows} = await client.query('SELECT * FROM useraccounts');
						console.log(rows);
						resultRows = rows;
						response.statusCode = 200;
						response.setHeader("Content-Type", "application/json");
						response.end(JSON.stringify(resultRows));
					return;
				
					} catch (err) {
						console.error(err);
					} finally {
						client.release();
					}
				})();
			}
		} 

	});

});



//Server listens on port 3000
server.listen(3000);
console.log('Server running at http://127.0.0.1:3000/');


