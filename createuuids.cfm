<legend>UUIDs</legend>
<cfoutput>
	<cfloop from="1" to="20" index="i">
		<input value="#createuuid()#" size=30><br/>
	</cfloop>
</cfoutput>