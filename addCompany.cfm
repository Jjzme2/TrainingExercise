<cfif !structKeyExists(session, "started")>
    <cfset session.started="false">
    <cflocation  url="/login.cfm" addtoken="no">
</cfif>

<cfif session.started eq "true">
    <cfif session.IsLoggedIn eq "true">
        <cfif session.User.ISADMIN EQ "true">
<!---------------------------------------------------------------------------Query Info --------------------------------------------------------------------------------------------------------------->    
    
            <cfquery name="states" datasource="empdeets">
                SELECT 
                STATEINITIALS
                ,STATENAMEFULL
                FROM TBL_States 
                ORDER BY STATEINITIALS ASC;
            </cfquery>

            <cfinclude  template="header.cfm"> 
            <cfinclude  template="/navbar.cfm">


            <cfoutput>
                <h1 class="error-text" id="error-text"></h1>

                <form action="/Gateway/AddCompany.cfm" name="companyForm" method="post" id="companyForm">
<!---------------------------------------------------------------------------Contact Info --------------------------------------------------------------------------------------------------------------->
                    <div class="flex-container group">

                        <div class="form-floating mb-3">
                            <input type="text" class="form-control" id="companyName" name="companyName" placeholder="The Company" value="">
                            <label for="companyName">Company:</label>
                        </div>
<!---------------------------------------------------------------------------submit --------------------------------------------------------------------------------------------------------------->
                    </div>
                    <div class="d-grid gap-2 col-2 mx-auto">
                        <input class="btn-secondary" type="submit" value="Submit" name="submit" id="submit">
                    </div>
                </form>
            </cfoutput>
            <cfinclude  template="/footer.cfm"> 

        <cfelse>
            <cfset session.Errors.Append("Please ensure you have appropriate permission to access this content.")>
            <cflocation  url="/errPage.cfm" addToken="no">    
        </cfif>
    <cfelse>
        <cfset session.Errors.Append("Please ensure you have appropriate permission to access this content.")>
        <cflocation  url="/errPage.cfm" addToken="no">  
     </cfif>
    <cfelse>
        <cflocation  url="/login.cfm" addToken="no">  
</cfif>  
