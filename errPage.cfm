
   <cfinclude  template="/header.cfm">   
<!---
<cfdump var= #session.Errors#>
--->
<!--- <cfif structKeyExists(session, "Errors")> --->
     <body onload="displayErrors()"> 
        <div class="flex-container group">
            <div class="page-view">
                <p class="sm-title">Errors:</p>
                <p id="error-text"></p>
    
    
    <!---         <cfloop array="#session.Errors#" item="item"> --->
    <!---              <cfoutput>  --->
    <!---                 <p>#item#</p> --->
    <!---              </cfoutput>  --->
    <!---         </cfloop> --->
            </div>
        <div class="d-grid gap-2 col-6 mx-auto btn btn-secondary">
            <a href="javascript: history.go(-1);">Return</a>
        </div>
    </div>

      </body>  
   
<!--- </cfif> --->
 <cfinclude  template="/footer.cfm"> 

