<script type="text/javascript">
	function validateNewAccount() {
		var origpw=document.getElementById('newaccountpassword').value;
		var confpw=document.getElementById('newaccountpasswordconfirm').value;

		if(origpw == confpw && origpw != '' && confpw != '') {
			document.getElementById('submitnewaccountform').click();
			document.getElementById('newaccountmessage').innerHTML="";
		}
		else {
			document.getElementById('newaccountmessage').innerHTML="Your passwords do not match. Please try again.";
		}
	}
</script>

<cfparam name="AccountMessage" default="">
<cfparam name="loginmessage" default="">

<cfset preprocess()>

<div class="col-lg-6">
	<legend>Register</legend>
	<div id="newaccountmessage">
		<cfoutput>
			#AccountMessage#
		</cfoutput>
	</div>
	<cfoutput>
		<form action="#cgi.SCRIPT_NAME#?p=login" method="post" class="form-horizontal">
    	<input type="hidden" name="newpersonid" id="newpersonid" value="" />
			<div class="form-group">
		    	<label for="firstname" class="col-sm-2 control-label">First Name: </label>
		    	<div class="col-sm-10">
		      		<input type="text" class="form-control" id="firstname" name="firstname" placeholder="First Name" required />
		    	</div>
		  	</div>
			<div class="form-group">
		    	<label for="lastname" class="col-sm-2 control-label">Last Name: </label>
		    	<div class="col-sm-10">
		      		<input type="text" class="form-control" id="lastname" name="lastname" placeholder="Last Name" required />
		    	</div>
		  	</div>
			<div class="form-group">
		    	<label for="email" class="col-sm-2 control-label">Email: </label>
		    	<div class="col-sm-10">
		      		<input type="email" class="form-control" id="email" name="email" placeholder="Email" required />
		    	</div>
		  	</div>
		  	<div class="form-group">
		    	<label for="password" class="col-sm-2 control-label">Password: </label>
		    	<div class="col-sm-10">
		      		<input type="password" class="form-control" id="newaccountpassword" name="newaccountpassword"
		      		placeholder="Password" required />
		    	</div>
			</div>
		  	<div class="form-group">
		    	<label for="confirmpassword" class="col-sm-2 control-label">Confirm Password: </label>
		    	<div class="col-sm-10">
		      		<input type="password" class="form-control" id="newaccountpasswordconfirm" name="newaccountpasswordconfirm"
		      		placeholder="Confirm Password" required />
		    	</div>
			</div>
			<div class="form-group">
		    	<div class="col-sm-offset-2 col-sm-10">
		      		<button id="newaccountbutton" class="btn btn-warning" type="button" onclick="validateNewAccount()">
			      		Make Account
					</button>
					<input type="submit" id="submitnewaccountform" style="display:none" />
		    	</div>
		  	</div>
		</form>
	</cfoutput>
</div>

<div class="col-lg-6">
	<legend>Login</legend>
	<div id="loginmessage">
		<cfoutput>
			#loginmessage#
		</cfoutput>
	</div>
	<cfoutput>
		<form action="#cgi.SCRIPT_NAME#?p=login" method="post" class="form-horizontal">
			<div class="form-group">
		    	<label for="loginemail" class="col-sm-2 control-label">Email</label>
		    	<div class="col-sm-10">
		      		<input type="email" class="form-control" name="loginemail" />
		    	</div>
		  	</div>
			<div class="form-group">
		    	<label for="loginpass" class="col-sm-2 control-label">Password</label>
		    	<div class="col-sm-10">
		      		<input type="password" class="form-control" name="loginpass" />
		    	</div>
		  	</div>
			<div class="form-group">
		    	<div class="col-sm-offset-2 col-sm-10">
		      		<button class="btn btn-warning" type="submit">
			      		Login
					</button>
		    	</div>
		  	</div>
		</form>
		<div class="col-sm-offset-2 col-sm-10">
			<a href="#cgi.SCRIPT_NAME#?p=forgotpassword">Forgot Password?</a>
		</div>
	</cfoutput>
</div>

<cffunction name="preprocess" access="private">
	<cfif isdefined('form.email')>
		<cfif isAlreadyIn()>
 			<cfset AccountMessage="That Email Account is Already in our system. Please login.">
		<cfelse>
			<cfset addPerson()>
			<cfset AccountMessage="New account created.">
		</cfif>
	</cfif>
</cffunction>

<cffunction name="isAlreadyIn" returntype="boolean">
	<cfquery name="getemail" datasource="#application.dsource#">
 		select * from people where email='#form.email#'
	</cfquery>
	<cfif getemail.recordcount eq 0>
		<cfreturn false>
	<cfelse>
		<cfreturn true>
	</cfif>
	<cfreturn false>
</cffunction>

<cffunction name="addPerson">
	<cfset newid=createuuid()>
	<cfquery name="putin" datasource='#application.dsource#'>
 		insert into people
		(personid, firstname, lastname, email, IsAdmin)
		values
		('#newid#', '#form.firstname#', '#form.lastname#', '#form.email#', 0)
 	</cfquery>
	<cfquery name="putinpassword" datasource='#application.dsource#'>
		insert into passwords
		(personid, password)
		values
		('#newid#', '#hash(form.newaccountpassword, "SHA-256")#')
	</cfquery>
</cffunction>