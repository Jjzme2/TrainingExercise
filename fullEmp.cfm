    <cfif !structKeyExists(session, "started")>
        <cfset session.started="false">
        <cflocation  url="/login.cfm" addtoken="no">
    </cfif>


    <cfif session.started eq "true">
        <cfif session.IsLoggedIn eq "true">
<!--------------------------------------------------------------------------- Queries --------------------------------------------------------------------------------------------------------------->

            <cfquery name="qry" datasource="empdeets">
                SELECT 
                emp.*,
                u.* 
                FROM TBL_EMPLOYEE emp
                left join TBL_Users u on emp.EmployeeID=u.EmployeeID
                WHERE emp.EMPLOYEEID=<cfqueryparam value=#URL.ID# cfsqltype="CF_SQL_INTEGER">
            </cfquery>

            <cfquery name="companies" datasource="empdeets">
                SELECT 
                COMPANYID
                ,COMPANYNAME
                FROM TBL_Company
                WHERE COMPANYID != 10
                ORDER BY COMPANYNAME ASC
            </cfquery>

            <cfquery name="addr" datasource="empdeets">
                SELECT EMP.*, A.* 
                FROM TBL_EMPLOYEE EMP
                LEFT JOIN TBL_Address A 
                ON EMP.EMPLOYEEID=A.EMPLOYEEID
                WHERE A.EMPLOYEEID=<cfqueryparam value=#URL.ID# cfsqltype="CF_SQL_INTEGER">
            </cfquery>
<!--------------------------------------------------------------------------- Page --------------------------------------------------------------------------------------------------------------->

        <cfinclude  template="header.cfm">
        <cfinclude  template="/navbar.cfm">
        <cfoutput>
            <div class="flex-container group-nbg">
                <div class="card group">
                    <h1 class="sm-title">Employee Info</h1>
                    <br>
                    <div class="form-input">
                        <label for="fname">First Name:</label>
                        <input type="text" class="readOnly-input" id="fname" name="fname" value=#qry.FIRSTNAME# readonly>
                    </div>  
                
                    <div class="form-input">
                        <label for="lname">Last Name:</label>
                        <input type="text" class="readOnly-input" id="lname" name="lname" value=#qry.LASTNAME# readonly>
                    </div>
                <cfif isValid("variableName", #qry.NAMESUFFIX#)>
                    <div class="form-input">
                        <label for="suffix">Suffix:</label>
                        <input type="text" class="readOnly-input" id="suffix" name="suffix" value=#qry.NAMESUFFIX# readonly>
                    </div>  
                </cfif>
                </div>
                
                <div class="card group">
                    <h1 class="sm-title">User Info</h1>
                    <br>
                 
                    <div class="form-input">
                        <label for="email">Email Address:</label>
                        <input type="text" class="readOnly-input" id="email" name="email" value=#qry.EMAIL# readonly>
                    </div>
                 
                    <div class="form-input">
                        <label for="username">Username:</label>
                        <input type="text" class="readOnly-input" id="username" name="username" value=#qry.USERNAME# readonly>
                    </div>  
                </div>

                <div class="card group">
                    <h1 class="sm-title">Contact Info</h1>
                    <br>
                    <div class="form-input">
                        <label for="streetNum">Street Number:</label>
                        <input type="number" class="readOnly-input" id="streetNum" name="streetNum" value=#addr.STREETNUMBER# readonly>
                    </div>
                    <div class="form-input">
                        <label for="street">Street Name:</label>
                        <input type="text" class="readOnly-input" id="street" name="street" value=#addr.STREETNAME# readonly>
                    </div>
                
                    <div class="form-input">
                        <label for="city">City Name:</label>
                        <input type="text" class="readOnly-input" id="city" name="city" value=#addr.CITY# readonly>
                    </div>
                
                    <div class="form-input">
                        <div class="form-input">
                            <label for="state">State:</label>
                            <input type="text" class="readOnly-input" id="state" name="state" value=#addr.STATE# readonly
                        </div>
                    </div>
                
                    <div class="form-input">
                        <label for="zip">Zip Code:</label>
                        <input type="text" class="readOnly-input" id="zip" name="zip" value=#addr.ZIPCODE# readonly>
                    </div>
                </div>
            </div>

            <cfif #session.USER.ISADMIN#>
                <cfif qry.ISACTIVE EQ 1>
                    <div class="d-grid gap-2 col-6 mx-auto btn-secondary">
                        <a href="/modifyEmp.cfm?ID=#URL.ID#">Modify</a>
                    </div>
                    <div class="d-grid gap-2 col-6 mx-auto btn-secondary">
                        <a href="/terminateEmp.cfm?ID=#URL.ID#">Terminate</a>
                    </div>
                <cfelse>
                    <cfif qry.COMPANYID NEQ 10>
                        <div class="d-grid gap-2 col-6 mx-auto btn-secondary">
                            <a href="/Gateway/Activate.cfm?ID=#URL.ID#">Activate</a>
                        </div>
                        <cfelse>
                            <div class="d-grid gap-2 col-6 mx-auto btn-secondary">
                            <a href="/modifyEmp.cfm?ID=#URL.ID#">Modify</a>
                        </div>
                    </cfif>
                </cfif>
            </cfif>
            <div class="d-grid gap-2 col-6 mx-auto btn-secondary">
                <cfif #qry.COMPANYID# NEQ 10>
                    <a href="/company.cfm?ID=#qry.CompanyID#">Return to Company</a>
                <cfelse>
                    <a href="/database.cfm">Return to Database</a>
                </cfif>
            </div>
        </cfoutput>

        <cfinclude  template="footer.cfm">
    <cfelse>
        <cfset session.Errors.append("Please make sure you have appropriate privileges to access this content.")>
        <cflocation  url="/errPage.cfm" addtoken="no">  
    </cfif>
<cfelse>
    <cflocation  url="/login.cfm" addToken="no"> 
</cfif>