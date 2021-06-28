<cfif (not structKeyExists(VARIABLES, "THISTAG")) or (not THISTAG.hasEndTag)>
	<cfexit>
</cfif>

<!--- BEGIN: attributes --->

	<cfparam name="ATTRIBUTES.type" 		type="string" 	default="dump"> <!--- "dump", "inline", "outline", "comment" --->

	<cfparam name="ATTRIBUTES.label" 		type="string" 	default="PERFORMANCE">
	<cfparam name="ATTRIBUTES.abort" 		type="boolean" 	default="false">

	<cfparam name="ATTRIBUTES.nano" 		type="boolean" 	default="true">
	<cfparam name="ATTRIBUTES.returnType" 	type="string" 	default=""> <!--- "ns", "μs", "ms", "s" --->

	<cfparam name="ATTRIBUTES.variable" 	type="string" 	default="">

<!--- END: attributes --->

<cfif THISTAG.executionMode eq "start">

	<cfif ATTRIBUTES.nano>
		<cfset LOCAL.start = createObject("java", "java.lang.System").nanoTime()>
	<cfelse>
		<cfset LOCAL.start = getTickCount()>
	</cfif>

</cfif>

<cfif THISTAG.executionMode eq "end">

	<cfif ATTRIBUTES.nano>
		<cfset LOCAL.end = createObject("java", "java.lang.System").nanoTime()>
	<cfelse>
		<cfset LOCAL.end = getTickCount()>
	</cfif>

	<cfset LOCAL.final = (LOCAL.end - LOCAL.start)>

	<cfif not len(ATTRIBUTES.returnType)>

		<cfif ATTRIBUTES.nano>
			<cfif LOCAL.final gte 10000000000>
				<cfset ATTRIBUTES.returnType = "s">
			<cfelse>
				<cfset ATTRIBUTES.returnType = "ms">
			</cfif>
		<cfelse>
			<cfif LOCAL.final gte 10000>
				<cfset ATTRIBUTES.returnType = "s">
			<cfelse>
				<cfset ATTRIBUTES.returnType = "ms">
			</cfif>
		</cfif>

	</cfif>

	<cfswitch expression="#ATTRIBUTES.returnType#">

		<cfcase value="ns nanoseconds" delimiters=" ">
			<cfif ATTRIBUTES.nano>
				<cfset PERFORMANCE["Result"] = (LOCAL.final & " ns")>
			<cfelse>
				<cfset PERFORMANCE["Result"] = ((LOCAL.final * 1000000) & " ns")>
			</cfif>
		</cfcase>

		<cfcase value="μs microseconds" delimiters=" ">
			<cfif ATTRIBUTES.nano>
				<cfset PERFORMANCE["Result"] = ((LOCAL.final / 1000) & " μs")>
			<cfelse>
				<cfset PERFORMANCE["Result"] = ((LOCAL.final * 1000) & " μs")>
			</cfif>
		</cfcase>

		<cfcase value="ms milliseconds" delimiters=" ">
			<cfif ATTRIBUTES.nano>
				<cfset PERFORMANCE["Result"] = ((LOCAL.final / 1000000) & " ms")>
			<cfelse>
				<cfset PERFORMANCE["Result"] = (LOCAL.final & " ms")>
			</cfif>
		</cfcase>

		<cfcase value="s seconds" delimiters=" ">
			<cfif ATTRIBUTES.nano>
				<cfset PERFORMANCE["Result"] = ((LOCAL.final / 1000000000) & " s")>
			<cfelse>
				<cfset PERFORMANCE["Result"] = ((LOCAL.final / 1000) & " s")>
			</cfif>
		</cfcase>

		<cfdefaultcase>
			<cfset PERFORMANCE["Result"] = LOCAL.final>
		</cfdefaultcase>

	</cfswitch>

	<cfif len(ATTRIBUTES.variable)>

		<cfset CALLER[ATTRIBUTES.variable] = PERFORMANCE["Result"]>

	<cfelse>

		<cfswitch expression="#ATTRIBUTES.type#">

			<cfcase value="inline">
				<cfoutput>#( len(ATTRIBUTES.label) ? (encodeForHtml(ATTRIBUTES.label) & " ") : "" )##PERFORMANCE["Result"]#</cfoutput>
			</cfcase>

			<cfcase value="outline">
				<cfoutput><fieldset><cfif len(ATTRIBUTES.label)><legend>#encodeForHtml(ATTRIBUTES.label)#</legend></cfif>#PERFORMANCE["Result"]#</fieldset></cfoutput>
			</cfcase>

			<cfcase value="comment">
				<cfoutput><!-- #( len(ATTRIBUTES.label) ? encodeForHtml(ATTRIBUTES.label) : "" )# #PERFORMANCE["Result"]# --></cfoutput>
			</cfcase>

			<cfdefaultcase>
				<cfdump label="#ATTRIBUTES.label#" var="#PERFORMANCE#" abort="#ATTRIBUTES.abort#">
			</cfdefaultcase>

		</cfswitch>

	</cfif>

	<cfif ATTRIBUTES.abort><cfabort></cfif>

</cfif>
