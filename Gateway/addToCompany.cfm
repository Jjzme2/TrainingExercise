
<cfquery name="qry" datasource="empdeets">
    UPDATE TBL_Employee
    SET
        COMPANYID=<cfqueryparam value=#Form.company# cfsqltype="CF_SQL_INTEGER">
    WHERE EMPLOYEEID = <cfqueryparam value=#URL.ID# cfsqltype="CF_SQL_INTEGER">
</cfquery>
<cflocation  url="/login.cfm" addtoken="no">