<!doctype html>
<html lang="en">
  <head>
    <!--- Bootstrap stuff --->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Change in Application.cfc OnRequest()</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
    
    <!--- Google Fonts Stuff --->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Arima:wght@100;300;500;700&family=Cinzel+Decorative:wght@400;700;900&family=Merriweather:wght@300;400;700;900&family=Ubuntu:wght@300;400;500;700&display=swap" rel="stylesheet">

    <!--- Font Awesome --->
    <script src="https://kit.fontawesome.com/fa6d840559.js" crossorigin="anonymous"></script>

    <!--- Set Theme Here --->
    <cfif structKeyExists(session, 'theme')>
      <!--- Personal CSS --->
      <cfif session.Theme EQ "general">
        <link href="/public/CSS/styles.css" rel="stylesheet" type="text/css">
      <cfelseif session.Theme EQ "spec">
        <link href="/public/CSS/spec.css" rel="stylesheet" type="text/css">
      <cfelseif session.Theme EQ "fun">
        <link href="/public/CSS/fun.css" rel="stylesheet" type="text/css">
      <cfelse> <!--- bare --->
        <link href="/public/CSS/bare.css" rel="stylesheet" type="text/css">
      </cfif>
    <cfelse>
      <link href="/public/CSS/bare.css" rel="stylesheet" type="text/css">

    </cfif>



    <!--- More Bootstrap --->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.5/dist/umd/popper.min.js" integrity="sha384-Xe+8cL9oJa6tN/veChSP7q+mnSPaj5Bcu9mPX5F5xIGE0DVittaqT5lorf0EI7Vk" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-kjU+l4N0Yf4ZOJErLsIcvOU2qSb74wXpOhqTvwVx3OElZRweTnQ6d31fXEoRD1Jy" crossorigin="anonymous"></script>
  </head>

  <body>

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
                <li><a class="dropdown-item" href="/setTheme.cfm?theme=spec">Spec</a></li>
                <li><a class="dropdown-item" href="/setTheme.cfm?theme=bare">Bare</a></li>

              </ul>
            </div>

            <li class="nav-item">
              <a class="nav-link" href="/logout.cfm">Log out</a>
            </li>
          </ul>
        </div> 
        <cfoutput>
          <p class="date-text">
            Today is <br>
            #dateFormat(now(), 'mm-dd-yyyy')#
          </p>
        </cfoutput>     
      </div>
    </nav>

