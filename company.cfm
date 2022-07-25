<cfif !structKeyExists(session, "started")>
    <cfset session.started="false">
    <cflocation  url="/login.cfm" addtoken="no">
</cfif>

<cfif session.started eq "true">
    <cfif session.IsLoggedIn eq "true">
<!--------------------------------------------------------------------------- Queries --------------------------------------------------------------------------------------------------------------->

        <cfquery name="qry" datasource="empdeets" result="qryRes">
            SELECT DISTINCT
            c.COMPANYNAME
            ,c.COMPANYID
            ,e.EMPLOYEEID
            ,e.FIRSTNAME
            ,e.LASTNAME
            ,e.ISACTIVE
            ,e.NAMESUFFIX
            ,e.COMPANYID
            ,e.HIREDATE
            ,e.STARTDATE
            ,e.RECENTACTIVATION
            ,e.RECENTDEACTIVATION
            ,e.TEL
            ,u.USERNAME
            ,u.EMAIL
            ,u.PASS
            ,a.ZIPCODE
            ,a.STREETNUMBER
            ,a.CITY
            ,a.STREETNAME
            ,a.STATE
            ,s.STATEINITIALS
            ,s.STATEID
            FROM TBL_COMPANY c
            join TBL_Employee e on c.COMPANYID=e.COMPANYID
            join TBL_USERS u on u.EmployeeID = e.EmployeeID
            join TBL_ADDRESS a on a.EMPLOYEEID = e.EMPLOYEEID
            join TBL_STATES s on s.STATEINITIALS = a.STATE
            WHERE c.COMPANYID=<cfqueryparam value=#URL.ID# cfsqltype="CF_SQL_INTEGER">
            ORDER BY e.LASTNAME ASC;
        </cfquery>  

        <cfquery name="suf" datasource="empdeets">
            Select *
            FROM TBL_SUFFIX;
        </cfquery> 

        <cfquery name="states" datasource="empdeets">
            SELECT *
            FROM TBL_States 
            ORDER BY STATEINITIALS ASC;
        </cfquery>

<!--------------------------------------------------------------------------- Page --------------------------------------------------------------------------------------------------------------->
        
        <cfinclude  template="header.cfm">
        <cfinclude  template="/navbar.cfm">

        <div class="flex-container mx-5">
            <cfif qryRes.RECORDCOUNT GTE 0>
                <div id="example_wrapper" class="dataTables_wrapper">
                    <div class="dataTables_length" id="example_length">
                        <div id="example_filter" class="dataTables_filter">
                        </div>
                    </div>
                </div>
<table id="example" class="display dataTable" style="width:100%" aria-describedby="example_info">
                    <thead>
                        <tr>
                            <th style="display:none;">EmployeeID</th>
                            <th class="sorting sorting_asc" tabindex="0" aria-controls="example" rowspan="1" colspan="1" aria-sort="ascending" 
                            aria-label="First Name: activate to sort column descending" style="width: 131.172px;">First Name</th>
                            <th class="sorting" tabindex="1" aria-controls="example" rowspan="1" colspan="1" aria-label="Last Name: activate to sort column ascending" style="width: 218.172px;">LastName</th>
                            <th class="sorting" tabindex="2" aria-controls="example" rowspan="1" colspan="1" aria-label="Suffix: activate to sort column ascending" style="width: 96.9688px;">Suffix</th>
                            <th class="sorting" tabindex="6" aria-controls="example" rowspan="1" colspan="1" aria-label="Phone: activate to sort column ascending" style="width: 73.3125px;">Phone</th>
                            <th class="sorting" tabindex="6" aria-controls="example" rowspan="1" colspan="1" aria-label="Username: activate to sort column ascending" style="width: 73.3125px;">Username</th>
                            <th style="display:none;">Pass</th>
                            <th class="sorting" tabindex="6" aria-controls="example" rowspan="1" colspan="1" aria-label="Email: activate to sort column ascending" style="width: 73.3125px;">Email</th>
                           <!--- Address Stuff --->
                           <th style="display:none;">StreetNum</th>
                           <th style="display:none;">Street</th>
                            <th class="sorting" tabindex="6" aria-controls="example" rowspan="1" colspan="1" aria-label="Address: activate to sort column ascending" style="width: 73.3125px;">Address</th>
                            <th class="sorting" tabindex="6" aria-controls="example" rowspan="1" colspan="1" aria-label="City: activate to sort column ascending" style="width: 73.3125px;">City</th>
                            <th class="sorting" tabindex="6" aria-controls="example" rowspan="1" colspan="1" aria-label="State: activate to sort column ascending" style="width: 73.3125px;">State</th>
                            <th style="display:none;">StateID</th>
                            <th style="display:none;">ZipCode</th> 
                           <!--- Date Stuff --->
                            <!--- <th class="sorting" tabindex="6" aria-controls="example" rowspan="1" colspan="1" aria-label="Start Date: activate to sort column ascending" style="width: 73.3125px;">Start Date</th>                                 --->
                            <!--- <th class="sorting" tabindex="3" aria-controls="example" rowspan="1" colspan="1" aria-label="Is Active: activate to sort column ascending" style="width: 39.0156px;">Is Active</th> --->
                            <!--- <th class="sorting" tabindex="4" aria-controls="example" rowspan="1" colspan="1" aria-label="Recent Activation: activate to sort column ascending" style="width: 85.5469px;">Recent Activation</th> --->
                            <!--- <th class="sorting" tabindex="5" aria-controls="example" rowspan="1" colspan="1" aria-label="Start date: activate to sort column ascending" style="width: 85.5469px;">Hire date</th> --->
                        </tr>
                    </thead>
                    
                    <tbody>   
                        <cfloop query="qry">
                            <tr id="tableRow" onclick="sendData(this);" data-bs-toggle="modal" data-bs-target="#companyModal">
                                <cfoutput>
                                    <!--- Ajax to pass id to backend run query get employee data based on id pass to js --->
                                    <cfset fullStreetAddress = "#qry.STREETNUMBER# #qry.STREETNAME#">
                                    <td id="employeeID" style="display:none;">#qry.EMPLOYEEID#</td> 
                                    <td id="firstName" class="sorting_1">#qry.FIRSTNAME#</td>
                                    <td id="lastName" class="sorting_1">#qry.LASTNAME#</td>
                                    <td id="sName" class="sorting_1">#qry.NAMESUFFIX#</td>
                                    <td id="phone" class="sorting_1">(#left(qry.TEL, 3)#) #mid(qry.TEL, 4, 3)#-#right(qry.TEL, 4)#</td>
                                    <td id="username" class="sorting_1">#qry.USERNAME#</td>
<!---                   Highly insecure, it's shown in console. Look for better ways to pass info                  --->
                                    <td id="password" style="display:none;">#qry.PASS#</td>
                                    <td id="email" class="sorting_1">#qry.EMAIL#</td>
                                    
                                    <!--- Address --->
                                    <td id="streetNum" style="display:none;">#qry.STREETNUMBER#</td>
                                    <td id="street" style="display:none;">#qry.STREETNAME#</td>
                                    <td id="address" class="sorting_1">#fullStreetAddress#</td>
                                    <td id="city" class="sorting_1">#qry.CITY#</td>
                                    <td id="state" class="sorting_1">#qry.STATE#</td>
                                    <td id="stateID" style="display:none;">#qry.STATEID#</td>
                                    <td id="zipCode" style="display:none;">#qry.ZIPCODE#</td> 
                                    <!--- Date Stuff --->
                                    <!--- <td id="startDate" class="sorting_1">#dateFormat(qry.STARTDATE, 'mm-dd-yyyy')#</td> --->
                                    <!--- <td id="active" class="sorting_1">#qry.ISACTIVE#</td> --->
                                    <!--- <td id="activationDate" class="sorting_1">#dateFormat(qry.RECENTACTIVATION, 'mm-dd-yyyy')#</td> --->
                                    <!--- <td id="hireDate" class="sorting_1">#dateFormat(qry.HIREDATE, 'mm-dd-yyyy')#</td> --->
                                </cfoutput>
                            </tr>
                        </cfloop>
                    </tbody>
                    
                    <tfoot>
                    </tfoot>
                </table>




                <div class="modal modal-lg fade" id="companyModal" tabindex="-1" role="form" aria-labelledby="companyModalLabel" aria-hidden="false">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">  
                                <cfoutput>
                                    <h3 id="modal-title" class="modal-dialog modal-dialog-centered">Modifying Employee</h3>
                                </cfoutput>
                            </div>
                            
                            <div id="modal-body" class="modal-body">
                                <cfoutput>
                                    <form class="form" action="" name="myForm" id="myForm" method="post">
                                </cfoutput>
                                    <div class="flex-container">
                                        <cfset session.Errors = []>
                                        <table class="table table-lg table-striped table-highlighted">
                                            <!--- Header Define --->
                                            <th>
                                                Employee Info
                                            </th>
                                        
                                            <th>
                                                Submitted Info
                                            </th>
                                        
                                            <tr>    
                                                <th>
                                                    First Name
                                                </th>
                                                <td>
                                                    <div class="form-input">
                                                        <cfoutput>
                                                            <input type="text" class="form-control" id="modal-fname" name="fname" value="">
                                                        </cfoutput>
                                                    </div> 
                                                </td>
                                            </tr>
                                        
                                            <tr>
                                                <th>
                                                    Last Name
                                                </th>
                                            
                                                <td>
                                                    <div class="form-input">
                                                        <cfoutput>
                                                            <input type="text" class="form-control" id="modal-lname" name="lname" value="">
                                                        </cfoutput>
                                                     </div>  
                                                </td> 
                                            </tr>
                                        
                                        
                                            <cfoutput>
                                                <p style="display:none;" type="password" class="form-control" id="modal-password" name="password" value="">
                                            </cfoutput>
                                            <tr>
                                                <th>
                                                    Suffix
                                                </th>
                                                <td>
                                                    <div class="form-input">
                                                        <cfoutput>
                                                            <select name="suffix" id="modal-suffix" class="form-select-sm" aria-label="Modify Name Suffix Dropdown">
                                                                <cfif #qry.NAMESUFFIX# EQ '-' || isNull(#qry.NAMESUFFIX#)>
                                                                    <option selected disabled hidden>Make Selection</option>
                                                                <cfelse>
                                                                    <option selected>#qry.NAMESUFFIX#</option>
                                                                </cfif>
                                                                <cfloop query="suf">
                                                                    <option value=#suf.NAME#>#suf.NAME#</option>
                                                                </cfloop>
                                                            </select>
                                                        </cfoutput>
                                                    </div>
                                                </td>
                                            </tr>
                                            <!---
                                            <div class="form-input">
                                                <label for="tel">Phone Number:</label>
                                                <cfset cleanPhoneNumber = reReplace(#uQry.TEL#, "[^0-9]", "", "AL
                                                <cfset phoneFormatted = "(#left(cleanPhoneNumber, 3)#) #mid(cleanPhoneNumber, 4, 3)#-#right(cleanPhoneNumber, 4
                                                <input type="text" class="form-control" id="tel" name="tel" value='#phoneFormatted#'>
                                             </div>  
                                            --->
                                            <tr>
                                                <th>
                                                    Phone number
                                                </th>
                                            
                                                <td>
                                                    <div class="form-input">
                                                            <input type="text" class="form-control" id="modal-tel" name="tel" value=''>
                                                    </div>  
                                                </td>
                                            </tr>
                                        
                                            <!--- <tr>
                                                <th>
                                                    Company
                                                </th>
                                                <td>
                                                    <div class="form-input">
                                                        <cfoutput>
                                                            <select name="company" id="company" class="form-select-md mb-3" aria-label="Modify Company Data">
                                                                <cfif #qry.COMPANYID# EQ 10>
                                                                    <option selected disabled hidden>Make Selection</option>
                                                                <cfelse>
                                                                    <option selected hidden value=#qry.COMPANYID#>#CompanyName#</option>
                                                                </cfif>
                                                                <cfloop query="companies">
                                                                    <option value=#companies.COMPANYID#>#companies.COMPANYNAME#</option>
                                                                </cfloop>
                                                            </select>
                                                        </cfoutput>
                                                    </div>
                                                </td>
                                            </tr> --->
                                        
                                        
                                            <tr>
                                                <th>
                                                    Username
                                                </th>
                                                <td>
                                                    <div class="form-input">
                                                        <cfoutput>
                                                            <input type="text" class="form-control" id="modal-username" name="username" value="">
                                                        </cfoutput>
                                                    </div>  
                                                </td>
                                            </tr>
                                            <tr>
                                                <th>
                                                    Email
                                                </th>
                                                <td>
                                                    <div class="form-input">
                                                        <cfoutput>
                                                            <input id="modal-email" type="text" class="form-control" id="modal-email" name="email" value="">
                                                        </cfoutput>
                                                    </div>         
                                                </td>
                                            </tr>
                                        
                                            <!--- <tr>
                                                <th>
                                                    Password
                                                </th>
                                                <td>
                                                    <div class="form-input">
                                                        <cfoutput>
                                                            <input type="password" class="form-control" id="pass" name="pass" value="">
                                                        </cfoutput>
                                                    </div>  
                                                </td>
                                            </tr>
                                        
                                            <tr>
                                                <th>
                                                    Password Confirmation
                                                </th>
                                                <td>
                                                    <div class="form-input">
                                                        <cfoutput>
                                                            <input type="password" class="form-control" id="confPass" name="confPass" value="">
                                                        </cfoutput>
                                                    </div>  
                                                </td>
                                            </tr> --->
                                        
                                            <tr>
                                                <th>
                                                    Street Number
                                                </th>
                                                <td>
                                                    <div class="form-input">
                                                        <cfoutput>
                                                            <input type="number" class="form-control" id="modal-streetNum" name="streetNum" value="">
                                                        </cfoutput>
                                                    </div>  
                                                </td>
                                            </tr>
                                        
                                            <tr>
                                                <th>
                                                    Street Name
                                                </th>
                                                <td>
                                                    <div class="form-input">
                                                        <cfoutput>
                                                            <input type="text" class="form-control" id="modal-street" name="street" value="">
                                                        </cfoutput>
                                                    </div>  
                                                </td>
                                            </tr>
                                        
                                            <tr>
                                                <th>
                                                    City
                                                </th>
                                                <td>
                                                    <div class="form-input">
                                                        <cfoutput>
                                                            <input type="text" class="form-control" id="modal-city" name="city" "">
                                                        </cfoutput>
                                                    </div>  
                                                </td>
                                            </tr>
                                        
                                             <tr>
                                                <th>
                                                    State
                                                </th>
                                            
                                                <td>
                                                    <div class="form-input">
                                                        <cfoutput>
                                                            <select name="state" id="state" class="form-select-md mb-3" id="state">
                                                                <option id="modal-state-selected" selected hidden value=""></option>
                                                            
                                                                <cfloop query="states">
                                                                    <option value=#states.STATEINITIALS#>#states.STATEINITIALS#</option>
                                                                </cfloop>
                                                            </select>
                                                        </cfoutput>
                                                    </div>
                                                </td>
                                            </tr> 
                                        
                                            <tr>
                                                <th>
                                                    Zip Code
                                                </th>
                                                <td>
                                                    <div class="form-input">
                                                        <cfoutput>
                                                            <input type="number" class="form-control" id="modal-zip" name="zip" value="">
                                                        </cfoutput>
                                                    </div>  
                                                </td>
                                            </tr>
                                        </table>      
                                    </div>

                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="CloseModal()">Close</button> 
                                        <cfif #qry.ISACTIVE# EQ 1>
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="terminate(this)">Terminate</button>
                                        <cfelse>
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="activate(this)">Activate</button>
                                        </cfif>
                                        <button role="button" class="btn btn-secondary" value="Submit" type="submit" name="submit" id="submit" onclick="return validate(this);">Save</button>

                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>













<!---        End of Page              --->
                    
                    <div class="d-grid gap-2 col-2 mx-auto btn btn-secondary">
                        <cfoutput>
                        <a href="addEmp.cfm?CompanyID=#URL.ID#">Add Employee</a>
                        </cfoutput>
                    </div>
                    <div class="d-grid gap-2 col-2 mx-auto btn btn-secondary">
                        <a href="database.cfm">Go Home</a>
                    </div>
                </cfif>
            </div>
        <cfinclude  template="/footer.cfm"> 
    <cfelse>
        <cfset session.Errors.Append("Please ensure you have appropriate permission to access this content.")>
        <cflocation  url="/errPage.cfm" addToken="no"> 
    </cfif>
<cfelse>
    <cflocation  url="/login.cfm" addToken="no"> 
</cfif> 


<!--------------------------------------------------------------------------- Modal --------------------------------------------------------------------------------------------------------------->


