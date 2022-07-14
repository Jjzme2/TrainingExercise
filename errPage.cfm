
<cfinclude  template="/header.cfm">

<cfif structKeyExists(session, "Errors")>
    <div class="flex-container group">
        <div class="page-view">
            <p class="sm-title">Errors:</p>
        <cfloop array="#session.Errors#" item="item">
            <cfoutput>
                <p id="error-text">#item#</p>
            </cfoutput>
        </cfloop>
        </div>
    </div>
    <div class="d-grid gap-2 col-4 mx-auto btn btn-secondary">
        <a href="javascript: history.go(-1);">Go back</a>
    </div>
</cfif>
<cfinclude  template="/footer.cfm">

