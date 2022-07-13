<cfif !structKeyExists(session, "started")>
    <cfset session.started="false">
    <cflocation  url="/login.cfm" addtoken="no">
</cfif>

<cfif session.started eq "true">
    <cfif session.IsLoggedIn eq "true">
        <cfif session.User.ISADMIN EQ "true">
<!--------------------------------------------------------------------------- Queries --------------------------------------------------------------------------------------------------------------->

            <cfquery name="qry" datasource="empdeets" result="res">
                SELECT 
                c.COMPANYNAME
                ,c.COMPANYID
                ,e.EMPLOYEEID
                ,e.FIRSTNAME
                ,e.LASTNAME
                ,e.ISACTIVE
                ,e.COMPANYID
                FROM TBL_COMPANY c
                join TBL_Employee e on c.COMPANYID=e.COMPANYID
                WHERE c.COMPANYID != 10
                ORDER BY  c.COMPANYNAME ASC, e.ISACTIVE DESC, e.LASTNAME ASC, e.FIRSTNAME ASC
            </cfquery>

            <cfquery name="pool" datasource="empdeets" result="poolRes">
                SELECT 
                c.COMPANYNAME
                ,c.COMPANYID
                ,e.EMPLOYEEID
                ,e.FIRSTNAME
                ,e.LASTNAME
                ,e.ISACTIVE
                ,e.COMPANYID
                FROM TBL_COMPANY c
                join TBL_Employee e on c.COMPANYID=e.COMPANYID
                WHERE c.COMPANYID = 10
                ORDER BY e.LASTNAME ASC, e.FIRSTNAME ASC
            </cfquery>
<!--------------------------------------------------------------------------- Page --------------------------------------------------------------------------------------------------------------->
            <cfinclude  template="header.cfm">
            <cfinclude  template="/navbar.cfm">

            <cfset index=0>
            <cfoutput>
                <div>
                    <h1 class="title">Employee Database:</h1>
                    <cfif res.RECORDCOUNT GT 0>
                        <div class="flex-container mx-5">
                            <table class="table table-striped table-highlighted">
                                <tr>
                                    <th>Index </th>
                                    <th>Company </th>
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
                                            <a href="/fullEmp.cfm?ID=#qry.COMPANYID#">#qry.COMPANYNAME#</a>
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
                            <h3>Hmm, Let's fill this out a bit more!</h3>
                            <br>
                        <cfelse>
                            <h3>Hmm, seems like we're a newer company, please contact an administrator to add some employees!</h3>
                        </cfif>
                    </cfif>
                    <br>
    
                    <div class="flex-container">
                        <cfset poolIndex=0>  

                        <h1 class="sm-title">Employee Pool:</h1>

                        <table class="table table-sm table-striped table-highlighted">
                            <tr>
                                <th>Index </th>

                                <th>Last Name</th>
                                <th>First Name</th>
                            </tr>
                            <cfloop query="pool">
                                <cfset poolIndex++>  

                                <tr>
                                    <td>#poolIndex#</td>
                                    <td>
                                        <a href="/fullEmp.cfm?ID=#pool.EMPLOYEEID#">#pool.LASTNAME#</a>
                                    </td>
                                    <td>
                                        <a href="/fullEmp.cfm?ID=#pool.EMPLOYEEID#">#pool.FIRSTNAME#</a>
                                    </td>
                                </tr>
                            </cfloop>
                        </table>
                        
                        <div class="d-grid gap-2 col-2 mx-auto btn btn-secondary">
                        <a href="addEmp.cfm?COMPANYID=#qry.COMPANYID#">Add Employee</a>
                        </div>
                        <div class="d-grid gap-2 col-2 mx-auto btn btn-secondary">
                            <a href="welcome.cfm">Go Home</a>
                        </div>                        
                </div>
            </cfoutput>
            <cfinclude  template="footer.cfm">
        <cfelse>
            <cfset session.Errors.Append("Please ensure you have appropriate permission to access this content.")>
            <cflocation  url="/errPage.cfm" addToken="no">  
        </cfif>
    <cfelse>
        <cfset session.Errors.Append("Please ensure you have appropriate permission to access this content.")>
        <cflocation  url="/errPage.cfm" addToken="no">  
    </cfif>
<cfelse>
    <cflocation  url="/login.cfm" addToken="no"> 
</cfif>