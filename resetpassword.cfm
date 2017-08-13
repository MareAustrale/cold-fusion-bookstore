<script type="text/javascript">
	function validateNewPassword() {
		var newpw=document.getElementById('newpassword').value;
		var confnewpw=document.getElementById('confirmnewpassword').value;

		if(newpw == confnewpw && newpw != '' && confnewpw != '') {
			document.getElementById('submitnewpassword').click();
			document.getElementById('newpwmessage').innerHTML="";
		}
		else {
			document.getElementById('newpwmessage').innerHTML="Your passwords do not match. Please try again.";
		}
	}
</script>

<cfparam name="pwmessage" default="">

<cfif isdefined('form.newpassword')>
	<cfset setPassword()>
	<cfset pwmessage="Your password has successfully been changed.">
</cfif>

<legend>Reset Password</legend>
<div class="col-lg-6">
	<div id="newpwmessage">
		<cfoutput>
			#pwmessage#
		</cfoutput>
	</div>
	<cfoutput>
		<form action="#cgi.SCRIPT_NAME#?p=resetpassword" method="post" class="form-horizontal">
			<div class="form-group">
			    <label for="newpassword">New Password: </label>
			   	<input type="password" class="form-control" id="newpassword" name="newpassword" placeholder="New Password" required>
			 </div>
			<div class="form-group">
			    <label for="confirmnewpassword">Confirm New Password: </label>
			    <input type="password" class="form-control" id="confirmnewpassword" name="confirmnewpassword"
			    placeholder="Confirm New Password" required>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
		      		<button id="newpasswordbutton" class="btn btn-warning" type="button" onclick="validateNewPassword()">
			      		Submit
					</button>
					<input type="submit" id="submitnewpassword" style="display:none" />
		    	</div>
			</div>
		</form>
	</cfoutput>
</div>

<cffunction name="setPassword">
	<cfquery name="updateAccount" datasource='#application.dsource#'>
 		update passwords
		set password='#hash(form.newpassword, "SHA-256")#'
		from passwords
			inner join people
			on passwords.personid = people.personid
		where lastname='#session.user.lastname#' and email='#session.user.email#'
 	</cfquery>
</cffunction>