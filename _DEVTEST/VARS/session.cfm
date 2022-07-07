<cfif !structKeyExists(session, "started")>
    <cfset session.started="false">
    <cflocation  url="/login.cfm" addtoken="no">
</cfif>

<cfif session.started eq "true">
    <cfif session.IsLoggedIn eq "true">
        <cfif session.User.ISADMIN EQ "true">

            <cfinclude  template="/header.cfm">
            <cfdump  var=#session#>
            <cfdump  var=#server#>
            <cfdump  var=#cgi#>
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