<!doctype html>
<html>
<head>
	<meta charset="utf-8">
	<title>Books Uncovered</title>
	<link href="/msout46264/includes/bootstrap/css/bootstrap.css" rel="stylesheet" />
	<link href="/msout46264/includes/css/mycss.css" rel="stylesheet" />
	<link href='https://fonts.googleapis.com/css?family=Cabin:400,400italic,700,700italic|Rokkitt:700' rel='stylesheet' type='text/css'>
	<script src="/msout46264/includes/js/jQuery/jquery-1.11.3.min.js" type="text/javascript"></script>
	<script src="/msout46264/includes/bootstrap/js/bootstrap.js" type="text/javascript"></script>
</head>

<cfparam name="p" default="carousel">
<cfinclude template="stateinfo.cfm" />

<body>
	<cfinclude template="header.cfm" />
	<div id="wrapper" class="container">

       	<!--- Top Navigation Bar --->
		<div id="headerarea" class="row">
			<cfinclude template="navbar.cfm" />
		</div>

		<!--- Main --->
		<div id="maincontent" class="row">
			<div id="center" class="col-sm-9 col-lg-9 col-md-9 col-sm-push-3">
				<cfinclude template="#p#.cfm">
			</div>

			<!--- Left Menu --->
            <div id="leftgutter" class="col-sm-3 col-lg-3 col-md-3 col-sm-pull-9">
            	<cfinclude template="genrenav.cfm">
            </div>

			<!--- Right Gutter --->
			<div id="rightside" class="col-sm-2 col-lg-2">
            </div>
        </div>

		<!--- Footer --->
		<div id="footer" class="row">
			<cfinclude template="footer.cfm" />
		</div>
	</div>
</body>
</html>