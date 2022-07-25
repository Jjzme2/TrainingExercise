<cfif !structKeyExists(session, "started")>
    <cfset session.started="false">
    <cflocation  url="/login.cfm" addtoken="no">
</cfif>

<cfif session.started eq "true">
    <cfif session.IsLoggedIn eq "true">
        <cfif session.User.ISADMIN EQ "true">
            <cfif session.User.EMPLOYEEID != #URL.ID#>
                <cfquery name="qry" datasource="empdeets">
                    UPDATE TBL_EMPLOYEE
            
                    SET 
                    ISACTIVE = '0'
                    ,RECENTDEACTIVATION = <cfqueryparam value=#DateTimeFormat(Now(), "mm-dd-yyyy")# cfsqltype="cf_sql_date">
            
                    WHERE EMPLOYEEID=<cfqueryparam value=#URL.ID# cfsqltype="CF_SQL_INTEGER">
                </cfquery>
                
                <cflocation  url="/database.cfm" addtoken="no">
            <cfelse>
                <cfset session.Errors.append("You can not deactivate yourself!")>
                <cflocation  url="/errPage.cfm" addtoken="no">
            </cfif>
        <cfelse>
            <cfset session.Errors.append("Please make sure you have appropriate privileges to access this content.")>
            <cflocation  url="/errPage.cfm" addtoken="no">
        </cfif>
    <cfelse>
        <cfset session.Errors.append("Please make sure you have appropriate privileges to access this content.")>
        <cflocation  url="/errPage.cfm" addtoken="no">  
    </cfif>
<cfelse>
    <cflocation  url="/login.cfm" addtoken="no">  
</cfif>
    