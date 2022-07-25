<!--------------------------------------------------------------------------- Validation --------------------------------------------------------------------------------------------------------------->

<cfif !structKeyExists(session, "started")>
    <cfset session.started="false">
    <cflocation  url="/login.cfm" addtoken="no">
</cfif>

<cfif session.started eq "true">
    <cfif session.IsLoggedIn eq "true">    
<!--------------------------------------------------------------------------- Queries --------------------------------------------------------------------------------------------------------------->
        
        <cfquery name="actives" datasource="empdeets">
            SELECT *
            FROM TBL_Employee
            WHERE ISACTIVE=<cfqueryparam value=1 cfsqltype="CF_SQL_INTEGER">
            ORDER BY LASTNAME ASC, FIRSTNAME ASC
        </cfquery>

        <cfquery name="inactives" datasource="empdeets">
            SELECT *
            FROM TBL_Employee
            WHERE ISACTIVE=<cfqueryparam value=0 cfsqltype="CF_SQL_INTEGER">
            ORDER BY LASTNAME ASC, FIRSTNAME ASC
        </cfquery>

        <cfquery name="companies" datasource="empdeets" result="res">
            SELECT 
            COMPANYNAME
            ,COMPANYID
            FROM TBL_Company
            WHERE COMPANYID != 10
            ORDER BY COMPANYID ASC
        </cfquery>
<!---
        <cfquery name="states" datasource="empdeets">
            SELECT 
            STATEINITIALS
            ,STATENAMEFULL
            FROM TBL_States 
            ORDER BY STATEINITIALS ASC;
        </cfquery>
--->         
<!--------------------------------------------------------------------------- Page --------------------------------------------------------------------------------------------------------------->
        
        <cfinclude  template="/header.cfm"> 
        <cfinclude  template="/navbar.cfm">

        <cfset session.Errors = []>

        <cfoutput>
            <div class="flex-container mx-auto" style="width:80%;" >
                <div class="title-area">
                    <h1 class="title">Welcome, #session.user.USERNAME#</h1>  
                    <h3 class="sm-title">Company Database</h3>
                </div>
        </cfoutput>
            
                <table id="companyTable" class="display dataTable" aria-describedby="companyTable">
                    <thead>
                        <tr>
                            <th class="sorting sorting_asc" tabindex="0" aria-controls="companyTable" rowspan="1" colspan="1" aria-sort="ascending" 
                            aria-label="Company Name: activate to sort column descending" style="width: 131.172px;">Company Name</th>
                        </tr>
                    </thead>
                    <tbody>
                        <cfloop query="companies">
                            <tr id="tableRow">
                                <td>
                                    <cfoutput>
                                        <div class="">
                                            <a href="/company.cfm?ID=#companies.COMPANYID#">#companies.COMPANYNAME#</a>
                                        </div>    
                                    </cfoutput>
                                </td>
                            </tr>
                        </cfloop>
                    </tbody>
                
                    <tfoot>
                    </tfoot>
                
                </table>

                <cfif #session.USER.ISADMIN#>
                    <button type="button" class="d-grid gap-2 col-3 mx-auto btn btn-secondary" data-bs-toggle="modal" data-bs-target="#welcomeModal">
                        Add Company
                      </button>
                    <!--- old button 
                    <div class="d-grid gap-2 col-6 mx-auto btn btn-secondary">
                        <a href="addCompany.cfm">Add Company</a> <!--- Create Modal --->
                    </div>
                --->
                </cfif>
            </div>

<!--------------------------------------------------------------------------- Start Modal --------------------------------------------------------------------------------------------------------------->
            <div class="modal fade" id="welcomeModal" tabindex="-1" aria-labelledby="welcomeModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="welcomeModalLabel">We're excited to work with you!</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <form action="" name="companyForm" method="post" id="companyForm">

                            <div class="modal-body">
                                <div class="flex-container group-nbg">
                                    <table>                                    
                                        <tbody>
                                            <tr>
                                                <th>
                                                    Company:
                                                </th>
                                            
                                                <td>
                                                    <input type="text" class="form-control" id="companyNameInput" name="companyName" value="">
                                                </td>
                                            </tr>
                                            <!---Adding state for company
                                            <tr>
                                                <td>
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
                                                </td>
                                            </tr>
                                        --->
                                        </tbody>
                                    </table>
                                <!---
                                <div class="d-grid gap-2 col-2 mx-auto"> 
                                    <input class="btn btn-secondary" type="submit" value="Submit" onclick="return validateCompany()" name="submit" id="submit">
                                </div>
                                --->
                            </div>

                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                <button role="button" class="btn btn-secondary" type="submit" value="Submit" onclick="return validateCompany(this)" name="submit" id="submit">Submit</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
  
<!--------------------------------------------------------------------------- End Modal --------------------------------------------------------------------------------------------------------------->
    
    <cfinclude  template="footer.cfm"> 
    <cfelse>
        <cflocation  url="/login.cfm" addtoken='no'> <!--- Bad User --->
    </cfif>
<cfelse>
    <cflocation  url="/login.cfm" addtoken='no'> <!--- Bad User --->
</cfif>    