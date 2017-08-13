<legend>Browse by Genre</legend>

<cfquery name="allgenres" datasource="#application.dsource#">
	select distinct genres.genreid, genrename from genrestobooks
	inner join genres on genres.genreid = genrestobooks.genreid
	order by genrename
</cfquery>

<ul class="nav nav-stacked">
	<cfoutput query="allgenres">
    	<li><a href="#cgi.SCRIPT_NAME#?p=details&genre=#genreid#">#genrename#</a></li>
    </cfoutput>
</ul>