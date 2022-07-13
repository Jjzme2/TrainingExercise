var errors = [];
var submitBtn =  document.getElementById("submit");
var pageTitle = document.getElementById("page-title");
var errTxt = document.getElementById("error-text");
var path = window.location.pathname;
var myForm = document.forms["myForm"];


window.onload = function(){
    pageTitle.innerHTML = path.replace("/", "").replace(".cfm", "").toCamel();
}

if(!submitBtn){}
else{submitBtn.addEventListener("click", function(e) {
    console.log("clicked on " + submitBtn.parentElement.name +"!");
})}

// submitBtn.addEventListener("mouseover", function(e){
//     submitBtn.value ="Ahh!";
// })

// submitBtn.addEventListener("mouseout", function(e){
//     submitBtn.value ="Whew!";
// })

if(!myForm){}
else{myForm.addEventListener("submit", function(evnt){
    errors = [];
    evnt.preventDefault();
    validateForm();
})}


function validateForm() {
   let fname = {field: document.forms["myForm"]["fname"], user:" First Name"}
   let lName = {field: document.forms["myForm"]["lname"], user:" Last Name"}
   let suffix = {field: document.forms["myForm"]["suffix"], user:" Suffix"}
   let username = {field: document.forms["myForm"]["username"], user:" User Name"}
   let pass = {field: document.forms["myForm"]["pass"], user:" Password"}
   let confPass = {field: document.forms["myForm"]["confPass"], user:" Confirm Password"}
   let streetNum = {field: document.forms["myForm"]["streetNum"], user:" Street Number"}
   let street = {field: document.forms["myForm"]["street"], user:" Street"}
   let email = {field: document.forms["myForm"]["email"], user:" Email"}
   let zip = {field: document.forms["myForm"]["zip"], user:" Zip Code"}
   let city = {field: document.forms["myForm"]["city"], user: " City"}
   let state = {field: document.forms["myForm"]["state"], user: " State"}


    CheckEmpty([fname, lName, suffix, username, pass, confPass, street, email, streetNum, zip, state]);
    CheckNumber([fname, lName, city]);
    CheckLength([pass, confPass], 8);
    CheckLetters([streetNum, zip]);
    CheckEmail([email]);

    CheckMatching(pass, confPass);

//    alert(errors.length + " error Count");
   if(errors.length > 0){DisplayErrors();}
   else{AllowPass();}
}


//Checks

function CheckEmpty(_string){
    _string.forEach(element => {
        //Check if numbers or letters.
        element.field.value.isEmpty()?SendErrorMessage(element.user + " must be filled out.", element.field):null;
        // element.isZero()?SendErrorMessage("Numerics can not be 0."):null;
    });
}

function CheckNumber(_string){
    _string.forEach(element => {
        element.field.value.hasNumber()?SendErrorMessage(element.user + " can not contain numerics.", element.field):null;
    });
}

function CheckLength(_string, minLength){
    _string.forEach(element => {
        !element.field.value.meetsLengthReq(minLength)?SendErrorMessage("Confirm that your " + element.user +  " meets minimum length requirements.(" + minLength + ")"):null;
    });
}

function CheckLetters(_string){
    _string.forEach(element => {
        element.field.value.hasLetter()?SendErrorMessage(element.user + " can not contain alphabetic characters.", element.field):null;
    });
}

function CheckEmail(_string){
    _string.forEach(element => {
        !element.field.value.validEmail()?SendErrorMessage(element.user + " does not meet standard email formatting.", element.field):null;
    });
}


function CheckMatching(_string1, _string2){
    !_string1.field.value.matches(_string2.field.value)?SendErrorMessage(_string1.user + " and " + _string2.user + " do not match."):null;
}


function SendErrorMessage(err){
    errors.push(err);
}

function DisplayErrors(){
    errTxt.innerHTML = errors.toString().replaceAll(',', '<br>');
    errTxt.hidden = false;
    window.scrollTo(0,0);
}

function AllowPass(){
    errTxt.innerHTML = "";
    errTxt.hidden = true;
    alert("Good Form");
}


//Not Needed, just a fun way to get url vars.
function getUrlVars() {
    var vars = {};
    var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(m,key,value) {
        vars[key] = value;
    });
    return vars;
}