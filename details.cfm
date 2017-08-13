<cfparam name="searchme" default="">
<cfparam name="genre" default="">

<cfif genre neq ''>
	<!--- Retrieve genre results --->
	<cfquery name="bookinfo" datasource="#application.dsource#">
		select * from books
		inner join genrestobooks on books.isbn13=genrestobooks.isbn13
		inner join publishers on books.publisher=publishers.id
		where genreid='#genre#'
	</cfquery>
<cfelseif searchme eq ''>
	No results were found
<cfelse>
	<!--- Retrieve search term results --->
	<cfquery name="bookinfo" datasource="#application.dsource#">
		select * from books
		inner join publishers on books.publisher=publishers.id
		where title like '%#trim(searchme)#%'
		or isbn13 like '%#trim(searchme)#%'
		or publishers.name='#searchme#'
	</cfquery>
</cfif>

<!--- Output number of results --->
<cfoutput>
	<cfif bookinfo.recordcount eq 0>
		#noResults()#
 		<cfelseif bookinfo.recordcount eq 1>
 			#oneResult()#
		<cfelse>
 			#manyResults()#
	</cfif>
</cfoutput>

<!--- No results --->
<cffunction name="noResults" access="private">
	There were no results to be found. Please try another search term.
</cffunction>

<!--- One result --->
<cffunction name="oneResult" access="private">
	<cfoutput>
 		<img src="images/#bookinfo.image[1]#" style="float:left; width:250px; margin:0.5em 0.75em 0 0" />
		<span><b>Title:</b> #bookinfo.title[1]#</span><br/>
 		<span><b>Publisher:</b> #bookinfo.name[1]#</span><br/>
		<span><b>Description:</b> #bookinfo.description[1]#</span>
	</cfoutput>
</cffunction>

<!--- Multiple results --->
<cffunction name="manyResults" access="private">
	There was more than one result: <br/>
	<ol class="nav nav-stacked">
 		<cfoutput query="bookinfo">
 			<li><a href="#cgi.SCRIPT_NAME#?p=details&searchme=#trim(isbn13)#">#trim(title)#</a></li>
 		</cfoutput>
	</ol>
</cffunction>