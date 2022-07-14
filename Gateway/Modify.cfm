<!---------------------------------------------------------------------------Initialize Variables --------------------------------------------------------------------------------------------------------------->
<cfif !structKeyExists(session, "IsLoggedIn")>
    <cfset session.IsLoggedIn="false">
</cfif>

<cfif structKeyExists(session, "IsLoggedIn")>
    <cfif #session.IsLoggedIn# EQ 1> <!--- Good User --->    
        <cfset session.Errors=arrayNew(1)>

<!---------------------------------------------------------------------------Validation --------------------------------------------------------------------------------------------------------------->
        <!--- Action code. First make sure the form was submitted. --->
        <cfif isDefined("form.submit")>
            <cfif isValid("variableName", #form.fname#) && isValid("variableName", #form.lname#)>
                <cfif reFind("[0-9]+", #form.fname#) || reFind("[0-9]+", #form.lname#)>
                    <cfset session.Errors.append("Most first names and last names do not contain numbers, are you sure this is what you wanted?")>
                </cfif>
            <cfelse>
                <cfset session.Errors.append("All Fields must be filled out.")>
            </cfif>
            
            <cfif #form.username# EQ ''>
                <cfset session.Errors.append("All Fields must be filled out.")>
            </cfif>

            <cfif isValid("variableName", #form.pass#) && isValid("variableName", #form.confPass#)>
                <cfif #form.pass# NEQ #form.confPass#>
                    <cfset session.Errors.append("Passwords must match.")>
                </cfif>
            <cfelse>
                <cfset session.Errors.append("All Fields must be filled out.")>
            </cfif>

            <cfif isValid("variableName", #form.street#) && isValid("variableName", #form.city#)>
                <cfif reFind("[0-9]+", #form.street#) || reFind("[0-9]+", #form.city#)>
                    <cfset session.Errors.append("Most street names and city names do not contain numbers, are you sure this is what you wanted?")>
                </cfif>
            <cfelse>
                <cfset session.Errors.append("All Fields must be filled out.")>
            </cfif>

        <cfelse>
            <cfset session.Errors.append("Unable to find a form to check.")>
        </cfif>
    
        <cfif len(session.Errors) GT 0>
<!---------------------------------------------------------------------------Validation PASS --------------------------------------------------------------------------------------------------------------->
    <cflocation  url="/errPage.cfm" addtoken="no">
        <cfelse>

            <cfquery name="qry" datasource="empdeets" result="res">
                UPDATE 
                TBL_EMPLOYEE
            
                SET 
                FIRSTNAME = <cfqueryparam value='#form.fname#' cfsqltype="cf_sql_nvarchar">
                ,LASTNAME = <cfqueryparam value='#form.lname#' cfsqltype="cf_sql_nvarchar">
                ,NAMESUFFIX = <cfqueryparam value='#form.suffix#' cfsqltype="cf_sql_nvarchar">
                ,COMPANYID = <cfqueryparam value='#form.company#' cfsqltype="CF_SQL_INTEGER">  
            
                WHERE 
                EMPLOYEEID=<cfqueryparam value=#URL.ID# cfsqltype="cf_sql_integer">
            </cfquery>

            <cfquery name="addressQry" datasource="empdeets">
                UPDATE 
                TBL_Address
        
                SET     
                STREETNUMBER = <cfqueryparam value=#form.streetNum# cfsqltype="cf_sql_integer">
                ,STREETNAME = <cfqueryparam value='#form.street#' cfsqltype="cf_sql_nvarchar">
                ,CITY = <cfqueryparam value='#form.city#' cfsqltype="cf_sql_nvarchar">
                ,[STATE] = <cfqueryparam value='#form.state#' cfsqltype="cf_sql_nvarchar">
                ,ZIPCODE = <cfqueryparam value='#form.zip#' cfsqltype="cf_sql_INTEGER">

                WHERE 
                EMPLOYEEID=<cfqueryparam value=#URL.ID# cfsqltype="cf_sql_integer">
            </cfquery>

            <cfquery name="userQuery" datasource="empdeets">
                UPDATE 
                TBL_Users

                SET     
                EMAIL = <cfqueryparam value=#form.email# cfsqltype="cf_sql_nvarchar">
                ,USERNAME = <cfqueryparam value=#form.username# cfsqltype="cf_sql_nvarchar">
                ,PASS = <cfqueryparam value='#form.pass#' cfsqltype="cf_sql_nvarchar">
                <cfif structKeyExists(form, 'admin')>
                    ,ISADMIN = 1
                    <cfelse>
                    ,ISADMIN = 0
                </cfif>
                WHERE 
                EMPLOYEEID=<cfqueryparam value=#URL.ID# cfsqltype="cf_sql_integer">
            </cfquery>
            <!--- Add Company --->
<!---------------------------------------------------------------------------Redirect --------------------------------------------------------------------------------------------------------------->
            <cflocation  url="/welcome.cfm" addtoken="no">
        </cfif>
    
    <cfelse>
        <cflocation  url="login.cfm" addtoken="no">
    </cfif>
</cfif>