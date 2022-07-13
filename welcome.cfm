<!--------------------------------------------------------------------------- Validation --------------------------------------------------------------------------------------------------------------->

<cfif !structKeyExists(session, "started")>
    <cfset session.started="false">
    <cflocation  url="/login.cfm" addtoken="no">
</cfif>

<cfif session.started eq "true">
    <cfif session.IsLoggedIn eq "true">    
<!--------------------------------------------------------------------------- Queries --------------------------------------------------------------------------------------------------------------->
        
        <cfquery name="actives" datasource="empdeets">
            SELECT *
            FROM TBL_Employee
            WHERE ISACTIVE=<cfqueryparam value=1 cfsqltype="CF_SQL_INTEGER">
            ORDER BY LASTNAME ASC, FIRSTNAME ASC
        </cfquery>

        <cfquery name="inactives" datasource="empdeets">
            SELECT *
            FROM TBL_Employee
            WHERE ISACTIVE=<cfqueryparam value=0 cfsqltype="CF_SQL_INTEGER">
            ORDER BY LASTNAME ASC, FIRSTNAME ASC
        </cfquery>

        <cfquery name="companies" datasource="empdeets" result="res">
            SELECT 
            COMPANYNAME
            ,COMPANYID
            FROM TBL_Company
            WHERE COMPANYID != 10
            ORDER BY COMPANYID ASC
        </cfquery>
                   
<!--------------------------------------------------------------------------- Page --------------------------------------------------------------------------------------------------------------->
        
        <cfinclude  template="/header.cfm"> 
        <cfinclude  template="/navbar.cfm">

        <cfset session.Errors = []>
        <cfoutput>
            <div class="flex-container mx-5">
                <h1 class="title">Welcome, #session.user.USERNAME#</h1>
                <p class="notable-text">
                    Last Login: #dateFormat(session.user.LASTLOGIN, 'mm-dd-yyyy')#
                    @ #timeFormat(session.user.LASTLOGIN, 'hh:mm tt')#
                </p> 
    
                <h3 class="sm-title">#res.RECORDCOUNT# Companies:</h3>
    
                <cfset index = 0>            
                <table class="table table-striped table-highlighted">
                        <th>
                            Index
                        </th>

                        <th>
                            Company Name
                        </th>
                        <cfloop query="companies">
                            <cfset index++>
                            <tr>    
                                <td>#index#</td>
                                <!---
                                    <td>#companies.COMPANYID#</td>
                                --->
                                <td>
                                        <a href="company.cfm?ID=#companies.COMPANYID#">#companies.COMPANYNAME#</a>
                                </td>
                            </tr>
    
                        </cfloop>
                </table>   
                
                    <br>
                <cfif #session.USER.ISADMIN#>
                    <div class="d-grid gap-2 col-6 mx-auto btn btn-secondary">
                    <a href="addCompany.cfm">Add Company</a>
                    </div>
                </cfif>
            </div>
            
        </cfoutput>
            
        <cfinclude  template="footer.cfm"> 
    <cfelse>
        <cflocation  url="/login.cfm" addtoken='no'> <!--- Bad User --->
    </cfif>
<cfelse>
    <cflocation  url="/login.cfm" addtoken='no'> <!--- Bad User --->
</cfif>    