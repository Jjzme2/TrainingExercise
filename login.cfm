<cfif !structKeyExists(session, "started")>
    <cfset session.started="false">
</cfif>

<cfif !structKeyExists(session, 'user')>
    <cfset session.user = {}>
</cfif>
<!--------------------------------------------------------------------------- session.user.name exists --------------------------------------------------------------------------------------------------------------->
<cfif structKeyExists(session.user, 'USERNAME')>
    <cflocation  url="/welcome.cfm" addtoken="no">
<cfelse>
<!--------------------------------------------------------------------------- Not logged in --------------------------------------------------------------------------------------------------------------->
    <cfset session.Errors = []>
    <cfinclude  template="/header.cfm">

    <div class="flex-container mx-auto group">
        <h1 class="brand">Database</h1>
        <form action="/signinaction.cfm" method="post">
            <div class="form-group">
                <label for="username">Username</label>
              <input type="text" class="form-control" id="username" name="username" placeholder="Enter Username">
            </div>
    
            <div class="form-group">
              <label for="password">Password</label>
              <input type="password" class="form-control" id="password" name="password" placeholder="Password">
            </div>
            <button type="submit" class="btn btn-secondary" name="loginSubmit">Log in</button>
          </form>
    </div>

    <cfinclude  template="footer.cfm"> 
</cfif>