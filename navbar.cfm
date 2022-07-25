<nav class="navbar navbar-expand-lg navbar-bg">
    <div class="container-fluid">
      
      <a class="navbar-brand" href="/welcome.cfm">Brand Name</a>
      
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav">
          <li class="nav-item">
            <a class="nav-link" aria-current="page" href="/welcome.cfm">Home</a>
          </li>

          <!--- IsAdmin --->
          <cfif structKeyExists(session.USER, 'ISADMIN')>
            <cfif #session.USER.ISADMIN#>
              <li class="nav-item">
                <a class="nav-link" href="/database.cfm">Access Database</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="/_DEVTEST/VARS/session.cfm">Vars</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="/mailer.cfm">Mail</a>
              </li>
            </cfif>
          </cfif>
          <li class="nav-item">
            <a class="nav-link" href="/logout.cfm">Log out</a>
          </li>
        </ul>
      </div> 

      <cfif !structKeyExists(session, 'theme')>
        <cfset session.Theme = "bare">
      </cfif>

      <cfoutput>
        <p class="date-text" id="date-text">
          Today is <br>
          #dateFormat(now(), 'mm-dd-yyyy')#
        </p>
      </cfoutput>     
    </div>
  </nav>