<cfif !structKeyExists(session, "started")>
    <cflocation  url="/logout.cfm" addtoken="no">
</cfif>

<cfif session.started eq "true">
    <cfif session.IsLoggedIn eq "true">
        <cfquery name="qry" datasource="empdeets">
            SELECT 
            e.EMPLOYEEID
            ,e.FIRSTNAME
            ,e.LASTNAME
            ,e.NAMESUFFIX
            ,e.ISACTIVE
            ,e.COMPANYID
            ,e.TEL
            ,s.ID
            ,s.NAME
            ,u.USERNAME
            ,u.EMAIL
            ,u.PASS
            ,u.ISADMIN
            ,a.STATE
            ,a.ZIPCODE
            ,a.CITY
            ,a.STREETNAME
            ,a.STREETNUMBER
            FROM TBL_EMPLOYEE e
            JOIN TBL_SUFFIX s ON e.NAMESUFFIX=s.NAME
            JOIN TBL_USERS u ON e.EMPLOYEEID=u.EMPLOYEEID
            JOIN TBL_Address a ON a.EMPLOYEEID = e.EMPLOYEEID
            WHERE e.EMPLOYEEID=<cfqueryparam value=#URL.ID# cfsqltype="CF_SQL_INTEGER">
        </cfquery>



        <cfquery name="companies" datasource="empdeets">
            SELECT 
            COMPANYID
            ,COMPANYNAME
            FROM TBL_Company
            WHERE COMPANYID != 10
            ORDER BY COMPANYNAME ASC
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
<!-------------------------------------------------------------------------- Page --------------------------------------------------------------------------------------------------------------->
    <cfinclude  template="header.cfm">
    <cfinclude  template="/navbar.cfm">

    <cfset companyName = #qry.COMPANYID#>
    <cfloop query="companies">
        <cfif companies.COMPANYID EQ qry.COMPANYID> 
            <cfset companyName = #companies.COMPANYNAME#>
        </cfif>
    </cfloop>

    <div class="flex-container mx-auto mt-5" style="width:40%;">
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
                                <input type="text" class="form-control" id="fname" name="fname" value="#qry.FIRSTNAME#" readonly>
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
                                <input type="text" class="form-control" id="lname" name="lname" value=#qry.LASTNAME# readonly>
                            </cfoutput>
                         </div>  
                    </td> 
                </tr>
            
            
            
                <tr>
                    <th>
                        Phone number
                    </th>
                
                    <td>
                        <div class="form-input">
                            <cfoutput>
                                <cfset cleanPhoneNumber = reReplace(#qry.TEL#, "[^0-9]", "", "ALL")>
                                <cfset phoneFormatted = "(#left(cleanPhoneNumber, 3)#) #mid(cleanPhoneNumber, 4, 3)#-#right(cleanPhoneNumber, 4)#">   
                                <input type="text" class="form-control" id="tel" name="tel" value='#phoneFormatted#' readonly>
                            </cfoutput>
                        </div>  
                    </td>
                </tr>
                
                <cfif #qry.NAMESUFFIX# EQ 'NA' || isNull(#qry.NAMESUFFIX#)>
                    <tr>
                        <th>
                            Suffix
                        </th>
                        <td>
                            <div class="form-input">
                                <cfoutput>
                                    <select name="suffix" id="suffix" class="form-select-sm" aria-label="Modify Name Suffix Dropdown">
                                        <cfif #qry.NAMESUFFIX# EQ 'NA' || isNull(#qry.NAMESUFFIX#)>
                                            <option selected disabled hidden>Make Selection</option>
                                        <cfelse>
                                            <option selected>#qry.NAMESUFFIX#</option>
                                        </cfif>
                                    </select>
                                </cfoutput>
                            </div>
                        </td>
                    </tr>
                </cfif>
                <tr>
                    <th>
                        Company
                    </th>
                    <td>
                        <div class="form-input">
                            <cfoutput>
                                <select name="company" id="company" class="form-select-md mb-3" aria-label="Modify Company Data" disabled>
                                    <option selected hidden value=#qry.COMPANYID#>#CompanyName#</option>
                                </select
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
                                <input type="text" class="form-control" id="email" name="email" value=#qry.EMAIL# readonly>
                            </cfoutput>
                        </div>         
                    </td>
                </tr>
            
            
                <tr>
                    <th>
                        Username
                    </th>
                    <td>
                        <div class="form-input">
                            <cfoutput>
                                <input type="text" class="form-control" id="username" name="username" value=#qry.USERNAME# readonly>
                            </cfoutput>
                        </div>  
                    </td>
                </tr>                   
            
                <tr>
                    <th>
                        Street Number
                    </th>
                    <td>
                        <div class="form-input">
                            <cfoutput>
                                <input type="number" class="form-control" id="streetNum" name="streetNum" value=#qry.STREETNUMBER# readonly>
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
                                <input type="text" class="form-control" id="street" name="street" value=#qry.STREETNAME# readonly>
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
                                <input type="text" class="form-control" id="city" name="city" value=#qry.CITY# readonly>
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
                                <select name="state" id="state" class="form-select-md mb-3" id="state" disabled>
                                    <option selected hidden value=#qry.STATE#>#qry.STATE#</option>
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
                                <input type="number" class="form-control" id="zip" name="zip" value=#qry.ZIPCODE# readonly>
                            </cfoutput>
                        </div>  
                    </td>
                </tr>
            </table> 
        </div>

        <div class="d-grid gap-2 col-3 mx-auto">
            <cfoutput>
                <cfif qry.ISACTIVE EQ 1>
                    <div class="btn btn-secondary">
                        <a href="/modifyEmp.cfm?ID=#URL.ID#">Modify</a>
                    </div>                    
                <cfelse>
                    <div class="btn btn-secondary">
                        <a href="/Gateway/Activate.cfm?ID=#URL.ID#">Activate</a>
                    </div> 
                </cfif>
                <div class="btn btn-secondary">
                    <a href="javascript: history.go(-1);">Return</a>
                </div>
            </cfoutput>
        </div>
        <cfinclude  template="footer.cfm">
    <cfelse>
        <cflocation  url="/login.cfm" addToken="no"> 
    </cfif>
<cfelse>
    <cflocation  url="/logout.cfm" addToken="no"> 
</cfif>






<!---
                <div class="card group">
                    <h1 class="sm-title">Employee Info</h1>
                    <br>
                    <div class="form-input">
                        <label for="fname">First Name:</label>
                        <input type="text" class="readOnly-input" name="fname" value='#qry.FIRSTNAME#' readonly>
                    </div>  
                
                    <div class="form-input">
                        <label for="lname">Last Name:</label>
                        <input type="text" class="readOnly-input" name="lname"  value='#qry.LASTNAME#' readonly>
                    </div>
                <cfif isValid("variableName", #qry.NAMESUFFIX#)>
                    <div class="form-input">
                        <label for="suffix">Suffix:</label>
                        <input type="text" class="readOnly-input" name="suffix"  value='#qry.NAMESUFFIX#' readonly>
                    </div>  
                </cfif>

                <div class="form-input">
                    <label for="tel">Phone Number:</label>
                    <cfset cleanPhoneNumber = reReplace(#qry.TEL#, "[^0-9]", "", "ALL")>
                    
                    <cfset phoneFormatted = "(#left(cleanPhoneNumber, 3)#) #mid(cleanPhoneNumber, 4, 3)#-#right(cleanPhoneNumber, 4)#">
                    
                    <input type="text" class="readOnly-input" name="tel" value='#phoneFormatted#' readonly>
                </div>

                </div>
                
                <div class="card group">
                    <h1 class="sm-title">User Info</h1>
                    <br>
                 
                    <div class="form-input">
                        <label for="email">Email Address:</label>
                        <input type="text" class="readOnly-input" name="email" value='#qry.EMAIL#' readonly>
                    </div>
                 
                    <div class="form-input">
                        <label for="username">Username:</label>
                        <input type="text" class="readOnly-input" name="username" value='#qry.USERNAME#' readonly>
                    </div>  
                </div>

                <div class="card group">
                    <h1 class="sm-title">Contact Info</h1>
                    <br>
                    <div class="form-input">
                        <label for="streetNum">Street Number:</label>
                        <input type="number" class="readOnly-input" name="streetNum" value='#addr.STREETNUMBER#' readonly>
                    </div>
                    <div class="form-input">
                        <label for="street">Street Name:</label>
                        <input type="text" class="readOnly-input" name="street" value='#addr.STREETNAME#' readonly>
                    </div>
                
                    <div class="form-input">
                        <label for="city">City Name:</label>
                        <input type="text" class="readOnly-input" name="city" value='#addr.CITY#' readonly>
                    </div>
                
                    <div class="form-input">
                        <div class="form-input">
                            <label for="state">State:</label>
                            <input type="text" class="readOnly-input"  name="state" value='#addr.STATE#' readonly
                        </div>
                    </div>
                
                    <div class="form-input">
                        <label for="zip">Zip Code:</label>
                        <input type="text" class="readOnly-input"  name="zip" value='#addr.ZIPCODE#' readonly>
                    </div>
                </div>
            </div>


            <cfif #session.USER.ISADMIN#>
                <cfif qry.ISACTIVE EQ 1>
                     <!--- 
                        <div class="d-grid gap-2 col-6 mx-auto btn btn-secondary">
                        <cfoutput>
                            <a href="/modifyEmp.cfm?ID=#URL.ID#">Modify</a>
                        </cfoutput>
                    </div>
                     --->

                        <!-- Button trigger modal -->
                        <!--- <cfoutput> --->
                            <button type="button" class="btn btn-primary d-grid gap-2 col-6 mx-auto" data-toggle="modal"  data-target="#modModal">
                                Modify
                            </button>


                    <div class="d-grid gap-2 col-6 mx-auto btn btn-secondary">
                        <cfoutput>
                            <a href="/terminateEmp.cfm?ID=#URL.ID#">Terminate</a>
                        </cfoutput>
                    </div>
                <cfelse>
                    <cfif qry.COMPANYID EQ 10>
                        <div class="d-grid gap-2 col-6 mx-auto btn btn-secondary">
                            <cfoutput>
                                <a href="/Gateway/Activate.cfm?ID=#URL.ID#">Activate</a>
                            </cfoutput>
                        </div>
                        <cfelse>
                                <button type="button" class="btn btn-secondary d-grid gap-2 col-6 mx-auto" data-toggle="modal"  data-target="#modModal">
                                    Modify
                                </button>
                        </cfif>
                    </cfif>
                </cfif>
            <div class="d-grid gap-2 col-6 mx-auto btn btn-secondary">
                <a href="javascript: history.go(-1);">Return</a>
            </div>

            <!-- Modal -->
            <div class="modal modal-lg fade" id="modModal" tabindex="-1" role="dialog" aria-labelledby="modModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Modify Employee</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                        </div>
                            <cfoutput>
                                <form class="form" action="/Gateway/Modify.cfm?ID=#qry.EMPLOYEEID#" name="myForm" id="myForm" method="post">
                            </cfoutput>
                            <div class="modal-body">
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
                                                        <input type="text" class="form-control" id="fname" name="fname" value="#qry.FIRSTNAME#">
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
                                                        <input type="text" class="form-control" id="lname" name="lname" value=#qry.LASTNAME#>
                                                    </cfoutput>
                                                 </div>  
                                            </td> 
                                        </tr>
                                    
                                    
                                    
                                        <tr>
                                            <th>
                                                Phone number
                                            </th>
                                        
                                            <td>
                                                <div class="form-input">
                                                    <cfoutput>
                                                        <cfset cleanPhoneNumber = reReplace(#qry.TEL#, "[^0-9]", "", "ALL")>
                                                        <cfset phoneFormatted = "(#left(cleanPhoneNumber, 3)#) #mid(cleanPhoneNumber, 4, 3)#-#right(cleanPhoneNumber, 4)#">   
                                                        <input type="text" class="form-control" id="tel" name="tel" value='#phoneFormatted#'>
                                                    </cfoutput>
                                                </div>  
                                            </td>
                                        </tr>
                                    
                                        <tr>
                                            <th>
                                                Suffix
                                            </th>
                                            <td>
                                                <div class="form-input">
                                                    <cfoutput>
                                                        <select name="suffix" id="suffix" class="form-select-sm" aria-label="Modify Name Suffix Dropdown">
                                                            <cfif #qry.NAMESUFFIX# EQ 'NA' || isNull(#qry.NAMESUFFIX#)>
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
                                    
                                        <tr>
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
                                        </tr>
                                    
                                        <tr>
                                            <th>
                                                Email
                                            </th>
                                            <td>
                                                <div class="form-input">
                                                    <cfoutput>
                                                        <input type="text" class="form-control" id="email" name="email" value=#qry.EMAIL#>
                                                    </cfoutput>
                                                </div>         
                                            </td>
                                        </tr>
                                    
                                    
                                        <tr>
                                            <th>
                                                Username
                                            </th>
                                            <td>
                                                <div class="form-input">
                                                    <cfoutput>
                                                        <input type="text" class="form-control" id="username" name="username" value=#qry.USERNAME#>
                                                    </cfoutput>
                                                </div>  
                                            </td>
                                        </tr>
                                    
                                        <tr>
                                            <th>
                                                Password
                                            </th>
                                            <td>
                                                <div class="form-input">
                                                    <cfoutput>
                                                        <input type="password" class="form-control" id="pass" name="pass" value=#qry.PASS#>
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
                                        </tr>
                                    
                                        <tr>
                                            <th>
                                                Street Number
                                            </th>
                                            <td>
                                                <div class="form-input">
                                                    <cfoutput>
                                                        <input type="number" class="form-control" id="streetNum" name="streetNum" value=#addr.STREETNUMBER#>
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
                                                        <input type="text" class="form-control" id="street" name="street" value=#addr.STREETNAME#>
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
                                                        <input type="text" class="form-control" id="city" name="city" value=#addr.CITY#>
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
                                                            <option selected hidden value=#addr.STATE#>#addr.STATE#</option>
                                                        
                                                            <cfloop query="states">
                                                                <option>#states.STATEINITIALS#</option>
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
                                                        <input type="number" class="form-control" id="zip" name="zip" value=#addr.ZIPCODE#>
                                                    </cfoutput>
                                                </div>  
                                            </td>
                                        </tr>
                                    </table> 
                                </div> 
                            </div>
                            
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                <div class="d-grid gap-2 col-6 mx-auto">
                                    <cfoutput>
                                        <input class="btn btn-secondary" type="submit" value="Submit" onclick="return validateModal()" name="submit" id="submit">
                                    </cfoutput>
                                </div>  
                            </div>
                        </form>
                        <cfinclude  template="footer.cfm">                
                    </div>
                </div>
            </div>
        </div>
    --->