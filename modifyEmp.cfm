<cfif !structKeyExists(session, "started")>
    <cfset session.started="false">
    <cflocation  url="/login.cfm" addtoken="no">
</cfif>


<cfif session.started eq "true">
    <cfif session.IsLoggedIn eq "true">    
        <cfif #session.User.ISADMIN#>
            <!--------------------------------------------------------------------------- Queries --------------------------------------------------------------------------------------------------------------->
<!--- Could be nicer, by explicitly calling the necessary columns, less resource intensive --->
            <cfoutput>    
                <cfquery name="qry" datasource="empdeets">
                    SELECT EMP.*, S.* 
                    FROM TBL_EMPLOYEE EMP
                    LEFT JOIN TBL_SUFFIX S 
                    ON EMP.NAMESUFFIX=S.NAME
                    WHERE EMPLOYEEID=<cfqueryparam value=#URL.ID# cfsqltype="CF_SQL_INTEGER">
                </cfquery>
    
                <cfquery name="addr" datasource="empdeets">
                    SELECT EMP.*, A.* 
                    FROM TBL_EMPLOYEE EMP
                    LEFT JOIN TBL_Address A 
                    ON EMP.EMPLOYEEID=A.EMPLOYEEID
                    WHERE A.EMPLOYEEID=<cfqueryparam value=#URL.ID# cfsqltype="CF_SQL_INTEGER">
                </cfquery>

                <cfquery name="uQry" datasource='empdeets'>
                    SELECT EMP.*, U.*
                    FROM TBL_EMPLOYEE EMP
                    LEFT JOIN TBL_USERS U ON EMP.EMPLOYEEID=U.EMPLOYEEID
                    WHERE U.EMPLOYEEID=<cfqueryparam value=#URL.ID# cfsqltype="CF_SQL_INTEGER">
                </cfquery>

                <cfquery name="suf" datasource="empdeets">
                    Select *
                    FROM TBL_SUFFIX;--->
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
                    WHERE COMPANYID != 10 
                    ORDER BY COMPANYNAME ASC;
                </cfquery>

<!--------------------------------------------------------------------------- FORM START --------------------------------------------------------------------------------------------------------------->
                <cfinclude  template="/header.cfm"> 
                <cfinclude  template="/navbar.cfm">

                
                <cfset companyName = #qry.COMPANYID#>
                <cfloop query="companies">
                    <cfif companies.COMPANYID EQ qry.COMPANYID> 
                        <cfset companyName = #companies.COMPANYNAME#>
                    </cfif>
                </cfloop>



                <div class="flex-container group-nbg">

<!---                     <h1 class="error-text" id="error-text"></h1> --->

                    <form class="form" action="/Gateway/Modify.cfm?ID=#uQry.EMPLOYEEID#" name="myForm" id="myForm" method="post">
                        <!--------------------------------------------------------------------------- NAME INFO --------------------------------------------------------------------------------------------------------------->
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
                        <div class="d-grid gap-2 col-2 mx-auto mt-3">
                            <input class="btn-secondary" type="submit" value="Submit" onclick="return validateForm(this)" name="submit" id="submit">
                        </div>
                    </form>
                </div>
               
            </cfoutput>
            <cfinclude  template="/footer.cfm"> 

        <cfelse>
            <cfset session.Errors.append("Please make sure you have appropriate privileges to access this content.")>
            <cflocation  url="/errPage.cfm" addtoken="no">    
        </cfif>
    </cfif>
</cfif>