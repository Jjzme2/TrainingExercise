<cfif !structKeyExists(session, "started")>
    <cfset session.started="false">
    <cflocation  url="/login.cfm" addtoken="no">
</cfif>

<cfif session.started eq "true">
    <cfif session.IsLoggedIn eq "true">
        <cfif session.User.ISADMIN EQ "true">
<!---------------------------------------------------------------------------Validation --------------------------------------------------------------------------------------------------------------->
        <!--- Action code. First make sure the form was submitted. --->
            <cfif !isDefined("form.submit")>               
                <cfset session.Errors.append("Unable to find a form to check.")>
                <cflocation  url="/errPage.cfm" addtoken="no">
<!---------------------------------------------------------------------------Validation PASS --------------------------------------------------------------------------------------------------------------->
            <cfelse>
                <cfif !isValid("string", #form.companyName#)>
                    <cfset session.Errors.Append("Please make sure you have fully filled out the Company Form when creating a new company.")>
               </cfif>
               
                <cfif len(form.companyName) GT 0>
                    <cfquery name="qry" datasource="empdeets" result="res">
                        INSERT INTO 
                            TBL_Company
                            (
                            COMPANYNAME
                            )
                            VALUES
                            (
                            <cfqueryparam value='#form.companyName#' cfsqltype="cf_sql_NVARCHAR">
                            );
                    </cfquery>
                    <cflocation  url="/login.cfm" addtoken="no">
                <cfelse>
                    <cflocation  url="/errPage.cfm" addtoken="no">                  
                </cfif>

             </cfif>
<!---------------------------------------------------------------------------Redirect --------------------------------------------------------------------------------------------------------------->
        <cfelse>
            <cfset session.Errors.append("Please make sure you have appropriate privileges to access this content.")>
            <cflocation  url="/errPage.cfm" addtoken="no">                  
        </cfif>
    <cfelse>
        <cfset session.Errors.append("Please make sure you have appropriate privileges to access this content.")>
        <cflocation  url="/errPage.cfm" addtoken="no">          <cflocation  url="login.cfm" addtoken="no">
    </cfif>
<cfelse>
    <cflocation  url="/login.cfm" addtoken="no">  
</cfif>