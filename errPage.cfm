
<cfinclude  template="/header.cfm">
<cfif structKeyExists(session, "Errors")>
    <div class="flex-container group">
        <cfif len(session.Errors) GT 0>
            <p class="sm-title">Errors:</p>
            <cfloop array=#session.Errors# item="item">
                <cfoutput>
                    <p class="error-msg">#item#</p>
                </cfoutput>
                <br>
            </cfloop>
            <cfelse>
                <p>No Errors Found!</p>
                <cflocation  url="/login.cfm" addtoken="no">
            </cfif>
        <div class="d-grid gap-2 col-6 mx-auto btn btn-secondary">
        <a href="/login.cfm">Go back</a>
        </div>
    </div>
</cfif>
<cfinclude  template="/footer.cfm">

