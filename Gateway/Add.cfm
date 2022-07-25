<!---------------------------------------------------------------------------Initialize Variables --------------------------------------------------------------------------------------------------------------->
<cfif !structKeyExists(session, "IsLoggedIn")>
    <cfset session.IsLoggedIn="false">
</cfif>

<cfif structKeyExists(session, "IsLoggedIn")>
    <cfif #session.IsLoggedIn# EQ 1> <!--- Good User --->    
        <cfset session.Errors=arrayNew(1)>
<!--- Use IsValid more --->


<!---------------------------------------------------------------------------Validation --------------------------------------------------------------------------------------------------------------->
        <!--- Action code. First make sure the form was submitted. --->
        <cfif isDefined("form.submit")>

            <cfif isValid("string", #form.fname#) && isValid("string", #form.lname#)>
                <cfif reFind("[0-9]+", #form.fname#) || reFind("[0-9]+", #form.lname#)>
                    <cfset session.Errors.append("Most first names and last names do not contain numbers, are you sure this is what you wanted?")>
                </cfif>
            <cfelse>
                <cfset session.Errors.append("Name Fields must be filled out.")>
            </cfif>

            <cfif isValid("string", #form.tel#)>
                <cfset cleanPhoneNumber = reReplace(#form.TEL#, "[^0-9]", "", "ALL")>
            <cfelse>
                <cfset session.Errors.append("Phone must contain content.")>
            </cfif>

            <cfif isValid("String", cleanPhoneNumber)>
                <cfif len(cleanPhoneNumber) EQ 10>
                    <cfif reFind("[A-Z][a-z]+", #form.tel#)>
                        <cfset session.Errors.append("Phone must be 10 numeric charcters.")>
                    </cfif>
                <cfelse>
                    <cfset session.Errors.append("After cleaning, #cleanPhoneNumber# (Length: #len(cleanPhoneNumber)#)didn't meet the needed requirement of 10 characters. Please Do not use a country code in this field.")>
                </cfif>
            <cfelse>
                <cfset session.Errors.append("Phone must be filled out. 2nd")>
            </cfif>

            <cfif isValid("string", #form.street#) && isValid("string", #form.city#)>
                <cfif reFind("[0-9]+", #form.street#) || reFind("[0-9]+", #form.city#)>
                    <cfset session.Errors.append("Most street names and city names do not contain numbers, are you sure this is what you wanted?")>
                </cfif>
            <cfelse>
                <cfset session.Errors.append("Street  and City Fields must be filled out.")>
            </cfif>
            
            <cfif isValid("string", #form.pass#) && isValid("string", #form.confPass#)>
                <cfif form.pass != form.confPass>
                    <cfset session.Errors.append("Passwords must match!")>
                </cfif>
            <cfelse>
                <cfset session.Errors.append("Password Fields must be filled out.")>
            </cfif>
        <cfelse>
            <cfset session.Errors.append("Unable to find a form to check.")>
        </cfif>
    
        <cfif len(session.Errors) GT 0>
<!---------------------------------------------------------------------------Validation PASS --------------------------------------------------------------------------------------------------------------->
    <cflocation  url="/errPage.cfm" addtoken="no">

        <cfelse>
            <cfquery name="qry" datasource="empdeets" result="res"> <!--- Notice Result attribute named res--->
                INSERT INTO 
                TBL_Employee
                (
                    FIRSTNAME
                    ,LASTNAME
                    ,TEL
                    ,ISACTIVE
                    ,NAMESUFFIX
                    ,HIREDATE
                    ,STARTDATE
                    ,COMPANYID
                )
                VALUES
                (
                    <cfqueryparam value='#form.fname#' cfsqltype="cf_sql_NVARCHAR">
                    ,<cfqueryparam value='#form.lname#' cfsqltype="cf_sql_NVARCHAR">
                    ,<cfqueryparam value='#cleanPhoneNumber#' cfsqltype="CF_SQL_NVARCHAR">
                    ,0
                    ,<cfqueryparam value='#form.suffix#' cfsqltype="cf_sql_NVARCHAR">
                    ,<cfqueryparam value='#DateFormat(now(),'yyyy-mm-dd')#' cfsqltype="cf_sql_DATE">
                    ,<cfqueryparam value='#form.startDate#' cfsqltype="cf_sql_DATE">
                    ,<cfqueryparam value='#URL.ID#' cfsqltype="cf_sql_INTEGER">
                );
            </cfquery>
    
            <cfset rslt = "#res.generatedKey#"/>
    
            <cfif rslt NEQ ""> <!---- null--->
                <cfquery name="addressQry" datasource="empdeets">
                    INSERT INTO 
                    TBL_Address 
                    (
                        EMPLOYEEID
                        ,STREETNUMBER
                        ,STREETNAME
                        ,CITY
                        ,[STATE]
                        ,ZIPCODE           
                    )
                    VALUES 
                    (
                        <cfqueryparam value=#rslt# cfsqltype="cf_sql_integer">
                        ,<cfqueryparam value='#form.streetNUM#' cfsqltype="cf_sql_INTEGER">
                        ,<cfqueryparam value='#form.street#' cfsqltype="cf_sql_nvarchar">
                        ,<cfqueryparam value='#form.city#' cfsqltype="cf_sql_nvarchar">
                        ,<cfqueryparam value='#form.state#' cfsqltype="cf_sql_nvarchar">
                        ,<cfqueryparam value='#form.zip#' cfsqltype="cf_sql_INTEGER">
                    )
                </cfquery>

                <cfquery name="userQry" datasource="empdeets">
                    INSERT INTO 
                    TBL_Users
                    (
                        EMPLOYEEID
                        ,USERNAME
                        ,PASS
                        ,LOGINCOUNT
                        ,EMAIL
                        <cfif structKeyExists(form, 'admin')>
                        ,ISADMIN
                        </cfif>
                    )
                    VALUES 
                    (
                        <cfqueryparam value=#rslt# cfsqltype="cf_sql_integer">
                        ,<cfqueryparam value='#form.username#' cfsqltype="cf_sql_nvarchar">
                        ,<cfqueryparam value='#form.pass#' cfsqltype="cf_sql_nvarchar">
                        ,0
                        ,<cfqueryparam value=#form.email# cfsqltype="cf_sql_nvarchar">
                        <cfif structKeyExists(form, 'admin')>
                            ,1
                         </cfif>
                    )

                </cfquery>
            </cfif>
<!---------------------------------------------------------------------------Redirect --------------------------------------------------------------------------------------------------------------->
            <cflocation  url="/database.cfm" addtoken="no">
        </cfif>
    
    <cfelse>
        <cflocation  url="login.cfm" addtoken="no">
    </cfif>
</cfif>