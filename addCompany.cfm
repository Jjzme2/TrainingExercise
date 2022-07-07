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

            <cfoutput>
                <form action="/Gateway/AddCompany.cfm" method="post">
<!---------------------------------------------------------------------------Contact Info --------------------------------------------------------------------------------------------------------------->
                    <div class="flex-container group">
                        <div class="form-floating mb-3">
                            <input type="text" class="form-control" id="companyName" name="companyName" placeholder="The Company">
                            <label for="companyName">Company:</label>
                        </div>
<!---------------------------------------------------------------------------submit --------------------------------------------------------------------------------------------------------------->
                        <div class="d-grid gap-2 col-6">
                            <input class="btn btn-secondary" type="submit" value="Add Company" name="submit">
                        </div>
                    </div>
                </form>
            </cfoutput>
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
