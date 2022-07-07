<cfif !structKeyExists(session, "started")>
    <cfset session.started="false">
    <cflocation  url="/login.cfm" addtoken="no">
</cfif>

<cfif session.started eq "true">
    <cfif session.IsLoggedIn eq "true">    
        <cfif #session.USER.ISADMIN#>
<!--------------------------------------------------------------------------- Queries --------------------------------------------------------------------------------------------------------------->
            <cfquery name="qry" datasource="empdeets">
                SELECT *
                FROM TBL_EMPLOYEE
                WHERE EMPLOYEEID=<cfqueryparam value=#URL.ID# cfsqltype="CF_SQL_INTEGER">
            </cfquery>
<!------    --------------------------------------------------------------------- Page --------------------------------------------------------------------------------------------------------------->
            <cfinclude  template="/header.cfm">
            <cfoutput>
                <div class="flex-container mx-5 group">
                    <h1 class="sm-title">Are you sure you want to delete <span class="notable-text">#qry.FIRSTNAME# #qry.LASTNAME#</span></h1>
                    <a class="btn btn-secondary" href="/Gateway/Deactivate.cfm?ID=#URL.ID#">Terminate</a>
                </div>
            </cfoutput>
            <cfinclude  template="/footer.cfm">

        <cfelse>
            <cfset session.Errors.append("Please make sure you have appropriate privileges to access this content.")>
            <cflocation  url="/errPage.cfm" addtoken="no">  
        </cfif>
    </cfif>
</cfif>


