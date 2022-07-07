<cfset theme = "bare">

<cfif structKeyExists(URL, "Theme")>
    <cfset session.Theme=(#lCase(URL.Theme)#)>
</cfif>

<cflocation  url="/welcome.cfm?Theme=#session.Theme#" addtoken="no">
    