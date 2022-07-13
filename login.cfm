<cfif !structKeyExists(session, "started")>
    <cfset session.started="false">
</cfif>

<cfif !structKeyExists(session, 'user')>
    <!--- <cfset session.user = {}> --->
    <!--- This will auto logout users when the server is restarted, preventing the recent problem I've been having where on server restart, I'm unable to login
    with valid credentials.--->
    <cflocation  url="/logout.cfm">
</cfif>
<!--------------------------------------------------------------------------- session.user.name exists --------------------------------------------------------------------------------------------------------------->
<cfif structKeyExists(session.user, 'USERNAME')>
    <cflocation  url="/welcome.cfm" addtoken="no">
<cfelse>
<!--------------------------------------------------------------------------- Not logged in --------------------------------------------------------------------------------------------------------------->
    <cfset session.Errors = []>
    <cfinclude  template="/header.cfm">

    <div class="flex-container group">
        <form  action="/signinaction.cfm" method="post">
            <!---
            <h1 class="brand">Database</h1>
            --->
            <h1 class="form-title">Sign in</h1>

            <div class="form-group">
              <input type="text" class="form-control" id="username" name="username" placeholder="Username">
            </div>
    
            <div class="form-group">
              <input type="password" class="form-control" id="password" name="password" placeholder="Password" onKeyPress="Check()">
            </div>
            <button type="submit" class="btn form-btn" name="loginSubmit">Sign in</button>
          </form>
    </div>

    <!---
    <cfinclude  template="footer.cfm"> 
    --->
</cfif>
