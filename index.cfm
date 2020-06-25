<cfoutput>

	<h1>cf_performance</h1>
	<p>
		This is an example page to showcase: <strong>#encodeForHtml("<cf_performance>")#</strong>
	</p>

	<cf_performance>
		<cfset doSomething()>
	</cf_performance>

	<!----------------------------------------------------------------------------><hr>

	<cf_performance variable="x">
		<cfset doSomething()>
	</cf_performance>
	<cf_performance variable="y">
		<cfset doAnotherThing()>
	</cf_performance>

	something took: #x#<br>
	anotherThing took: #y#<br>

	<!----------------------------------------------------------------------------><hr>

	<cf_performance label="something">
		<cfset doSomething()>
	</cf_performance>
	<cf_performance label="anotherThing">
		<cfset doAnotherThing()>
	</cf_performance>

</cfoutput>

<cffunction name="doSomething">
	<cfset sleep(100)>
</cffunction>
<cffunction name="doAnotherThing">
	<cfset sleep(50)>
</cffunction>