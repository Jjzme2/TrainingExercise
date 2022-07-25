/*                                                                            Variables Declared                                                                                        */
var errors = [];
var submitBtn =  getElementByID("submit");
var pageTitle = getElementByID("page-title");
var path = window.location.pathname;
var myForm = getForm["myForm"];
var employeeData = {};

/*                                                                            RegEx                                                                                         */
var emailTest = /^[A-Z0-9._%+-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}$/i;
var numberTest = /\d/;
var phoneTest = /\(?\d{3}\)?[ -]?\d{3}[ -]?\d{4}/g;
var passwordTest = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$ %^&*-]).{8,}$/g;
var usernameTest = /^[a-zA-Z0-9]{3,15}$/g;

/*                                                                            Used Alot                                                                                        */
function getElementByID(elementName){
    return document.getElementById(elementName);
}

function getForm(formName){
    return document.forms[formName];
}

function getChild(parent)
{
    let id = parent.children["employeeID"];
    let fName = parent.children["firstName"];
    let lName = parent.children["lastName"];
    let sName = parent.children["sName"];
    let phone = parent.children["phone"];
    let email = parent.children["email"];
    let username = parent.children["username"];
    let password = parent.children["password"]
    let streetNumber = parent.children["streetNum"];
    let streetName = parent.children["street"];
    let city = parent.children["city"];
    let state = parent.children["state"];
    let stateID = parent.children["stateID"];
    let zipCode = parent.children["zipCode"];

    let phoneNumber = {
        submitted: phone.innerHTML
        ,clean: phone.innerHTML.replace(/[^0-9]/g, "")
    }

    let grouped = phoneNumber.clean.split(/(\d{3})(\d{3})(\d{4})/g);
    let phoneFormatted = "(" + grouped[1] + ") " + grouped[2] + "-" + grouped[3]; 
    
    let namedEmployee = {
        id: id.innerHTML
        ,firstName: fName.innerHTML
        ,lastName: lName.innerHTML
        ,suffix: sName.innerHTML
        ,phone: phoneFormatted
        ,email: email.innerHTML
        ,username: username.innerHTML
        ,password: password.value
        ,streetNumber: streetNumber.innerHTML
        ,streetName: streetName.innerHTML
        ,city: city.innerHTML
        ,state: state.innerHTML
        ,stateID: stateID.innerHTML
        ,zipCode: zipCode.innerHTML


        
        // Date Stuff
        // ,isActive: active.innerHTML
        // ,activationDate: activationDate.innerHTML
        // ,hireDate: hireDate.innerHTML
    }
    return namedEmployee;
}

/*                                                                         Start Data Tables                                                                                        */
/*                                                                            Company.cfm                                                                                         */

document.addEventListener('DOMContentLoaded', function () {
    var table = new DataTable('#example', {
    "search": true,
    "paging": true
    })
});

/*                                                                            Welcome.cfm                                                                                        */

document.addEventListener('DOMContentLoaded', function () {
    var companyTable = new DataTable('#companyTable', {
    "search": true,
    "paging": true,
    })
});

/*                                                                            Database.cfm                                                                                        */

document.addEventListener('DOMContentLoaded', function () {
    var databaseTable = new DataTable('#databaseTable', {
    "search": true,
    "paging": true,
    })
});

/*                                                                         End Data Tables                                                                                        */


/*                                                                            Company.cfm                                                                                        */
function sendData(element){
    // Values
    employeeData = {
        contact:
        {
            first: getChild(element).firstName 
            ,last: getChild(element).lastName
            ,suffix: getChild(element).suffix
            ,fullName: getChild(element).firstName + " " + getChild(element).lastName
            ,phone: getChild(element).phone
             ,email: getChild(element).email
           
                // Address Info
             ,streetNumber: getChild(element).streetNumber
             ,streetName: getChild(element).streetName
             ,cityName: getChild(element).city
             ,state: getChild(element).state
             ,stateID: getChild(element).stateID
             ,zipCode: getChild(element).zipCode
            //  ,fullAddress: streetNum + " " + streetName + " " + city + ", " + state + " " + zipCode

        }

        ,hire:
        {
            employeeID: getChild(element).id
            ,companyID:getChild(element).companyID
            ,companyName:getChild(element).companyName
            ,hireDate: getChild(element).hireDate
            ,isActive: getChild(element).isActive
            ,recentActivation: getChild(element).recentActivation
            //  User
             ,username: getChild(element).username
             ,password: getChild(element).pass
        }
    }
    populateModal(employeeData);
}

function sendToCompany(element){
    let companyInfo = {
        name: element.innerHTML
        ,id: element.getAttribute("companyID")
    }
    let companyID = element.getAttribute("companyID");
    window.location.assign("/company.cfm?ID=" + companyInfo.id);
}


function sendToFullEmp(element){  
    let employeeID = element.getAttribute("employeeID");
    window.location.assign("/fullEmp.cfm?ID=" + employeeID);
}

/*                                                                            Company.cfm                                                                                        */
function populateModal(employee){
    console.log("populating with info from " + employee.contact.fullName)
    let body = getElementByID("modal-body");
    getElementByID("modal-fname").value = employee.contact.first;
    getElementByID("modal-lname").value = employee.contact.last;
    getElementByID("modal-suffix").value = employee.contact.suffix;
    getElementByID("modal-tel").value = employee.contact.phone;
    getElementByID("modal-email").value = employee.contact.email;
    getElementByID("modal-streetNum").value = employee.contact.streetNumber;
    getElementByID("modal-street").value = employee.contact.streetName;
    getElementByID("modal-state-selected").innerHTML = employee.contact.state;
    getElementByID("modal-state-selected").value = employee.contact.state;
    getElementByID("modal-city").value = employee.contact.cityName;
    getElementByID("modal-zip").value = employee.contact.zipCode;
    getElementByID("modal-username").value = employee.hire.username;
    getElementByID("modal-password").value = employee.contact.password;
}

/*                                                                            Company.cfm                                                                                        */
function CloseModal(){
    console.log("Closed.");
    window.location.reload();
}

/*                                                                            Company.cfm                                                                                        */
function validate(that)
{
    errors = [];
    sessionStorage.setItem('Errors', JSON.stringify(errors));

    var fname = getElementByID("modal-fname");
    var email = getElementByID("modal-email");
    var lName = getElementByID("modal-lname");
    var username = getElementByID("modal-username");
    var streetNum = getElementByID("modal-streetNum");
    var street = getElementByID("modal-street");
    var zip = getElementByID("modal-zip");
    var city = getElementByID("modal-city");
    var state = getElementByID("modal-state-selected");
    // var suffix = getElement("modal-suffix");
    var phone = getElementByID("modal-tel");


    var isGood = true;

    // Email
    if(email.value == "")
    {
        errors.push("Email must have content.");
    }
    else if(!emailTest.test(email.value))
    { 
        errors.push("Email must meet standard email format.");
    }

    //First Name
    if(fname.value == "")
    {
        errors.push("First name must have content.");
    }
    else if(numberTest.test(fname.value))
    { 
        errors.push("First name can not contain numbers.");
    }

    //Last Name
    if(lName.value == "")
    {
        errors.push("Last name can not contain numbers.");
    }
    else if(numberTest.test(lName.value))
    { 
        errors.push("Last name can not contain numbers.");
    }


    //Phone 
    if(phone.value == "")
    {
        errors.push("Phone must contain content.");
    }
    else if(!phoneTest.test(phone.value))
    { 
        errors.push("Phone must only contain numbers.");
    }

    //Username
    if(username.value == "")
    {
        errors.push("Username must have content.");
    }
    else if(!usernameTest.test(username.value))
    {
        errors.push("Username can only contain letters and numbers, and must be between 3 and 16 characters.");
    }

    // if(pass.value == "")
    // {
    //     errors.push("Password must have content.");
    // }
    // else if(!passwordTest.test(pass.value))
    // { 
    //     errors.push("Password must contain at least eight characters with one upper case letter, one lower case letter, one number, and one special character.");
    // }
    
    // if(confPass.value == "")
    // {
    //     errors.push("Password confirmation must have content.");
    // }
    // else if(confPass.value.length < 8)
    // {
    //     errors.push("Password confirmation must meet minimum length requirements.");
    // }

    // if(confPass.value != pass.value)
    // {
    //     errors.push("Passwords must match.");
    // }

    if(streetNum.value == 0)
    {
        errors.push("Street number must have content.");
    }
    else if(isNaN(streetNum.value))
    { 
        errors.push("Street number must be a number.");
    }

    if(zip.value == 0)
    {
        errors.push("Zip code must have content.");
    }
    else if(isNaN(zip.value))
    { 
        errors.push("Zip code must be a number.");
    }

    if(city.value == "")
    {
        errors.push("City must be a number.");
    }
    else if(numberTest.test(city.value))
    { 
        errors.push("City name can not contain numbers.");
    }

    if(street.value == "")
    {
        errors.push("Street must have content.");
    }
    else if(numberTest.test(street.value))
    { 
        errors.push("Street name can not contain numbers.");
    }

    // if(suffix.value == "")
    // {
    //     errors.push("Suffix must have content.");
    // }

    if(state.value == "")
    {
        errors.push("State must have content.");
    }

    // if(company.value == 10)
    // {
    //     if(errors.length == 0)
    //     {
    //         alert("Employee will be added to employee pool since no company is defined.");
    //         // return true;
    //     }
    // }
        console.log(errors);
    if(errors.length > 0)
    {
        isGood = false;
        sessionStorage.setItem('Errors', JSON.stringify(errors)); 
        window.location.assign("/errPage.cfm"); 
        return false;
    }
    else
    {
        that.form.action="/Gateway/modify.cfm?ID=" + employeeData.hire.employeeID;
        return true;
    }
}

function terminate(that){
    console.log(employeeData.hire.employeeID);
    let address = "/terminateEmp.cfm?ID=" + employeeData.hire.employeeID;
    window.location.assign(address);
}

function activate(that){
    console.log(employeeData.hire.employeeID);
    let address = "/Gateway/Activate.cfm?ID=" + employeeData.hire.employeeID;
    window.location.assign(address);
}

/*                                                                            FullEmp.cfm                                                                                        */
function validateModal(empID) {
    errors = [];
    sessionStorage.setItem('Errors', JSON.stringify(errors));

    var fname = getElementByID("fname");
    var email = getElementByID("email");
    var lName = getElementByID("lname");
    var username = getElementByID("username");
    var pass = getElementByID("pass");
    var confPass = getElementByID("confPass");
    var streetNum = getElementByID("streetNum");
    var street = getElementByID("street");
    var zip = getElementByID("zip");
    var city = getElementByID("city");
    var state = getElementByID("state");
    var suffix = getElementByID("suffix");
    var company = getElementByID("company");
    var phone = getElementByID("tel");

    var isGood = true;
    // Email
    if(email.value == "")
    {
        errors.push("Email must have content.");
    }
    else if(!emailTest.test(email.value))
    { 
        errors.push("Email must meet standard email format.");
    }

    //First Name
    if(fname.value == "")
    {
        errors.push("First name must have content.");
    }
    else if(numberTest.test(fname.value))
    { 
        errors.push("First name can not contain numbers.");
    }

    //Last Name
    if(lName.value == "")
    {
        errors.push("Last name can not contain numbers.");
    }
    else if(numberTest.test(lName.value))
    { 
        errors.push("Last name can not contain numbers.");
    }


    //Phone 
    if(phone.value == "")
    {
        errors.push("Phone must contain content.");
    }
    else if(!phoneTest.test(phone.value))
    { 
        errors.push("Phone must only contain numbers.");
    }

    //Username
    if(username.value == "")
    {
        errors.push("Username must have content.");
    }
    else if(!usernameTest.test(username.value))
    {
        errors.push("Username can only contain letters and numbers, and must be between 3 and 16 characters.");
    }

    if(pass.value == "")
    {
        errors.push("Password must have content.");
    }
    else if(!passwordTest.test(pass.value))
    { 
        errors.push("Password must contain at least eight characters with one upper case letter, one lower case letter, one number, and one special character.");
    }
    
    if(confPass.value == "")
    {
        errors.push("Password confirmation must have content.");
    }
    else if(confPass.value.length < 8)
    {
        errors.push("Password confirmation must meet minimum length requirements.");
    }

    if(confPass.value != pass.value)
    {
        errors.push("Passwords must match.");
    }

    if(streetNum.value == 0)
    {
        errors.push("Street number must have content.");
    }
    else if(isNaN(streetNum.value))
    { 
        errors.push("Street number must be a number.");
    }

    if(zip.value == 0)
    {
        errors.push("Zip code must have content.");
    }
    else if(isNaN(zip.value))
    { 
        errors.push("Zip code must be a number.");
    }

    if(city.value == "")
    {
        errors.push("City must be a number.");
    }
    else if(numberTest.test(city.value))
    { 
        errors.push("City name can not contain numbers.");
    }

    if(street.value == "")
    {
        errors.push("Street must have content.");
    }
    else if(numberTest.test(street.value))
    { 
        errors.push("Street name can not contain numbers.");
    }

    if(suffix.value == "")
    {
        errors.push("Suffix must have content.");
    }

    if(state.value == "")
    {
        errors.push("State must have content.");
    }

    if(company.value == 10)
    {
        if(errors.length == 0)
        {
            alert("Employee will be added to employee pool since no company is defined.");
            // return true;
        }
    }

    if(errors.length > 0)
    {
        isGood = false;
        sessionStorage.setItem('Errors', JSON.stringify(errors)); 
        window.location.assign("/errPage.cfm"); 
        return false;
    }
    else
    {
        return true;
    }
}

/*                                                                            ModifyEmp.cfm/AddEmp.cfm                                                                                        */
function validateForm() {
    errors = [];
    sessionStorage.setItem('Errors', JSON.stringify(errors));

    var fname = getElementByID("fname");
    var email = getElementByID("email");
    var lName = getElementByID("lname");
    var username = getElementByID("username");
    var pass = getElementByID("pass");
    var confPass = getElementByID("confPass");
    var streetNum = getElementByID("streetNum");
    var street = getElementByID("street");
    var zip = getElementByID("zip");
    var city = getElementByID("city");
    var state = getElementByID("state");
    var suffix = getElementByID("suffix");
    var company = getElementByID("company");
    var phone = getElementByID("tel");


    var isGood = true;

    // Email
    if(email.value == "")
    {
        errors.push("Email must have content.");
    }
    else if(!emailTest.test(email.value))
    { 
        errors.push("Email must meet standard email format.");
    }

    //First Name
    if(fname.value == "")
    {
        errors.push("First name must have content.");
    }
    else if(numberTest.test(fname.value))
    { 
        errors.push("First name can not contain numbers.");
    }

    //Last Name
    if(lName.value == "")
    {
        errors.push("Last name can not contain numbers.");
    }
    else if(numberTest.test(lName.value))
    { 
        errors.push("Last name can not contain numbers.");
    }


    //Phone 
    if(phone.value == "")
    {
        errors.push("Phone must contain content.");
    }
    else if(!phoneTest.test(phone.value))
    { 
        errors.push("Phone must only contain numbers.");
        let cleanedPhone = phone.value.replace(/[^0-9]/g, "");
    }

    //Username
    if(username.value == "")
    {
        errors.push("Username must have content.");
    }
    else if(!usernameTest.test(username.value))
    {
        errors.push("Username can only contain letters and numbers, and must be between 3 and 16 characters.");
    }

    if(pass.value == "")
    {
        errors.push("Password must have content.");
    }
    else if(!passwordTest.test(pass.value))
    { 
        errors.push("Password must contain at least eight characters with one upper case letter, one lower case letter, one number, and one special character.");
    }
    
    if(confPass.value == "")
    {
        errors.push("Password confirmation must have content.");
    }
    else if(confPass.value.length < 8)
    {
        errors.push("Password confirmation must meet minimum length requirements.");
    }

    if(confPass.value != pass.value)
    {
        errors.push("Passwords must match.");
    }

    if(streetNum.value == 0)
    {
        errors.push("Street number must have content.");
    }
    else if(isNaN(streetNum.value))
    { 
        errors.push("Street number must be a number.");
    }

    if(zip.value == 0)
    {
        errors.push("Zip code must have content.");
    }
    else if(isNaN(zip.value))
    { 
        errors.push("Zip code must be a number.");
    }

    if(city.value == "")
    {
        errors.push("City must be a number.");
    }
    else if(numberTest.test(city.value))
    { 
        errors.push("City name can not contain numbers.");
    }

    if(street.value == "")
    {
        errors.push("Street must have content.");
    }
    else if(numberTest.test(street.value))
    { 
        errors.push("Street name can not contain numbers.");
    }

    if(suffix.value == "")
    {
        errors.push("Suffix must have content.");
    }

    if(state.value == "")
    {
        errors.push("State must have content.");
    }

    if(company.value == 10)
    {
        if(errors.length == 0)
        {
            alert("Employee will be added to employee pool since no company is defined.");
            // return true;
        }
    }

    if(errors.length > 0)
    {
        isGood = false;
        sessionStorage.setItem('Errors', JSON.stringify(errors)); 
        window.location.assign("/errPage.cfm"); 
        return false;
    }
    else
    {
        return true;
    }
}

/*                                                                            addCompany.cfm                                                                                        */
function validateCompany(that)
{
    errors = [];
    sessionStorage.setItem('Errors', JSON.stringify(errors));
    var isGood = true;

    var companyName = getElementByID("companyNameInput");
    if(companyName.value == "" || companyName.value == null)
    {
        errors.push("Company name must have content");
    }



    console.log(errors);
    if(errors.length > 0)
    {
        isGood = false;
        sessionStorage.setItem('Errors', JSON.stringify(errors)); 
        window.location.assign("/errPage.cfm"); 
        return false;
    }
    else
    {
        that.form.action="/Gateway/AddCompany.cfm";
        return true;
    }









    if(errors.length > 0)
    {
        isGood = false;
        sessionStorage.setItem('Errors', JSON.stringify(errors)); 
        window.location.assign("/errPage.cfm"); 
        return false;
    }
    else
    {
        // Removing this line will revert to the older version
        that.form.action="/Gateway/AddCompany.cfm";
        console.log(that.form.action);
        return true;
    }
}
/*                                                                            login.cfm                                                                                        */

function validateLogin()
{
    errors = [];
    sessionStorage.setItem('Errors', JSON.stringify(errors));
    var isGood = true;


    var userName = getElementByID("username");
    var pass = getElementByID("password");

    if(userName.value == ""){
        errors.push("Username must have content")
    }
    
    if(pass.value == ""){
        errors.push("Password must have content")
    }

    if(errors.length > 0)
    {
        isGood = false;
        sessionStorage.setItem('Errors', JSON.stringify(errors)); 
        window.location.assign("/errPage.cfm"); 
        return false;
    }
    else
    {
        return true;
    }
}

/*                                                                            Display, errPage.cfm                                                                                       */
function displayErrors()
{ 
    var errText = document.getElementById("error-text");
    var errArray = JSON.parse(sessionStorage.getItem('Errors')); 
    console.log(errArray);

    for (var i = 0; i < errArray.length; i++)
    {
        errText.innerHTML += errArray[i] + "<br/>";
    }
}

/*Notes:
1. Add Phone Number -- In SQL and FullEmp.cfm/ModifyEmp/AddEmp/GatewayModify/GatewayAdd -- done
2. Add IsGood Variable to repeat less. -- Done
3. Add Regex for Address -- Need to do
4. Add Regex for password -- Done
5. Add Regex for Phone(TEL/tel) -- Done 
6. Search and Sort functionality
7. Data Tables
 */