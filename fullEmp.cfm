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
<!--------------------------------------------------------------------------- Page --------------------------------------------------------------------------------------------------------------->

        <cfinclude  template="header.cfm">
        <cfoutput>
            <div class="flex-container mx-auto">

                <div class="card group">
                    <div class="sm-title">
                        Employee Information:
                        <br>
                        <span class="username-text">#qry.USERNAME#</span>
                        <cfif #qry.ISADMIN# EQ 1>
                            (Admin)
                        <cfelse>
                            (User)
                        </cfif>
                    </div>

                    <div>
                        <h1 class="notable-text">User Info</h1>
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item"><span class="notable-text">Last: </span> #qry.LASTNAME#</li>
                            <li class="list-group-item"><span class="notable-text">First: </span> #qry.FIRSTNAME#</li>
                            <li class="list-group-item"><span class="notable-text">Email: </span> #qry.EMAIL#</li>
                    </div>
                    <div>
                        <h1 class="notable-text">Activity</h1>
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item"><span class="notable-text">Active Since: </span> #DateTimeFormat(qry.RECENTACTIVATION, "yyyy-mm-dd")#</li>
                            <li class="list-group-item"><span class="notable-text">Hire Date: </span> #DateTimeFormat(qry.HIREDATE, "yyyy-mm-dd")#</li>
                            <li class="list-group-item"><span class="notable-text">Start Date: </span> #DateTimeFormat(qry.STARTDATE, "yyyy-mm-dd")#</li>
                            <li class="list-group-item"><span class="notable-text">Last Login: </span> #DateTimeFormat(qry.LASTLOGIN, "yyyy-mm-dd")#</li>
                    </div>
                    <div>
                        <cfif #session.USER.ISADMIN#>
                            <legend class="notable-text">Permissions: </legend>
                            <cfif qry.ISACTIVE EQ 1>
                                <div class="d-grid gap-2 mx-auto btn btn-secondary">
                                    <a href="/modifyEmp.cfm?ID=#URL.ID#">Modify</a>
                                </div>
                                <div class="d-grid gap-2 mx-auto btn btn-secondary">
                                    <a href="/terminateEmp.cfm?ID=#URL.ID#">Terminate</a>
                                </div>
                            <cfelse>
                                <cfif qry.COMPANYID NEQ 10>
                                    <div class="d-grid gap-2 mx-auto btn btn-secondary">
                                        <a href="/Gateway/Activate.cfm?ID=#URL.ID#">Activate</a>
                                    </div>
                                <cfelse>
                                    <div>
                                        <form action="/Gateway/addToCompany.cfm?ID=#qry.EMPLOYEEID#" method="post">
                                            <select name="company">
                                                <option selected disabled value="">Select a company</option>
                                                <cfloop query="companies">
                                                    <option value=#companies.COMPANYID#>#companies.COMPANYNAME#</option>
                                                </cfloop>
                                            </select>
                                            <input type="submit" value="Submit">
                                        </form>
                                    </div>
                                </cfif>
                            </cfif>
                        </cfif>
                        <div class="d-grid gap-2 mx-auto btn btn-secondary">
                            <cfif #qry.COMPANYID# NEQ 10>
                                <a href="/company.cfm?ID=#qry.CompanyID#">Return to Company</a>
                            <cfelse>
                                <a href="/database.cfm">Return to Database</a>
                            </cfif>
                        </div>
                    </div>
                </div>
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
