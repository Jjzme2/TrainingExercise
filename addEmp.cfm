<cfif !structKeyExists(session, "IsLoggedIn")>
    <cfset session.IsLoggedIn="false">
</cfif>

<cfif structKeyExists(session, "started")>
    <cfif #session.IsLoggedIn# EQ 1> <!--- Good User --->  
        <cfif session.USER.ISADMIN EQ 1>
            <!--- Start Query --->
            <cfoutput>
                <cfquery name="suf" datasource="empdeets">
                    Select * 
                    FROM TBL_SUFFIX;
                </cfquery>
    
                <cfquery name="companies" datasource="empdeets">
                    Select 
                    COMPANYID
                    ,COMPANYNAME 
                    FROM TBL_Company
                    WHERE COMPANYID != 10
                </cfquery>
    
                <cfquery name="states" datasource="empdeets">
                    SELECT 
                    STATEINITIALS
                    ,STATENAMEFULL
                    FROM TBL_States 
                    ORDER BY STATEINITIALS ASC;
                </cfquery>
            </cfoutput>
            <!--- End Query --->


            <cfinclude  template="header.cfm">
            <cfinclude  template="/navbar.cfm">
            

            <cfset session.Errors = []>
                
                <!--------- FORM START --------->  
                <div class="flex-container mx-auto mt-5" style="width:40%;">
                    <cfoutput>
                        <form class="form" action="/Gateway/Add.cfm?ID=#URL.CompanyID#" name="myForm" id="myForm" method="post">
                    </cfoutput>
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
                                                <input type="text" class="form-control" id="fname" name="fname">
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
                                                <input type="text" class="form-control" id="lname" name="lname">
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
                                                <input type="text" class="form-control" id="tel" name="tel">
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
                                                    <option selected hidden value="-">Make Selection</option>
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
                                                    <cfset companyName = "">
                                                    <cfloop query="companies">
                                                        <cfif companies.COMPANYID EQ #URL.COMPANYID#> 
                                                            <cfset companyName = #companies.COMPANYNAME#>
                                                        </cfif>                                                    
                                                    </cfloop>
                                                    <option>#companyName#</option>
                                                </select>
                                            </cfoutput>
                                        </div>
                                    </td>
                                </tr>

                                <tr>
                                    <th>
                                        Start Date:
                                    </th>
                                    <td>
                                        <div class="form-input">
                                            <cfoutput>
                                                <input type="date" class="form-control" id="startDate" name="startDate" value=#DateFormat(now(),'yyyy-mm-dd')#>
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
                                                <input type="text" class="form-control" id="email" name="email">
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
                                                <input type="text" class="form-control" id="username" name="username">
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
                                                <input type="password" class="form-control" id="pass" name="pass">
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
                                                <input type="password" class="form-control" id="confPass" name="confPass">
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
                                                <input type="number" class="form-control" id="streetNum" name="streetNum">
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
                                                <input type="text" class="form-control" id="street" name="street">
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
                                                <input type="text" class="form-control" id="city" name="city">
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
                                                    <option selected hidden value="">Make Selection</option>
                                                
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
                                                <input type="number" class="form-control" id="zip" name="zip">
                                            </cfoutput>
                                        </div>  
                                    </td>
                                </tr>
                            </table> 
                            
                            <div class="d-grid gap-2 col-3 mx-auto">
                                <div class="btn btn-secondary">
                                     <!--- <a role="button" href="javascript: validateForm();">Submit</a> --->  
                                     <input style="background-color:rgba(0,0,0,0); border:none; color:white; text-decoration:underline" type="submit" value="Submit" onclick="return validateForm()" name="submit" id="submit"> 
                                </div>                    
                                <div class="btn btn-secondary">
                                    <a href="javascript: history.go(-1);">Return</a>
                                </div> 
                            </div>
                        </form>
                    </div>
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
                <div class="flex-container group-nbg">
                    <cfset session.Errors = []>

                    <form class="form" action="/Gateway/Add.cfm" name="myForm" id="myForm" method="post">
<!--------------    -------------------------------------------------------------Contact Info --------------------------------------------------------------------------------------------------------------->
                        <div class="flex-container group">

                            <h1 class="sm-title">User Info</h1>

                            <div class="form-input">
                                 <label for="fname">First Name:</label>
                                 <input type="text" class="form-control" id="fname" name="fname" autocomplete="off" value="">
                             </div>  


                             <div class="form-input">
                                <label for="lname">Last Name:</label>
                                 <input type="text" class="form-control" id="lname" name="lname" autocomplete="off"  value="">
                             </div>  
                        
                             <div class="form-input">
                                <label for="tel">Phone Number:</label>                               
                                <input type="text" class="form-control" id="tel" name="tel" value="">
                            </div>  

                             <div class="form-input">
                                <label for="suffix">Suffix:</label>
                                <select name="suffix" id="suffix" class="form-select-sm" aria-label="Name Suffix Dropdown">
                                        <option selected hidden value="">Make Selection</option>
                                    <cfloop query="suf">
                                        <option value=#suf.NAME#>#suf.NAME#</option>
                                    </cfloop>
                                </select>
                             </div>

                             <div class="form-input">
                                <label for="username">Username:</label>
                                 <input type="text" class="form-control" id="username" name="username" autocomplete="off" value="">
                             </div> 


                            <div class="form-check">
                                <label class="form-check-label" for="admin">Is Admin</label>
                                <input type="checkbox" class="form-check-input" id="admin" name="admin">
                            </div>

                            <div class="form-input">
                                <label for="email">Email Address:</label>
                                <input type="text" class="form-control" id="email" name="email" autocomplete="off"  value="">
                            </div>   


                            <div class="form-input">
                                <label for="pass">Password:</label>
                                <input type="password" class="form-control" id="pass" name="pass" autocomplete="off"  value="">
                            </div> 
                        
                            <div class="form-input">
                                <label for="confPass">Confirm Password:</label>
                                <input type="password" class="form-control" id="confPass" name="confPass" autocomplete="off"  value="">
                            </div> 
                        </div>                          
                    
<!--------------    -------------------------------------------------------------Address Info --------------------------------------------------------------------------------------------------------------->
                        <div class="flex-container group">
                            <h1 class="sm-title">Contact Info</h1>

                            <div class="form-input">
                                <label for="streetNum">Street Number:</label>
                                 <input type="text" class="form-control" id="streetNum" name="streetNum" autocomplete="off" >
                             </div> 


                             <div class="form-input">
                                <label for="street">Street Name:</label>
                                 <input type="text" class="form-control" id="street" name="street" autocomplete="off"  value="">
                             </div> 

                             <div class="form-input">
                                <label for="city">City:</label>
                                 <input type="text" class="form-control" id="city" name="city" autocomplete="off"  value="">
                             </div> 


                             <div class="form-input">
                                <label for="state">State:</label>
                                <select name="state" id="state" class="form-select-sm" aria-label="State Dropdown">
                                        <option selected hidden value="">Make Selection</option>
                                    <cfloop query="states">
                                        <option value=#states.STATEINITIALS#>#states.STATEINITIALS#</option>
                                    </cfloop>
                                </select>
                             </div>


<!--- Change to not have 0 as default
set inactive isavtive buttons
--->
                             <div class="form-input">
                                <label for="zip">Zip Code:</label>
                                 <input type="text" class="form-control" id="zip" name="zip" autocomplete="off">
                             </div> 
                     
                        </div>                
                    
<!--------------    -------------------------------------------------------------Hire Info --------------------------------------------------------------------------------------------------------------->
                        <div class="flex-container group">
                            <h1 class="sm-title">Hire Info</h1>                       

                            <div class="form-input">
                                <label for="company">Company:</label>
                                <select name="company" id="company" class="form-select-sm" aria-label="Company Dropdown">
                                    <cfif structKeyExists(URL, 'CompanyID')>
<!---                Seems like overkill to loop through the query to pull one value.                          --->
                                        <cfloop query="company">
                                            <cfif company.CompanyID == #URL.CompanyID#>
                                                <option selected hidden value=#URL.CompanyID#>#company.COMPANYNAME#</option>
                                            </cfif>
                                        </cfloop>                                        
                                    <cfelse>
                                        <option selected hidden value="10">Make Selection</option>

                                        <cfloop query="company">
                                            <option value=#company.COMPANYID#>#company.COMPANYNAME#</option>
                                        </cfloop>
                                    </cfif>
                                </select>
                             </div>
                        
                             <div class="form-input">
                                <label for="startDate">Start Date:</label>
                                <input type="date" class="form-control" id="startDate" name="startDate" value=#DateFormat(now(),'yyyy-mm-dd')#>
                            </div>
                        </div>
                        <div class="d-grid gap-2 col-2 mx-auto mt-3">
                            <input class="btn btn-secondary" type="submit" value="Submit" onclick="return validateForm()" name="submit" id="submit">
                        </div>
                        <div class="d-grid gap-2 col-2 mx-auto mt-3">
                            <a class="btn btn-secondary" href="javascript: history.go(-1);">Return</a>
                        </div>
                    </form>
                </div>
            --->
  
