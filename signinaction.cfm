<cfset session.Errors=arrayNew(1)>
<cfset user = structNew()>

<cfif structKeyExists(session, 'IsLoggedIn')>
    <cfif session.IsLoggedIn EQ 1>
        <cflocation  url="welcome.cfm" addtoken="no"> <!--- Already Logged in -- Go Home --->
    <cfelse>
        <cfif isDefined("form.loginSubmit")> <!--- Came from Login --->
            <cfquery name="qry" datasource="empdeets">
                SELECT 
                u.EmployeeID
                ,u.USERNAME
                ,u.PASS
                ,u.LASTLOGIN
                ,u.LOGINCOUNT
                ,u.ISADMIN
                ,e.ISACTIVE 
                FROM TBL_USERS u
                left join TBL_Employee e on e.EmployeeID=u.EmployeeID
                WHERE USERNAME =<cfqueryparam value=#form.username# cfsqltype="CF_SQL_nvarchar">
                and PASS=<cfqueryparam value=#form.password# cfsqltype="CF_SQL_nvarchar">
            </cfquery>

            <cfif len(#qry#) GT 0>      <!--- User Found --->
                <cfif qry.ISACTIVE EQ 1> <!--- Good User --->
                    <cfset session.started = 'true'>
                    <cfquery datasource="empdeets">
                        UPDATE TBL_USERS
                        SET LASTLOGIN = #now()#,
                        LOGINCOUNT = LOGINCOUNT + 1
                        WHERE USERNAME=<cfqueryparam value=#form.username# cfsqltype="CF_SQL_nvarchar"> 
                    </cfquery>

                    <cfset session.User=#qry#> 

                    <cfset session.IsLoggedIn="true">
                    <cfdump  var=#session.User#>
                <cfelse>
                    <cfset session.Errors.append("This is not a valid user.")>
                </cfif>
            <cfelse>
                <cfset session.Errors.append("Unable to find a user with those credentials.")>
            </cfif>
        <cfelse>
            <cfset session.Errors.append("How did you get here?")>
        </cfif>
    </cfif>
</cfif>    

<cfif len(session.Errors) GT 0>
    <cflocation url="/errPage.cfm" addToken="no">
<cfelse>
    <cflocation  url="/welcome.cfm" addtoken="no">
</cfif>