<nav class="navbar navbar-expand-lg navbar-bg">
    <div class="container-fluid">
      
      <a class="navbar-brand" href="/welcome.cfm">Database</a>
      
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

      <div class="dropdown">
        <button class="btn btn-md btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
          <cfoutput>#session.theme#</cfoutput>
        </button>
        <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
          <li><a class="dropdown-item" href="/setTheme.cfm?theme=general">General</a></li>
          <li><a class="dropdown-item" href="/setTheme.cfm?theme=fun">Fun</a></li>
          <li><a class="dropdown-item" href="/setTheme.cfm?theme=plain">Plain</a></li>
          <li><a class="dropdown-item" href="/setTheme.cfm?theme=spec">Spec</a></li>
          <li><a class="dropdown-item" href="/setTheme.cfm?theme=bare">Bare</a></li>
        </ul>
      </div>

      <cfoutput>
        <p class="date-text" id="date-text">
          Today is <br>
          #dateFormat(now(), 'mm-dd-yyyy')#
        </p>
      </cfoutput>     
    </div>
  </nav>