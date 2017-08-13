<!--- Set Navbar to show active tab --->
<script type="text/javascript">
	$(function(){
	$('.nav a').filter(function(){return this.href==location.href}).parent().addClass('active').siblings().removeClass('active')
		$('.nav a').click(function(){
			$(this).parent().addClass('active').siblings().removeClass('active')
		})
	})
</script>

<!--- Top Navigation Bar --->
<nav class="navbar navbar-default">
   	<div class="container-fluid">
       	<div class="navbar-header">

	       	<!--- Nav Toggle --->
   	        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#readDeseNav">
		   	    <span class="sr-only">Toggle navigation</span>
	        	<span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
	    	</button>

	    	<!--- Branding --->
	        <a class="navbar-brand" href="/msout46264/MyWebSite">BU</a>

       	</div>

		<!--- Main Navigation Items --->
        <div class="collapse navbar-collapse" id="readDeseNav">
   	       	<ul class="nav navbar-nav">
       			<cfoutput>
					<li class="active"><a href="#cgi.SCRIPT_NAME#?tool=addedit">Add Edit</a></li>
					<li><a href="#cgi.SCRIPT_NAME#?tool=createuuids">UUIDs</a></li>
    				<li><a href="#cgi.SCRIPT_NAME#?tool=managecontent">Content</a></li>
				</cfoutput>
				<cfoutput>
					<form class="navbar-form navbar-left" role="search" action="/msout46264/MyWebSite/index.cfm?p=details" method="post">
  						<div class="form-group">
    						<input type="text" class="form-control" placeholder="Search" name="searchme">
						</div>
  						<button type="submit" class="btn btn-primary">Submit</button>
					</form>
				</cfoutput>
			</ul>

			<!--- Logout --->
			<ul class="nav navbar-nav navbar-right">
               	<cfoutput>
					<li><a>Welcome #session.user.firstname#</a></li>
					<cfif session.user.IsAdmin>
						<li><a href="http://comweb.uml.edu/msout46264/MyWebSite/Management/index.cfm">Management</a></li>
					</cfif>
					<li><a href="http://comweb.uml.edu/msout46264/MyWebSite/index.cfm?p=logoff">Logout</a></li>
				</cfoutput>
            </ul>

		</div>
	</div>
</nav>