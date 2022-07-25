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
            <cfinclude  template="/navbar.cfm">

            <cfoutput>
                <div class="flex-container group">
                    <h1 class="sm-title">Are you sure you want to delete <span class="notable-text">#qry.FIRSTNAME# #qry.LASTNAME#</span></h1>
                    <div class="d-grid gap-2 col-6 mx-auto btn btn-secondary">
                        <a href="/Gateway/Deactivate.cfm?ID=#URL.ID#">Terminate</a>
                    </div>
                    <div class="d-grid gap-2 col-6 mx-auto btn btn-secondary">
                        <a href="javascript: history.go(-1);">Return</a>
                    </div>
                </div>
            </cfoutput>
            <cfinclude  template="/footer.cfm">

        <cfelse>
            <cfset session.Errors.append("Please make sure you have appropriate privileges to access this content.")>
            <cflocation  url="/errPage.cfm" addtoken="no">  
        </cfif>
    </cfif>
</cfif>


