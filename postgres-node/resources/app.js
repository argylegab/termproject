
let thisResponse;
let foundRow;
let currAccountType;
let currUser;

function findFromRows(key1, val1, row){
	console.log(row);
	for(let i = 0; i < row.length; i++){
		if((row[i])[key1] == val1){
			return row[i];
		}
	}
}

function getFitnessGoals(){
	let req = new XMLHttpRequest();
	req.onreadystatechange = function() {
		if(this.readyState==4 && this.status==200){ 
			response_text = JSON.parse(req.responseText);
			console.log(this.responseText);
			
			let newText = "";
			for(let i = 0; i < (response_text).length; i++){
				newText += '<h5>' + response_text[i][1] + '</h5>';
				newText += '<h6>' + response_text[i][2] + '</h6>';
				newText += '<h6>' + 'Date Begun: ' + response_text[i][3] + '<h6>';
				newText += '<h6>' + 'Date Ending: ' + response_text[i][4] + '<h6>';
			}

			document.getElementById("fitnessGoals").innerHTML = newText;
		}
	}
	req.open("GET", `/fitnessGoals/${currUser}`);
	req.setRequestHeader("Content-Type", "application/json");
	req.send();
}

function getHealthMetrics(){
	let req = new XMLHttpRequest();
	req.onreadystatechange = function() {
		if(this.readyState==4 && this.status==200){ 
			response_text = JSON.parse(req.responseText);
			console.log(this.responseText);
			
			let newText = "";
			for(let i = 0; i < (response_text).length; i++){
				console.log(response_text[i]);
				if(response_text[i][1] == 1){
					newText += '<h6>' + 'Sleep' + '</h6>';
					newText += '<h7>' + response_text[i][2] + ' hours on ' + (response_text[i][3]).slice(0, 9) + '</h7>';
				}else {
					newText += '<h6>' + 'Mental Wellbeing' + '</h6>';
					newText += '<h7>' + response_text[i][2] + ' on a scale of 1-10 on ' + (response_text[i][3]).slice(0, 9) + '</h7>';
				}
			}

			document.getElementById("healthMetrics").innerHTML = newText;
		}
	}
	req.open("GET", `/healthMetrics/${currUser}`);
	req.setRequestHeader("Content-Type", "application/json");
	req.send();
}

function populateMemberDashboard(){
	getFitnessGoals();
	getHealthMetrics();
}

function login(username, password){ // this is how we'd login
	reqObj = {
				'username': username,
				'password': password
			}

	let req = new XMLHttpRequest();
	req.onreadystatechange = function() {
		if(this.readyState==4 && this.status==200){ 
			response_text = JSON.parse(req.responseText);
			console.log(this.responseText);
			foundRow = findFromRows("username", username, response_text);
			if(foundRow != undefined){
				if(foundRow["password"] == password){
					currUser = username;
					currAccountType = foundRow["accounttype"];
					if(currAccountType == 1){
						window.location.href = `/member/${currUser}`;
					}
					else if(currAccountType == 2){
						window.location.href = `/trainer/${currUser}`;
					}
					else{
						window.location.href = `/admin/${currUser}`;
					}
				}
				else{
					alert("That password does not match the one we have for that username.");
				}
			}
		}
	}
	req.open("POST", `/login`);
	req.setRequestHeader("Content-Type", "application/json");
	console.log(reqObj);
	req.send(JSON.stringify(reqObj));
}

function initEventListeners(){
	const loginBtn = document.getElementById("login");
	loginBtn.addEventListener("click", function() {
		login(document.getElementById("user").value,
		document.getElementById("pwd").value);
	});
	
}


window.addEventListener('DOMContentLoaded', () => {
    if(window.location.href == 'http://localhost:3000/'){
		initEventListeners();
	}else if((window.location.href).includes('http://localhost:3000/member/')){
		currUser = (window.location.href).slice(29);
		populateMemberDashboard();
	}
});
