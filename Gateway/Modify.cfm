<!---------------------------------------------------------------------------Initialize Variables --------------------------------------------------------------------------------------------------------------->
<cfif !structKeyExists(session, "IsLoggedIn")>
    <cfset session.IsLoggedIn="false">
</cfif>

<cfif structKeyExists(session, "IsLoggedIn")>
    <cfif #session.IsLoggedIn# EQ 1> <!--- Good User --->    
        <cfset session.Errors=arrayNew(1)>
<!---           <cfdump var=#form#>   --->
<!---          <cfabort>  --->
<!---------------------------------------------------------------------------Validation --------------------------------------------------------------------------------------------------------------->
        <!--- Action code. First make sure the form was submitted. --->
        <cfif isDefined("form.submit")>
            <cfif isValid("string", #form.tel#)>
                <!--- Taken from 
                https://stackoverflow.com/questions/8622587/standardize-phone-numbers-in-submitted-form-with-coldfusion
                 --->
                <cfset cleanPhoneNumber = reReplace(#form.TEL#, "[^0-9]", "", "ALL")>
            <cfelse> 
                <cfset session.Errors.append("Phone Must contain content!")>
            </cfif>


            <cfif isValid("String", #form.fname#) && isValid("String", #form.lname#)>
                <cfif reFind("[0-9]+", #form.fname#) || reFind("[0-9]+", #form.lname#)>
                    <cfset session.Errors.append("Most first names and last names do not contain numbers, are you sure this is what you wanted?")>
                </cfif>
            <cfelse>
                <cfset session.Errors.append("All Fields must be filled out.")>
            </cfif>
            

            <cfif isValid("String", cleanPhoneNumber)>
                <cfif len(cleanPhoneNumber) NEQ 10>
                    <cfset session.Errors.append("After cleaning, #cleanPhoneNumber# (Length: #len(cleanPhoneNumber)#)didn't meet the needed requirement of 10 characters. Please Do not use a country code in this field.")>
                </cfif>
            <cfelse>
                <cfset session.Errors.append("Phone must be filled out.")>
            </cfif>

            <cfif #form.username# EQ ''>
                <cfset session.Errors.append("All Fields must be filled out.")>
            </cfif>

            <cfif structKeyExists(form, "pass")>
                <cfif isValid("string", #form.pass#) && isValid("string", #form.confPass#)>
                    <cfif #form.pass# NEQ #form.confPass#>
                        <cfset session.Errors.append("Passwords must match.")>
                    </cfif>
                <cfelse>
                    <cfset session.Errors.append("All Password Fields must be filled out.")>
                </cfif>
            </cfif>

<!--- Not VariableName --->
            <cfif isValid("String", #form.street#) && isValid("String", #form.city#)>
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
            <cfdump var = #session#>
<!---------------------------------------------------------------------------Validation PASS --------------------------------------------------------------------------------------------------------------->
<!---             <cflocation  url="/errPage.cfm" addtoken="no"> --->
        <cfelse>

            <cfquery name="qry" datasource="empdeets" result="res">
                UPDATE 
                TBL_EMPLOYEE
            
                SET 
                FIRSTNAME = <cfqueryparam value='#form.fname#' cfsqltype="cf_sql_nvarchar">
                ,LASTNAME = <cfqueryparam value='#form.lname#' cfsqltype="cf_sql_nvarchar">
                ,NAMESUFFIX = <cfqueryparam value='#form.suffix#' cfsqltype="cf_sql_nvarchar">
                <cfif structKeyExists(form, "company")>
                ,COMPANYID = <cfqueryparam value='#form.company#' cfsqltype="CF_SQL_INTEGER">
                </cfif>
                ,TEL = <cfqueryparam value='#cleanPhoneNumber#' cfsqltype="CF_SQL_NVARCHAR">
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
                <cfif structKeyExists(form, "pass")>
                ,PASS = <cfqueryparam value='#form.pass#' cfsqltype="cf_sql_nvarchar">
                </cfif>

                <cfif structKeyExists(form, 'admin')>
                    ,ISADMIN = 1
                </cfif>
                WHERE 
                EMPLOYEEID=<cfqueryparam value=#URL.ID# cfsqltype="cf_sql_integer">
            </cfquery>
            <!--- Add Company --->
<!---------------------------------------------------------------------------Redirect --------------------------------------------------------------------------------------------------------------->
<cfif structKeyExists(form, "company")>
    <cflocation  url="/company.cfm?ID=#form.company#" addtoken="no">
<cfelse>
    <cflocation  url="/database.cfm" addtoken="no">

</cfif>
        </cfif>
    
    <cfelse>
        <cflocation  url="login.cfm" addtoken="no">
    </cfif>
</cfif>