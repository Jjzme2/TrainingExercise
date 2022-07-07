<cfif !structKeyExists(session, "started")>
    <cfset session.started="false">
    <cflocation  url="/login.cfm" addtoken="no">
</cfif>

<cfset okayToSend = 'false'>

<cfif session.started eq "true">
    <cfif session.IsLoggedIn eq "true">
        <cfif session.User.ISADMIN EQ "true">
            <cfquery name='qry' datasource='empdeets' result='res'>
                SELECT 
                e.FIRSTNAME
                ,u.USERNAME
                FROM TBL_EMPLOYEE e
                RIGHT JOIN TBL_USERS u ON e.EMPLOYEEID = u.EMPLOYEEID
                WHERE FIRSTNAME='The'
            </cfquery>
            
            <cfhttp url="https://www.mind-over-data.com/" result="mod"/>
            <cfset html = #mod.FileContent# />
            
            <!---
            <cfoutput>
                #replace('#html#',findNoCase('#html#', qry.FIRSTNAME),"MOD","all")#
            </cfoutput>
            --->
            
            <cfsavecontent  variable="EmailText">
                <cfoutput>
                    <h1>Hello, </h1> you have been sent an email by #session.User.Username#
                </cfoutput>
            </cfsavecontent>
            
            <cfif okayToSend EQ 'true'>
                <cfmail  from="john.zettler@mind-over-data.com"  subject="WHO"  to="john.zettler@mind-over-data.com" type="text/html">
                    #EmailText#
                    <br>
                    <br>
                    #replace('#html#',findNoCase('#html#', qry.FIRSTNAME),"MOD","all")#
                </cfmail>
            <cfelse>
                <cflocation  url="/welcome.cfm?Fine-DontSendMail" addtoken="no">
            </cfif>

            

        <cfelse>
            <cfset session.Errors.Append("Please ensure you have appropriate permission to access this content.")>
            <cflocation  url="/errPage.cfm" addToken="no">
        </cfif>
    <cfelse>
        <cfset session.Errors.Append("Please ensure you have appropriate permission to access this content.")>
        <cflocation  url="/errPage.cfm" addToken="no">    
    </cfif>
</cfif>

