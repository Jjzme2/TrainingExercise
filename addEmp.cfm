<cfif !structKeyExists(session, "IsLoggedIn")>
    <cfset session.IsLoggedIn="false">
</cfif>

<cfif structKeyExists(session, "IsLoggedIn")>
    <cfif #session.IsLoggedIn# EQ 1> <!--- Good User --->  
        <cfif session.USER.ISADMIN EQ 1>
            <cfoutput>

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
                <cfinclude  template="/navbar.cfm">

                <div class="flex-container group-nbg">
                    <h1 class="error-text" id="error-text"></h1>

                    <form class="form" action="/Gateway/Add.cfm" name="myForm" id="myForm" method="post">
<!--------------    -------------------------------------------------------------Contact Info --------------------------------------------------------------------------------------------------------------->
                        <div class="flex-container group">

                            <h1 class="sm-title">User Info</h1>

                            <div class="form-input">
                                <label for="fname">First Name:</label>
                                 <input type="text" class="form-control" id="fname" name="fname" autocomplete="off"  value="">
                             </div>  


                             <div class="form-input">
                                <label for="lname">Last Name:</label>
                                 <input type="text" class="form-control" id="lname" name="lname" autocomplete="off"  value="">

                             </div>  
                        

                             <div class="form-input">
                                <label for="suffix">Suffix:</label>
                                <select name="suffix" class="form-select-sm" aria-label="Name Suffix Dropdown">
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
                                 <input type="text" class="form-control" id="streetNum" name="streetNum" autocomplete="off"  value="0">
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
                                <select name="state" class="form-select-sm" aria-label="State Dropdown">
                                        <option selected hidden value="">Make Selection</option>
                                    <cfloop query="states">
                                        <option value=#states.STATEINITIALS#>#states.STATEINITIALS#</option>
                                    </cfloop>
                                </select>
                             </div>



                             <div class="form-input">
                                <label for="zip">Zip Code:</label>
                                 <input type="text" class="form-control" id="zip" name="zip" autocomplete="off"  value="0">
                             </div> 
                     
                        </div>                
                    
<!--------------    -------------------------------------------------------------Hire Info --------------------------------------------------------------------------------------------------------------->
                        <div class="flex-container group">
                            <h1 class="sm-title">Hire Info</h1>                       

                            <div class="form-input">
                                <label for="company">Company:</label>
                                <select name="company" class="form-select-sm" aria-label="Company Dropdown">
                                        <option selected hidden value="10">Make Selection</option>
                                    <cfloop query="company">
                                        <option value=#company.COMPANYID#>#company.COMPANYNAME#</option>
                                    </cfloop>
                                </select>
                             </div>
                        
                             <div class="form-input">
                                <label for="startDate">Start Date:</label>
                                <input type="date" class="form-control" id="startDate" name="startDate" value=#DateFormat(now(),'yyyy-mm-dd')#>
                            </div>
                        </div>
                        <div class="d-grid gap-2 col-2 mx-auto">
                            <input class="btn-secondary" type="submit" value="Submit" name="submit" id="submit">
                        </div>
                    </form>
                </div>
            </cfoutput>
            <cfinclude  template="/footer.cfm"> 
        <cfelse>
            <cflocation  url="/login.cfm" addToken="no">    
        </cfif>
    <cfelse>
        <cflocation  url="/login.cfm" addToken="no"> 
    </cfif>
<cfelse>
    <cflocation  url="/login.cfm" addToken="no"> 
</cfif>   
