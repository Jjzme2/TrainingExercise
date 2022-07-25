<cfif !structKeyExists(session, "started")>
    <cfset session.started="false">
    <cflocation  url="/login.cfm" addtoken="no">
</cfif>

<cfif session.started eq "true">
    <cfif session.IsLoggedIn eq "true">
        <cfif session.User.ISADMIN EQ "true">
<!--------------------------------------------------------------------------- Queries --------------------------------------------------------------------------------------------------------------->

            <cfquery name="qry" datasource="empdeets" result="res">
                SELECT 
                c.COMPANYNAME
                ,c.COMPANYID
                ,e.EMPLOYEEID
                ,e.FIRSTNAME
                ,e.LASTNAME
                ,e.ISACTIVE
                ,e.COMPANYID
                FROM TBL_COMPANY c
                join TBL_Employee e on c.COMPANYID=e.COMPANYID
                ORDER BY  c.COMPANYNAME ASC, e.ISACTIVE DESC, e.LASTNAME ASC, e.FIRSTNAME ASC
            </cfquery>
<!--------------------------------------------------------------------------- Page --------------------------------------------------------------------------------------------------------------->
            <cfinclude  template="header.cfm">
            <cfinclude  template="/navbar.cfm">


            <cfoutput>
                <div class="flex-container mx-auto" style="width:90%;" >
                    <div class="title-area">
                        <h3 class="sm-title">The Database</h3>
                    </div>
            </cfoutput>
                
                    <table id="databaseTable" class="display dataTable" aria-describedby="databaseTableLabel">
                        <thead>
                            <tr>
                                <th class="sorting sorting_asc" tabindex="0" aria-controls="databaseTableLabel" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Company: activate to sort column descending" style="width: 131.172px;">Company</th>
                                <th class="sorting sorting_asc" tabindex="0" aria-controls="databaseTableLabel" rowspan="1" colspan="1" aria-sort="ascending" aria-label="First Name: activate to sort column descending" style="width: 131.172px;">First Name</th>
                                <th class="sorting" tabindex="1" aria-controls="example" rowspan="1" colspan="1" aria-label="Last Name: activate to sort column ascending" style="width: 218.172px;">Last Name</th>
                                <th class="sorting" tabindex="1" aria-controls="example" rowspan="1" colspan="1" aria-label="Active Employee: activate to sort column ascending" style="width: 218.172px;">Active</th>
                            </tr>
                        </thead>


                        <tbody>
                            <cfloop query="qry">
                                <cfoutput>
                                    <cfset active = #qry.isActive#>
                                </cfoutput>
                                    <tr id="tableRow">
                                        <cfoutput>
                                            <td id="company" class="sorting_1">
                                                <div class="">
                                                    <a href="/company.cfm?ID=#qry.COMPANYID#">#qry.COMPANYNAME#</a>
                                                </div>
                                            </td>

                                            <td id="firstName" class="sorting_1">
                                                <div class="">
                                                    <a href="/fullEmp.cfm?ID=#qry.EMPLOYEEID#">#qry.FIRSTNAME#</a>
                                                </div>
                                            </td>

                                            <td id="lastName" class="sorting_1">
                                                <div class="">
                                                    <a href="/fullEmp.cfm?ID=#qry.EMPLOYEEID#">#qry.LASTNAME#</a>
                                                </div>
                                            </td>


                                            <td id="isActive" class="sorting_1"> 
                                                <cfif active EQ '1'>
                                                    <i class="bi bi-check-circle activeBG">
                                                        <p hidden>Active</p>
                                                    </i>
                                                <cfelse>
                                                    <i class="bi bi-x-circle inactiveBG">
                                                        <p hidden>Inactive</p>
                                                    </i>
                                                </cfif>
                                            </td>
                                        </cfoutput>
                                    </tr>
                            </cfloop>
                        </tbody>
                    
                        <tfoot>
                        </tfoot>
                    
                    </table>
                    
                    <!---
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
                --->
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
                                    <button role="button" class="btn btn-secondary" type="submit" value="Submit" onclick="return validateCompany(this)" name="submit" id="submit">Save changes</button>
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
</cfif> 














<!---

            <cfoutput>
                <div>
                    <h1 class="title">Employee Database:</h1>
                    <cfif res.RECORDCOUNT GT 0>
                        <div class="flex-container mx-5">
                            <table class="table table-striped table-highlighted">
                                <tr>
                                    <th>Index </th>
                                    <th>Company </th>
                                    <th>Employee Last </th>
                                    <th>Employee First </th>
                                    <th>Is Active </th>
                                </tr>
    
                                <cfloop query="qry">  
                                    <cfset index++>  
                                    <tr>    
                                        <td>
                                            #index#
                                        </td>
    
                                        <td>
                                            <a href="/company.cfm?ID=#qry.COMPANYID#">#qry.COMPANYNAME#</a>
                                        </td>

                                        <td>
                                            <a href="/fullEmp.cfm?ID=#qry.EMPLOYEEID#">#qry.LASTNAME#</a>
                                        </td>
    
                                        <td>
                                            <a href="/fullEmp.cfm?ID=#qry.EMPLOYEEID#">#qry.FIRSTNAME#</a>
                                        </td>
    
                                        <td>
                                            <cfif qry.ISACTIVE>
                                                <div class="form-check">
                                                    <input type="checkbox" class="form-check-input" checked>
                                                </div>                                            
                                            <cfelse>
                                                <div class="form-check">
                                                    <input type="checkbox" class="form-check-input">
                                                </div>
                                            </cfif>
                                        </td>
                                    </tr>
                                </cfloop>
                            </table>
                        </div>
                    <cfelse>
                        <cfif #session.USER.ISADMIN# EQ 1>
                            <h3>Hmm, Let's fill this out a bit more!</h3>
                            <br>
                        <cfelse>
                            <h3>Hmm, seems like we're a newer company, please contact an administrator to add some employees!</h3>
                        </cfif>
                    </cfif>
                    <br>
    
                    <div class="flex-container">
                        <cfset poolIndex=0>  

                        <h1 class="sm-title">Employee Pool:</h1>

                        <table class="table table-sm table-striped table-highlighted">
                            <tr>
                                <th>Index </th>

                                <th>Last Name</th>
                                <th>First Name</th>
                            </tr>
                            <cfloop query="pool">
                                <cfset poolIndex++>  

                                <tr>
                                    <td>#poolIndex#</td>
                                    <td>
                                        <a href="/fullEmp.cfm?ID=#pool.EMPLOYEEID#">#pool.LASTNAME#</a>
                                    </td>
                                    <td>
                                        <a href="/fullEmp.cfm?ID=#pool.EMPLOYEEID#">#pool.FIRSTNAME#</a>
                                    </td>
                                </tr>
                            </cfloop>
                        </table>
                        
                        <div class="d-grid gap-2 col-2 mx-auto btn btn-secondary">
                        <a href="addEmp.cfm">Add Employee</a>
                        </div>
                        <div class="d-grid gap-2 col-2 mx-auto btn btn-secondary">
                            <a href="welcome.cfm">Go Home</a>
                        </div>                        
                </div>
            </cfoutput>
            <cfinclude  template="footer.cfm">
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
--->