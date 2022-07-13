<cfif !structKeyExists(session, "started")>
    <cfset session.started="false">
    <cflocation  url="/login.cfm" addtoken="no">
</cfif>

<cfif session.started eq "true">
    <cfif session.IsLoggedIn eq "true">
<!--------------------------------------------------------------------------- Queries --------------------------------------------------------------------------------------------------------------->

        <cfquery name="qry" datasource="empdeets" result="res">
            SELECT 
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
            ,e.RECENTDEACTIVATION
            FROM TBL_COMPANY c
            join TBL_Employee e on c.COMPANYID=e.COMPANYID
            WHERE c.COMPANYID=<cfqueryparam value=#URL.ID# cfsqltype="CF_SQL_INTEGER">
            ORDER BY  c.COMPANYNAME ASC, e.ISACTIVE DESC, e.LASTNAME ASC, e.FIRSTNAME ASC
        </cfquery>
<!--------------------------------------------------------------------------- Page --------------------------------------------------------------------------------------------------------------->
        
            <cfinclude  template="header.cfm">
            <cfinclude  template="/navbar.cfm">

        

        <cfset index=0>
        <cfoutput>
            <div class="flex-container mx-5">
                <cfif res.RECORDCOUNT GT 0>
                        <h1 class="title">#qry.COMPANYNAME# Database</h1>
                        <h1 class="sm-title">Welcome #session.USER.USERNAME# </h1>
                        <table class="table table-striped table-highlighted">
                            <tr>
                                <th>Index</th>
                                <th>Employee Last </th>
                                <th>Employee First </th>
                                <th>Is Active </th>
                            </tr>
                                <cfloop query="qry"> 
                                    <cfset index++>   
                                    <tr>    
                                        <td>
                                            #index#
                                        </td>
                                        <td>
                                            <a href="/fullEmp.cfm?ID=#qry.EMPLOYEEID#">#qry.LASTNAME#</a>
                                        </td>
                                        <td>
                                            <a href="/fullEmp.cfm?ID=#qry.EMPLOYEEID#">#qry.FIRSTNAME#</a>
                                        </td>
                                    
                                        <td>
                                            <cfif qry.ISACTIVE>
                                                <i class="fa-solid fa-thumbs-up"></i>
                                            <cfelse>
                                                <i class="fa-solid fa-handshake-simple-slash"></i>
                                            </cfif>
                                        </td>
                                    </tr>
                                </cfloop>
                        </table>
                    </div>
                <cfelse>
                    <cfif #session.USER.ISADMIN# EQ 1>
                        <h3>Hmm, seems like we're a newer company, let's add some employees!</h3>
                        <br>
                    <cfelse>
                        <h3>Hmm, seems like we're a newer company, please contact an administrator to add some employees!</h3>
                    </cfif>
                </cfif>
                <div class="d-grid gap-2 col-2 mx-auto btn btn-secondary">
                    <a href="addEmp.cfm">Add Employee</a>
                </div>
                <div class="d-grid gap-2 col-2 mx-auto btn btn-secondary">
                    <a href="welcome.cfm">Go Home</a>
                </div>
            </div>
        </div>
        </cfoutput>
        <cfinclude  template="/footer.cfm"> 

    <cfelse>
        <cfset session.Errors.Append("Please ensure you have appropriate permission to access this content.")>
        <cflocation  url="/errPage.cfm" addToken="no"> 
    </cfif>
<cfelse>
    <cflocation  url="/login.cfm" addToken="no"> 
</cfif>