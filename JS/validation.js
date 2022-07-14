var errors = [];
var submitBtn =  document.getElementById("submit");
var pageTitle = document.getElementById("page-title");
var errTxt = document.getElementById("error-text");
var path = window.location.pathname;
var myForm = document.forms["myForm"];


window.onload = function(){
    sessionStorage.setItem('key', 'value');
    if(errTxt){
        errTxt.textContent = sessionStorage.getItem("Errors").replaceAll(',', '\n');
    }
}


function validateForm(event) {
    var alertMsg ="";

        var fname = document.getElementById("fname");
        var email = document.getElementById("email");
        var lName = document.getElementById("lname");
        var username = document.getElementById("username");
        var pass = document.getElementById("pass");
        var confPass = document.getElementById("confPass");
        var streetNum = document.getElementById("streetNum");
        var street = document.getElementById("street");
        var zip = document.getElementById("zip");
        var city = document.getElementById("city");
        var state = document.getElementById("state");
        var fname = document.getElementById("fname");
        var suffix = document.getElementById("suffix");
        var company = document.getElementById("company");

        //RegEx
        var emailTest = /^[A-Z0-9._%+-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}$/i;
        var numberTest = /\d/;

            if(email.value == ""){
                alertMsg += "Email must have content.\n" ;
            }else if(!emailTest.test(email.value)){ alertMsg += "Email must meet standard Email format.\n"; }

            if(fname.value == ""){
                alertMsg += "First Name must have content.\n";
            }else if(numberTest.test(fname.value)){ alertMsg += "First name can not contain Numbers.\n"; }

            if(lName.value == ""){
                alertMsg += "Last Name must have content.\n";
            }else if(numberTest.test(lName.value)){ alertMsg += "Last name can not contain Numbers.\n"; }

            if(username.value == ""){
                alertMsg += "Username must have content.\n";
            }

            if(pass.value == ""){
                alertMsg += "Password must have content.\n";
            }else if(pass.value.length < 8){ alertMsg += "Password must meet minimum length requirements.\n"; }

            if(confPass.value == ""){
                alertMsg += "Password Confirmation must have content.\n";
            }else if(confPass.value.length < 8){ alertMsg += "Password Confirmation must meet minimum length requirements.\n"; }

            if(streetNum.value == ""){
                alertMsg += "Street Number must have content.\n";
            }else if(isNaN(streetNum.value)){ alertMsg += "Street Number must be a number.\n"; }

            if(zip.value == ""){
                alertMsg += "Zip Code must have content.\n";
            }else if(isNaN(zip.value)){ alertMsg += "Zip Code must be a number.\n"; }

            if(city.value == ""){
                alertMsg += "City must have content.\n";
            }else if(numberTest.test(city.value)){ alertMsg += "City name can not contain Numbers.\n"; }

            if(street.value == ""){
                alertMsg += "Street must have content.\n";
            }else if(numberTest.test(street.value)){ alertMsg += "Street name can not contain Numbers.\n"; }

            if(suffix.value == ""){
                alertMsg += "Suffix must have content.\n";
            }

            if(state.value == ""){
                alertMsg += "State must have content.\n";
            }

            if(company.value == 10){
                if(alertMsg == ""){
                    alert("Employee will be added to Employee pool since no Company is defined.\n");
            }
        }
            
            if(alertMsg != ""){
                var err = alertMsg.split("\n");
                sessionStorage.setItem("Errors", err);
                event.formAction = "/errPage.cfm";
                return true;
            }
            else{AllowPass(); return false;}





            // if(alertMsg != ""){
            //     alert(alertMsg);
            //     return false;
            // }

        // if(streetNum != null){
        //     Check(streetNum);
        // }

        // if(zip != null){
        //     Check(zip);
        // }

        // if(state != null){
        //     Check(state);
        // }

        // if(street != null){
        //     Check(street);
        // }

        // if(confPass != null){
        //     Check(confPass);
        // }

        // if(pass != null){
        //     Check(pass);
        // }

        // if(username != null){
        //     Check(username);
        // }

        // if(suffix != null){
        //     Check(suffix);
        // }

        // if(lName != null){
        //     Check(lName);
        // }

        // if(fname != null){
        //     Check(fname);
        // }

        // if(city != null){
        //     Check(city);
        // }

        // email?Check(email):null;
        // streetNum?Check(streetNum):null;
        // zip?Check(zip):null;
        // state?Check(state):null;
        // street?Check(street):null;
        // confPass?Check(confPass):null;
        // pass?Check(pass):null;
        // username?Check(username):null;
        // suffix?Check(suffix):null;
        // lName?Check(lName):null;
        // fname?Check(fname):null;
        // city?Check(city):null;

        // pass&&confPass?CheckMatching(pass, confPass):null;
// }

    // if(form.name == "companyForm"){
    //     // alert("Company Form");
    //     let company = {field: document.forms["companyForm"]["companyName"], user: "Company Name"}
    //     company?Check(company):null;
    // }

    // if(errors.length > 0){DisplayErrors(); event.formAction = "/errPage.cfm"}
}

function validateCompany(event){
    alertMsg ="";
    var companyName = document.getElementById("companyName");
    
    if(companyName.value == ""){
        alertMsg += "Company Name must have content.";
    }

    if(alertMsg != ""){
        var err = alertMsg.split("\n");
        sessionStorage.setItem("Errors", err);
        event.formAction = "/errPage.cfm?Errors=" + err;
        return true;
    }
    else{AllowPass(); return false;}
}

//Checks

// function Check(element){
//     // else{element.field.value.isEmpty()?SendErrorMessage(element.user + " must be filled out.", element.field):null;
//         if(element.field.isEmpty(element.user + " must be filled out.", element.field)){
//             SendErrorMessage()
//         }

//         if(element.user == 'First Name'|| element.user == 'Last Name' || element.user == 'City' || element.user == "Company Name"){
//             CheckNumber(element);
//         }

//         if(element.user == "Password" || element.user == "Confirm Password"){
//             CheckLength(element, 8);
//         }

//         if(element.user == "Street" || element.user =="Zip Code"){
//             CheckLetters(element);
//         }

//         if(element.user == "Email"){
//             CheckEmail(element);
//         }
//     }






function CheckNumber(element){
    element.field.value.hasNumber()?SendErrorMessage(element.user + " can not contain numerics.", element.field):null;
}

function CheckLength(element, minLength){
    !element.field.value.meetsLengthReq(minLength)?SendErrorMessage("Confirm that your " + element.user +  " meets minimum length requirements.(" + minLength + ")"):null;
}

function CheckLetters(element){
    element.field.value.hasLetter()?SendErrorMessage(element.user + " can not contain alphabetic characters.", element.field):null;
}

function CheckEmail(element){
    !element.field.value.validEmail()?SendErrorMessage(element.user + " does not meet standard email formatting.", element.field):null;
}


function CheckMatching(_string1, _string2){
    !_string1.field.value.matches(_string2.field.value)?SendErrorMessage(_string1.user + " and " + _string2.user + " do not match."):null;
}


function SendErrorMessage(err){
    errors.push(err);

    sessionStorage.clear("Errors");
    sessionStorage.setItem("Errors", errors);
}

function DisplayErrors(){
    let myErr = sessionStorage.setItem("Errors", errors);
    errTxt.innerHTML = myErr.toString().replaceAll(',', '<br>');
    errTxt.hidden = false;
    alert(errors.toString().replaceAll(',', '<br>'));

    window.scrollTo(0,0);
}

function AllowPass(){
    sessionStorage.clear("Errors");
    errTxt.hidden = true;
    // alert("Good Form");
}


//Not Needed, just a fun way to get url vars.
function getUrlVars() {
    var vars = {};
    var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(m,key,value) {
        vars[key] = value;
    });
    return vars;
}