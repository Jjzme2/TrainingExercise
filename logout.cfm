<cfset session.User = {}>
<cfset session.Errors = "">
<cfset session.IsLoggedIn = 0>
<cfset session.started = "false">
<cflocation  url="/login.cfm" addtoken='no'>