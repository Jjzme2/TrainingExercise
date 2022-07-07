<cfif !structKeyExists(session, "IsLoggedIn")>
    <cfset session.IsLoggedIn="false">
</cfif>

<cfif structKeyExists(session, "IsLoggedIn")>
    <cfif #session.IsLoggedIn# EQ 1> <!--- Good User --->  
        <cfif session.USER.ISADMIN EQ 1>
<!---------------------------------------------------------------------------Query Info --------------------------------------------------------------------------------------------------------------->
            <cfquery name="suf" datasource="empdeets">
                Select * 
                FROM TBL_SUFFIX;
            </cfquery>

            <cfquery name="company" datasource="empdeets">
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

            <cfinclude  template="header.cfm"> 


            <cfoutput>
                <form action="/Gateway/Add.cfm" method="post">
<!---------------------------------------------------------------------------Contact Info --------------------------------------------------------------------------------------------------------------->
                    <div class="flex-container group">
                        <h1 class="sm-title">User Info</h1>
                        <div class="form-floating mb-3">
                            <input type="text" class="form-control" id="fname" name="fname" autocomplete="off">
                            <label for="fname">First Name:</label>
                        </div> 

                        <div class="form-floating mb-3">
                            <input type="text" class="form-control" id="lname" name="lname" autocomplete="off">
                            <label for="lname">Last Name:</label>
                        </div> 
            
                        
                        <label for="suffix">Suffix:</label>
                        <select name="suffix" class="form-select-sm" aria-label="Name Suffix dropdown">
                            <option selected disabled hidden>Make Selection</option>
                                <cfloop query="suf">
                                    <option value=#suf.NAME#>#suf.NAME#</option>
                                </cfloop>
                        </select>
 

                        <div class="form-floating mb-3">
                            <input type="text" class="form-control" id="username" name="username" autocomplete="off">
                            <label for="username">Username:</label>
                        </div> 

                        <div class="form-check">
                            <input type="checkbox" class="form-check-input" id="admin" name="admin">
                            <label class="form-check-label" for="admin">Is Admin</label>
                        </div>

                        <div class="form-floating mb-3">
                            <input type="email" class="form-control" id="email" name="email" autocomplete="off">
                            <label for="email">Email:</label>
                        </div> 

                        <div class="form-floating mb-3">
                            <input type="password" class="form-control" id="password" name="password">
                            <label for="password">Password:</label>
                        </div> 
    
                        <div class="form-floating mb-3">
                            <input type="password" class="form-control" id="confPass" name="confPass" autocomplete="off">
                            <label for="confPass">Confirm Password:</label>
                        </div> 
                    </div>                          
                
<!---------------------------------------------------------------------------Address Info --------------------------------------------------------------------------------------------------------------->
                    <div class="flex-container group">
                        <h1 class="sm-title">Contact Info</h1>

                        <div class="form-floating mb-3">
                            <input type="number" class="form-control" id="streetNum" name="streetNum" autocomplete="off">
                            <label for="streetNum">Street Number:</label>
                        </div> 

                        <div class="form-floating mb-3">
                            <input type="text" class="form-control" id="street" name="street" autocomplete="off">
                            <label for="street">Street Name:</label>
                        </div> 

                        <div class="form-floating mb-3">
                            <input type="text" class="form-control" id="city" name="city" autocomplete="off">
                            <label for="city">City:</label>
                        </div> 

                        <label for="state">State:</label>

                        <select name="state" class="form-select-sm" aria-label="State Dropdown">
                                <option selected disabled hidden>Select your state</option>
                            <cfloop query="states">
                                <option value=#states.STATEINITIALS#>#states.STATEINITIALS#</option>
                            </cfloop>
                        </select>

                        <div class="form-floating mb-3">
                            <input type="number" class="form-control" id="zip" name="zip" autocomplete="off">
                            <label for="zip">Zip Code:</label>
                        </div>                       
                    </div>                
                
<!---------------------------------------------------------------------------Hire Info --------------------------------------------------------------------------------------------------------------->
                    <div class="flex-container group">
                        <label for="company">Company:</label>
                    
                        <select name="company" class="form-select-md" aria-label="Company Dropdown">
                            <option selected value=10>Select company</option>
                        <cfloop query="company">
                            <option value=#company.COMPANYID#>#company.COMPANYNAME#</option>
                        </cfloop>
                        </select>
                    
                    
                        <label for="startDate">Start Date:</label>
                        <input type="date" name="startDate" value=#DateFormat(now(),'yyyy-mm-dd')# required>
                        <div class="d-grid gap-2 col-2 mx-auto btn btn-secondary">
                            <input type="submit" value="Submit" name="submit">
                        </div>
                    </div>
                </form>
            </cfoutput>
        <cfelse>
            <cflocation  url="/login.cfm" addToken="no">    
        </cfif>
    <cfelse>
        <cflocation  url="/login.cfm" addToken="no"> 
    </cfif>
<cfelse>
    <cflocation  url="/login.cfm" addToken="no"> 
</cfif>   
