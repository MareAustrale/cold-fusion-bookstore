<cfparam name="forgotmessage" default="" />
<cfparam name="showresetform" default="false" />
<cfparam name="accountmessage" default="" />

<cfset processforms()>

<!--- Check if passwords match --->
<script type="text/javascript">
   function validateNewAccount(){
	origpw=document.getElementById('newaccountpassword').value;
	confpw=document.getElementById('newaccountpasswordconfirm').value;

	if(origpw == confpw && origpw != '' && confpw != ''){
		document.getElementById('submitnewaccountform').click();
		document.getElementById('newaccountmessage').innerHTML="";
	}
	else{
		document.getElementById('newaccountmessage').innerHTML="Passwords do not match";
	}

   }
</script>

<cfoutput>
	<cfif showresetform>
 		#resetform()#
    <cfelse>
		#forgotpasswordform()#
	</cfif>
</cfoutput>

<cffunction name="processforms" access="private">
<cfoutput>
	<cfif isdefined('form.password')>
		<cfquery name="changepw" datasource="#application.dsource#">
    		update passwords set password='#hash(form.password,"SHA-256")#'
	        where personid='#form.personid#'
    	</cfquery>
	    <cflocation url="#cgi.SCRIPT_NAME#?p=login" />
	</cfif>

	<cfif isdefined('form.forglastname')>
		<cfquery name="isin" datasource="#application.dsource#">
    		select * from people where
	        email='#form.forgemail#' and lastname='#form.forglastname#'
    	</cfquery>
	    <cfif isin.recordcount gt 0>
    		<cfset showresetform=true>
            <cfset accountmessage="Please enter a new password">
	    <cfelse>
    		<cfset forgotmessage="Sorry, we didn't find that account.">
	    </cfif>
	</cfif>
</cfoutput>
</cffunction>

<!--- Reset form --->
<cffunction name="resetform" access="private">
	<cfoutput>
       	<div id="newaccountmessage">#accountmessage#</div>
    	<form action="#cgi.SCRIPT_NAME#?p=forgotpassword" method="post" class="form-horizontal">
        	<input type="hidden" name="personid" value="#isin.personid#" />
		    <div class="form-group">
            	<label class="control-label col-lg-3" for="firstname">Password:</label>
                <div  class="col-lg-9">
                	<input type="password" id="newaccountpassword" class="form-control" name="password" placeholder="Password"
					title="Please Enter a Password" required/>
				</div>
            </div>
		    <div class="form-group">
            	<label class="control-label col-lg-3" for="confirm" >Confirm Password:</label>
                <div  class="col-lg-9">
                	<input type="password" id="newaccountpasswordconfirm" class="form-control" name="confirm" placeholder="Confirm Password"
					title="Please Confirm your Password" required/>
				</div>
            </div>
		    <div class="form-group">
            	<label class="control-label col-lg-3" >&nbsp;</label>
                <div  class="col-lg-9">
                	<button id="newaccountbutton" class="btn btn-warning" type="button" onclick="validateNewAccount()">Save</button>
                    <input type="submit" id="submitnewaccountform" style="display:none" />
				</div>
            </div>
		</form>
	</cfoutput>
</cffunction>

<!--- Forgot password form --->
<cffunction name="forgotpasswordform" access="private">
	<cfoutput>
		<legend>Forgot Password</legend>
	    <div>#forgotmessage#</div>
    	<form action="#cgi.SCRIPT_NAME#?p=forgotpassword" method="post" class="form-horizontal">
        	<div class="form-group">
            	<label class="control-label col-lg-3" for="forglastname">Last Name</label>
                <div  class="col-lg-9">
                	<input type="text" class="form-control" name="forglastname" placeholder="Last Name" title="Last Name" required/>
				</div>
            </div>
            <div class="form-group">
            	<label class="control-label col-lg-3" for="forgemail">Email Address:</label>
                <div  class="col-lg-9">
                	<input type="text" class="form-control" name="forgemail" placeholder="Email Address" title="Email Address" required/>
				</div>
            </div>
            <div class="form-group">
            	<label class="control-label col-lg-3">&nbsp;</label>
                <div  class="col-lg-9">
                	<button class="btn btn-warning">Submit</button>
				</div>
            </div>
        </form>
	</cfoutput>
</cffunction>