<cfsetting enableCFoutputOnly="true">

<cfoutput>

	<!DOCTYPE html>
	<style>body { font-family: sans-serif; }</style>

	<h1>cf_performance</h1>
	<p>
		This is an example page to showcase: <strong>#encodeForHtml("<cf_performance>")#</strong>
	</p>

	<!----------------------------------------------------------------------------><hr>

	<cf_performance>
		<cfset doSomething()>
	</cf_performance>

	<!----------------------------------------------------------------------------><hr>

	<cf_performance variable="x">
		<cfset doSomething()>
	</cf_performance>

	something took: #x#<br>

	<!----------------------------------------------------------------------------><hr>

	<cf_performance label="something">
		<cfset doSomething()>
	</cf_performance>

	<!----------------------------------------------------------------------------><hr>

	<cf_performance label="" type="inline">
		<cfset doSomething()>
	</cf_performance>

	<br>

	<cf_performance label="<inline>" type="inline">
		<cfset doSomething()>
	</cf_performance>

	<!----------------------------------------------------------------------------><hr>

	<cf_performance label="" type="outline">
		<cfset doSomething()>
	</cf_performance>
	<cf_performance label="<outline>" type="outline">
		<cfset doSomething()>
	</cf_performance>

	<!----------------------------------------------------------------------------><hr>

	<cf_performance label="" type="comment">
		<cfset doSomething()>
	</cf_performance>
	<cf_performance label="<comment>" type="comment">
		<cfset doSomething()>
	</cf_performance>

	<!----------------------------------------------------------------------------><hr>

	<cf_performance label="nanoseconds" returnType="ns">
		<cfset doSomething()>
	</cf_performance>

	<cf_performance label="microseconds" returnType="μs">
		<cfset doSomething()>
	</cf_performance>

	<cf_performance label="seconds" returnType="s">
		<cfset doSomething()>
	</cf_performance>

	<!----------------------------------------------------------------------------><hr>

	<cf_performance label="convert ≥1000 ms to s" returnType="s">
		<cfset sleep(1020)>
	</cf_performance>

	<!----------------------------------------------------------------------------><hr>

	<cf_performance nano="false" abort>
		<cfset doSomething()>
	</cf_performance>
	This line MUST NOT be visible!

</cfoutput>

<cffunction name="doSomething">
	<cfset sleep( randRange(20, 100) )>
</cffunction>