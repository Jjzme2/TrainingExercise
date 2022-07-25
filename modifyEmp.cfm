<cfif !structKeyExists(session, "started")>
    <cfset session.started="false">
    <cflocation  url="/login.cfm" addtoken="no">
</cfif>


<cfif session.started eq "true">
    <cfif session.IsLoggedIn eq "true">    
        <cfif #session.User.ISADMIN#>
            <!--- Begin Query --->
            <cfoutput>    
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

                <cfquery name="suf" datasource="empdeets">
                    Select *
                    FROM TBL_SUFFIX;
                </cfquery> 

                <cfquery name="states" datasource="empdeets">
                    SELECT *
                    FROM TBL_States 
                    ORDER BY STATEINITIALS ASC;
                </cfquery>

                <cfquery name="companies" datasource="empdeets">
                    SELECT
                    COMPANYNAME
                    ,COMPANYID
                    FROM TBL_Company
                    ORDER BY COMPANYNAME ASC;
                </cfquery>
            </cfoutput>
            <!--- End Query --->
            
            <cfset companyName = #qry.COMPANYID#>
            <cfloop query="companies">
                <cfif companies.COMPANYID EQ qry.COMPANYID> 
                    <cfset companyName = #companies.COMPANYNAME#>
                </cfif>
            </cfloop>

            <cfinclude  template="/header.cfm"> 
            <cfinclude  template="/navbar.cfm">

            <cfset session.Errors = []>
            
            <!--------- FORM START --------->  
                <cfoutput>
                    <form class="form" action="/Gateway/Modify.cfm?ID=#qry.EMPLOYEEID#" name="myForm" id="myForm" method="post">
                </cfoutput>
                <div class="flex-container mx-auto mt-5" style="width:40%;">

                <table class="table table-lg table-striped table-highlighted">
                        <!--- Header Define --->
                            <th>
                                Employee Info
                            </th>
<!---                Phone Field shows dump on empModify          --->
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
                                                    <option selected hidden value="-">Make Selection</option>
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
                                            <input type="number" class="form-control" id="streetNum" name="streetNum" value=#qry.STREETNUMBER#>
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
                                            <input type="text" class="form-control" id="street" name="street" value=#qry.STREETNAME#>
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
                                            <input type="text" class="form-control" id="city" name="city" value=#qry.CITY#>
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
                                                <option selected hidden value=#qry.STATE#>#qry.STATE#</option>
                                            
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
                                            <input type="number" class="form-control" id="zip" name="zip" value=#qry.ZIPCODE#>
                                        </cfoutput>
                                    </div>  
                                </td>
                            </tr>
                        </table> 
                    </div>

                        <div class="d-grid gap-2 col-3 mx-auto">
                            <div class="btn btn-secondary">
                                 <!--- <a role="button" href="javascript: validateForm();">Submit</a> --->  
                                 <input style="background-color:rgba(0,0,0,0); border:none; color:white; text-decoration:underline" type="submit" value="Submit" onclick="return validateForm()" name="submit" id="submit"> 
                            </div>     
                            <div class="btn btn-secondary">
                                <cfoutput>
                                    <a href="/terminateEmp.cfm?ID=#qry.EMPLOYEEID#">Terminate</a> 
                                </cfoutput>
                           </div>   
                            
                            <div class="btn btn-secondary">
                                <a href="javascript: history.go(-1);">Return</a>
                            </div> 
                        </div>
                    </form>
                <cfinclude  template="/footer.cfm"> 
        <cfelse>
            <cfset session.Errors.append("Please make sure you have appropriate privileges to access this content.")>
            <cflocation  url="/errPage.cfm" addtoken="no">  
        </cfif>
    <cfelse>
        <cflocation  url="/login.cfm" addtoken="no">  
    </cfif>
<cfelse>
    <cflocation  url="/logout.cfm" addtoken="no">  
</cfif>




                
                        <!---
                        <div class="flex-container group">
                         <h1 class="sm-title">Employee Info</h1>
                             <div class="form-input">
                                <label for="fname">First Name:</label>
                                 <input type="text" class="form-control" id="fname" name="fname" value=#uQry.FIRSTNAME#>
                             </div>                   
        
                             <div class="form-input">
                                <label for="lname">Last Name:</label>
                                 <input type="text" class="form-control" id="lname" name="lname" value=#uQry.LASTNAME#>
                             </div>    

                             <div class="form-input">
                                <label for="tel">Phone Number:</label>
                                <cfset cleanPhoneNumber = reReplace(#uQry.TEL#, "[^0-9]", "", "ALL")>
                                
                                <cfset phoneFormatted = "(#left(cleanPhoneNumber, 3)#) #mid(cleanPhoneNumber, 4, 3)#-#right(cleanPhoneNumber, 4)#">
                                
                                <input type="text" class="form-control" id="tel" name="tel" value='#phoneFormatted#'>
                            </div>  
        
                             <div class="form-input">
                                <label for="suffix">Name Suffix:</label>
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

                             </div>
                             
                        </div>

                        <!----------        ----------------------------------------------------------------- USERNAME INFO --------------------------------------------------------------------------------------------------------------->
                                           
                        <div class="flex-container group">
                            <h1 class="sm-title">User Info</h1>
                            <div class="form-input">
                                <label for="company">Company:</label>
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

                            </div>
                            
        
            
                            <div class="form-input">
                                <label for="email">Email Address:</label>
                                <input type="text" class="form-control" id="email" name="email" value=#uQry.EMAIL#>
                            </div>         
        
                            <div class="form-input">
                                <label for="username">Username:</label>
                                <input type="text" class="form-control" id="username" name="username" value=#uQry.USERNAME#>
                            </div>  
        
                            <div class="form-input">
                                <label for="pass">Password:</label>
                                <input type="password" class="form-control" id="pass" name="pass" value=#uQry.PASS#>
                            </div>  
        
                            <div class="form-input">
                                <label for="confPass">Confirm Password:</label>
                                <input type="password" class="form-control" id="confPass" name="confPass" value="">
                            </div>  
        
                        </div>
                        <!----------        ----------------------------------------------------------------- ADDRESS INFO --------------------------------------------------------------------------------------------------------------->
                        <div class="flex-container group">
                            <h1 class="sm-title">Contact Info</h1>
                            <div class="form-input">
                                <label for="streetNum">Street Number:</label>
                                <input type="number" class="form-control" id="streetNum" name="streetNum" value=#addr.STREETNUMBER#>
                            </div>
        
                            <div class="form-input">
                                <label for="street">Street Name:</label>
                                <input type="text" class="form-control" id="street" name="street" value=#addr.STREETNAME#>
                            </div>
        
                            <div class="form-input">
                                <label for="city">City Name:</label>
                                <input type="text" class="form-control" id="city" name="city" value=#addr.CITY#>
                            </div>
        
                            <div class="form-input">
                                <label for="state">State:</label>
                                <select name="state" id="state" class="form-select-md mb-3" id="state">
                                    <option selected hidden value=#addr.STATE#>#addr.STATE#</option>
                    
                                    <cfloop query="states">
                                        <option>#states.STATEINITIALS#</option>
                                    </cfloop>
                                </select>
                            </div>
                            
        
                            <div class="form-input">
                                <label for="zip">Zip Code:</label>
                                <input type="text" class="form-control-sm" id="zip" name="zip" value=#addr.ZIPCODE#>
                            </div>
                        </div>

                    --->


                    <!---
                            <div class="d-grid gap-2 col-6 mx-auto">
                                <input class="btn btn-secondary" type="submit" value="Submit" onclick="return validateForm()" name="submit" id="submit">
                            </div>
                    </form>
                    <div class="d-grid gap-2 col-6 mx-auto btn btn-secondary">
                        <a href="javascript: history.go(-1);">Return</a>
                    </div>
                </div>
            <cfinclude  template="/footer.cfm"> 
        <cfelse>
            <cfset session.Errors.append("Please make sure you have appropriate privileges to access this content.")>
            <cflocation  url="/errPage.cfm" addtoken="no">    
        </cfif>
    </cfif>
</cfif>
--->