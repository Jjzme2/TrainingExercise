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
                <cfset session.Errors = []>
                <form action="/Gateway/AddCompany.cfm" name="companyForm" method="post" id="companyForm">
<!---------------------------------------------------------------------------Contact Info --------------------------------------------------------------------------------------------------------------->
                    <div class="flex-container group">
                        <div class="form-floating mb-3">
                            <label for="companyName">Company:</label>
                            <input type="text" class="form-control" id="companyName" name="companyName" value="">
                        </div>

                            <div class="form-input">
                                <cfoutput>
                                    <select name="state" id="state" class="form-select-md mb-3" id="state">
                                        <option selected hidden value="">Make Selection</option>
                                    
                                        <cfloop query="states">
                                            <option>#states.STATEINITIALS#</option>
                                        </cfloop>
                                    </select>
                                </cfoutput>
                            </div>
<!---------------------------------------------------------------------------submit --------------------------------------------------------------------------------------------------------------->
                    </div>
                    <div class="d-grid gap-2 col-2 mx-auto">
                        <input class="btn btn-secondary" type="submit" value="Submit" onclick="return validateCompany()" name="submit" id="submit">
                    </div>
                </form>
                <div class="d-grid gap-2 col-2 mx-auto mt-3">
                    <a class="btn btn-secondary" href="javascript: history.go(-1);">Return</a>
                </div>
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
