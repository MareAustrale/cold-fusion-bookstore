<cfparam name="cms" default="">

<cfif cms eq ''>
	<cfset sendhome()>
<cfelse>
	<cfquery name="getcontent" datasource="#application.dsource#">
    	select * from content where contentid='#cms#'
    </cfquery>
    <cfif getcontent.recordcount gt 0>
    	<cfoutput>#displaycontent()#</cfoutput>
    <cfelse>
    	<cfset sendhome()>
    </cfif>
</cfif>

<cffunction name="sendhome">
	<cflocation url="/msout46264" />
</cffunction>

<cffunction name="displaycontent">
	<cfoutput>
		<legend>#getcontent.title[1]#</legend>
        #getcontent.description[1]#
    </cfoutput>
</cffunction>