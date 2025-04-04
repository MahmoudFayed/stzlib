
# Softanza List Regex Engine

func StzListRegexQ(cPattern)
	return new stzListex(cPattern)

func StzListexQ(cPattern)
	return StzListRegexQ(cPattern)

func Lx(cPattern)
	return StzListRegexQ(cPattern)

class stzListex

	@cPattern		# The original pattern string
	@aTokens		# List of parsed token definitions
	@bDebugMode = false	# Debug mode flag

	# Regular expression patterns for various token types

	@cNumberPattern = '(?:-?\d+(?:\.\d+)?)'
	@cStringPattern = "(?:" + char(34) + "[^" + char(34) + "]*" + char(34) + "|\'[^\']*\')"
	@cSimpleListPattern = '\[\s*[^\[\]]*\s*\]'
	@cRecursiveListPattern = '\[\s*(?:[^\[\]]|\[(?:[^\[\]]|(?R))*\])*\s*\]'
	@cListPattern = @cSimpleListPattern  # Default to simple pattern
	@cAnyPattern = "" # Will be set in init()

	@cQuantifierPattern = '^([+*?])'
	@cSingleNumberPattern = '^(\d+)'
	@cRangePattern = '^(\d+)-(\d+)'
	@cSetPattern = '^(\{(.*?)\})'
	@cUniqueSetPattern = '^(\{(.*?)\})U'

	@cSteppedRangePattern = '^(\{(\d+)-(\d+):(\d+)\})'
	@cSteppedRangeUniquePattern = '^(\{(\d+)-(\d+):(\d+)\})U'

	@aList = []

	  #-------------------#
	 #  INITIALIZATION   #
	#-------------------#

	def init(cPattern)
		if NOT isString(cPattern)
			raise("Error: Pattern must be a string")
		ok

		# Initialize @cAnyPattern as the combination of all patterns
		@cAnyPattern = @cNumberPattern + "|" + @cStringPattern + "|" + @cListPattern

		# Normalize the pattern by ensuring it has outer brackets
		@cPattern = This.NormalizePattern(cPattern)
		
		# Parse the pattern into tokens
		@aTokens = This.ParsePattern(@cPattern)
		
		# Optimize the token sequence if possible
		This.OptimizeTokens()

	  #--------------------#
	 #  NORMALIZING DATA  #
	#--------------------#

	def NormalizePattern(cPattern)
		cPattern = @trim(cPattern)
		
		# Ensure pattern is enclosed in square brackets
		if NOT (StartsWith(cPattern, "[") and EndsWith(cPattern, "]"))
			cPattern = "[" + cPattern + "]"
		ok
		
		return cPattern

	def NormalizeListString(xList) # Used for comparison

		cList = "" + xList
		
		# Remove all whitespace for consistent comparison

		cList = StzStringQ(cList).
			RemoveManyQ([ " ", char(9), char(10), char(13) ]).
			Content()

		return cList

	  #----------------------------------------#
	 #  PARSING PATTERNS (STRING --> TOKENS)  #
	#========================================#

	def ParsePattern(cPattern)
		# Remove outer brackets and trim
		oPattern = new stzString(cPattern)
		oPattern.TrimQ().RemoveFirstAndLastCharsQ().Trim()
		cInner = oPattern.Content()

		# Split at top-level commas
		aParts = SplitAtTopLevelCommas(cInner)

		# Parse each part into tokens
		aTokens = []
		for i = 1 to len(aParts)
			aTokens + This.ParseToken(@trim(aParts[i]))
		next

		return aTokens

	  #-------------------------#
	 #  PARSING A GIVEN TOKEN  #
	#-------------------------#

	def ParseToken(cTokenStr)

		# Check for negation prefix

		bNegated = FALSE

    		if StartsWith(cTokenStr, "@!")
        		bNegated = true
        		cTokenStr = StzStringQ(cTokenStr).SectionRemoved(1, 2)  # Remove @! prefix
    		ok

    		# Handle nested list patterns

    		if StartsWith(cTokenStr, "[") and EndsWith(cTokenStr, "]")
        		return This.ParseNestedPattern(cTokenStr, bNegated)
   		ok

    		# Alternation handling

    		if @Contains(cTokenStr, "|")
        		return This.ParseAlternationToken(cTokenStr, bNegated)
   		ok

    		# Ensure token starts with @ or add it

    		if NOT StartsWith(cTokenStr, "@")
        		cTokenStr = "@" + cTokenStr
    		ok
    
    		# Extract keyword (first two characters)

    		oTokenStr = new stzString(cTokenStr)
    		cKeyword = oTokenStr.Section(1, 2)

    		# Default values

    		nMin = 1
    		nMax = 1
    		nQuantifier = 1
    		aSetValues = []
    		bRequireUnique = false

    		# Get remainder after keyword

    		cRemainder = ""
    		nLenToken = oTokenStr.NumberOfChars()

    		if nLenToken > 2
        		cRemainder = oTokenStr.Section(3, nLenToken)
    		ok

    		# Range and quantifier processing

		if len(cRemainder) > 0

			# Check for explicit range pattern like "1-3"

			oRangeMatch = rx(@cRangePattern)

			if oRangeMatch.Match(cRemainder)

				cMatch = oRangeMatch.Matches()[1]
				acSplits = @split(cMatch, "-")

				nMin = @number(acSplits[1])
				nMax = @number(acSplits[2])

           			if nMin > nMax
                			stzraise("Error: Invalid range - min value greater than max: " + cTokenStr)
            			ok

            			# Remove the processed range from remainder

				nRangeLen = len(acSplits[1]) + 1 + len(acSplits[2])  # +1 for the "-"
				cRemainder = right(cRemainder, len(cRemainder) - nRangeLen)

			else

				# Check for +, *, ? quantifiers

				oQMatch = rx(@cQuantifierPattern)

				if oQMatch.Match(cRemainder)

					aMatches = oQMatch.Matches()
					cQuantifier = aMatches[1]

					switch cQuantifier

					on "+"
						nMin = 1
						nMax = 999999999  # Effectively unlimited

					on "*"
						nMin = 0
						nMax = 999999999  # Effectively unlimited

					on "?"
						nMin = 0
						nMax = 1

					off

					cRemainder = right(cRemainder, len(cRemainder) - 1)

				else
					# Check for a single number quantifier

					oNumberMatch = rx(@cSingleNumberPattern)

					if oNumberMatch.Match(cRemainder)

						aMatches = oNumberMatch.Matches()
						nQuantifier = @number(aMatches[1])
						nMin = nQuantifier
						nMax = nQuantifier
                    
						# Remove the processed quantifier from remainder

						cRemainder = right(cRemainder, len(cRemainder) - len(aMatches[1]))

					ok
				ok
			ok
		ok

		# Set constraints processing including stepped ranges

		if len(cRemainder) > 0

			# Check for {start-end:step}U format (stepped range with uniqueness)

			oSteppedRangeUniqueMatch = rx(@cSteppedRangeUniquePattern)

			if oSteppedRangeUniqueMatch.Match(cRemainder)

				aMatches = oSteppedRangeUniqueMatch.Matches()
				aSplits = StzStringQ(aMatches[1]).
					RemoveFirstCharQ().RemoveNLastCharsQ(2).
					ReplaceQ(":", "-").
					Split("-")

				nStart = @number(aSplits[1])
				nEnd = @number(aSplits[2])
				nStep = @number(aSplits[3])
            
				if nStart > nEnd
					stzraise("Error: Invalid stepped range - start value greater than end: " + cTokenStr)
				ok
            
            			if nStep <= 0
					stzraise("Error: Invalid step value - must be positive: " + cTokenStr)
				ok
            
				# Generate values based on the stepped range

				aSetValues = []

				for i = nStart to nEnd step nStep
					aSetValues + i
				next
            
				# Remove the processed part from remainder

				nSetLen = len(aMatches[1]) + 1  # +1 for the U
				cRemainder = right(cRemainder, len(cRemainder) - nSetLen)
            
				bRequireUnique = true  # Uniqueness is required

			else
				# Check for {start-end:step} format (regular stepped range)

				oSteppedRangeMatch = rx(@cSteppedRangePattern)

				if oSteppedRangeMatch.Match(cRemainder)

					aMatches = oSteppedRangeMatch.Matches()

					aSplits = StzStringQ(aMatches[1]).
						RemoveFirstAndLastCharsQ().
						ReplaceQ(":", "-").
						Split("-")

					nStart = @number(aSplits[1])
					nEnd = @number(asplits[2])
					nStep = @number(aSplits[3])
                
					if nStart > nEnd
						stzraise("Error: Invalid stepped range - start value greater than end: " + cTokenStr)
					ok
                
					if nStep <= 0
						stzraise("Error: Invalid step value - must be positive: " + cTokenStr)
					ok
                
					# Generate values based on the stepped range

					aSetValues = []

					for i = nStart to nEnd step nStep
						aSetValues + i
					next
                
					# Remove the processed part from remainder

					nSetLen = len(aMatches[1])
					cRemainder = right(cRemainder, len(cRemainder) - nSetLen)
                
					bRequireUnique = false  # By default, stepped ranges don't require uniqueness

				else

					# Check for {values}U format (set with uniqueness constraint)

					oUniqueSetMatch = rx(@cUniqueSetPattern)

					if oUniqueSetMatch.Match(cRemainder)

						aMatches = oUniqueSetMatch.Matches()
						cSetContent = StzStringQ(aMatches[1]).RemoveFirstCharQ().NLastCharsRemoved(2)
                    
						# Parse the set values with uniqueness enforcement

						aSetValues = This.ParseSetValues(cSetContent, "any", true)
						bRequireUnique = TRUE
                    
						# Remove the processed part from remainder

						nSetLen = len(aMatches[1]) + 1 # +1 for the U
						cRemainder = right(cRemainder, len(cRemainder) - nSetLen)

					else
						# Check for {values} format (regular set)

						oSetMatch = rx(@cSetPattern)

						if oSetMatch.Match(cRemainder)
							aMatches = oSetMatch.Matches()
							cSetcontent = StzStringQ(aMatches[1]).FirstAndLastCharsRemoved()
							# Parse the set values

							aSetValues = This.ParseSetValues(cSetContent, "any", false)

							# Remove the processed part from remainder

							nSetLen = len(aMatches[1])
							cRemainder = right(cRemainder, len(cRemainder) - nSetLen)

						ok
					ok
				ok
			ok
		ok

		# If there is still content in cRemainder, it's unexpected

		if len(cRemainder) > 0
			stzraise("Error: Unexpected content in token: " + cRemainder)
		ok

		# Set token type based on keyword

		switch cKeyword

		on "@N"
			aToken = [
				[ "keyword", "@N" ],
				[ "type", "number" ],
				[ "pattern", @cNumberPattern ]
			]
    
		on "@S"
			aToken = [
				[ "keyword", "@S" ],
				[ "type", "string" ],
				[ "pattern", @cStringPattern ]
			]

		on "@L"
			aToken = [
				[ "keyword", "@L" ],
				[ "type", "list" ],
            			[ "pattern", @cListPattern ]
			]

		on "@$"
			aToken = [
				[ "keyword", "@$" ],
				[ "type", "any" ],
				[ "pattern", @cAnyPattern ]
			]

		other
			raise("Error: Unknown token type: " + cKeyword)
		off

		# Add the processed information to the token

		aToken + [ "min", nMin ]
		aToken + [ "max", nMax ]
		aToken + [ "quantifier", nQuantifier ]  # Store the explicit quantifier if any

		if len(aSetValues) > 0
			aToken + [ "hasset", true ]
			aToken + [ "setvalues", aSetValues ]
			aToken + [ "requireunique", bRequireUnique ]

		else
			aToken + [ "hasset", false ]
			aToken + [ "setvalues", [] ]
			aToken + [ "requireunique", false ]
		ok

		# Add negation flag

		aToken + [ "negated", bNegated ]

		return aToken

	  #--------------------------------#
	 #  PARSING AN ALTERNATION TOKEN  #
	#--------------------------------#

	def ParseAlternationToken(cTokenStr, bNegated)

		# Split alternation tokens

		aParts = @split(cTokenStr, "|")
		nLen = len(aParts)

		aAlternatives = []

		for i = 1 to nLen

			cPart = @trim(aParts[i])

			# Add negation back to the first token if it exists

			if bNegated and i = 1
				cPart = "@!" + cPart
			ok

			aAlternatives + This.ParseToken(cPart)

		next
		
		# Create an alternation token

		aToken = [
			[ "keyword", "@ALT" ],
			[ "type", "alternation" ],
			[ "alternatives", aAlternatives ],
			[ "min", 1 ],
			[ "max", 1 ],
			[ "quantifier", 1 ],
			[ "hasset", false ],
			[ "setvalues", [] ],
			[ "requireunique", false ],
			[ "negated", bNegated ]
		]
		
		return aToken

	  #----------------------------#
	 #  PARSING A NESTED PATTERN  #
	#----------------------------#

	def ParseNestedPattern(cNestedPattern, bNegated)

		# Remove outer brackets

		cInner = StzStringQ(cNestedPattern).RemoveFirstAndLastCharsQ().Content()

		# Parse the nested pattern into tokens

		aNestedTokens = []

		# Split at top-level commas

		aParts = SplitAtTopLevelCommas(cInner)

		# Parse each part into tokens

		for i = 1 to len(aParts)
			aNestedTokens + This.ParseToken(@trim(aParts[i]))
		next

		# Process quantifiers for the entire nested pattern

		nMin = 1
		nMax = 1
		nQuantifier = 1
    
		# Check if a quantifier is appended after the closing bracket

		if len(cNestedPattern) > 2
			cRest = StzStringQ(cNestedPattern).SectionRemoved(1, len(cNestedPattern) - 1)

			# Handle +, *, ? quantifiers
			oQMatch = rx(@cQuantifierPattern).Match(cRest)
			if oQMatch
				aMatches = oQMatch.Matches()
				cQuantifier = aMatches[1]

				switch cQuantifier
				on "+"
					nMin = 1
					nMax = 999999999  # Effectively unlimited
				on "*"
					nMin = 0
					nMax = 999999999  # Effectively unlimited
				on "?"
					nMin = 0
					nMax = 1
				off

			else

				# Check for a single number quantifier

				oNumberMatch = rx(@cSingleNumberPattern).Match(cRest)
				if oNumberMatch
					aMatches = oNumberMatch.Matches()
					nQuantifier = number(aMatches[1])
					nMin = nQuantifier
					nMax = nQuantifier
				ok
			ok
		ok
    
		# Create a nested pattern token

		aToken = [
			[ "keyword", "@NESTED" ],
			[ "type", "nested" ],
			[ "pattern", @cRecursiveListPattern ],
			[ "nestedTokens", aNestedTokens ],
			[ "min", nMin ],
			[ "max", nMax ],
			[ "quantifier", nQuantifier ],
			[ "hasset", false ],
			[ "setvalues", [] ],
			[ "requireunique", false ],
			[ "negated", bNegated ]
		]
    
		return aToken

	  #--------------------------#
	 #  PARSING THE SET VALUES  #
	#--------------------------#

	def ParseSetValues(cSetContent, cType, bCheckUnique)

		aValues = []
		
		# Split by semicolons

		aParts = @split(cSetContent, ";")
		
		for i = 1 to len(aParts)

			cValue = @trim(aParts[i])
			
			if cValue = ""
				loop # Skip empty values
			ok
			
			switch cType

			on "number"

				if rx("^(-?\d+(?:\.\d+)?)$").Match(cValue) // #TODO: Put it an attribute variable
					nValue = @number(cValue)
					
					# Check for uniqueness if required

					if bCheckUnique and @Contains(aValues, nValue)
						raise("Error: Duplicate value in unique set: " + cValue)
					ok
					
					aValues + nValue
				else
					raise("Error: Invalid number in set: " + cValue)
				ok

			on "string"

				# For strings, normalize quoted values

				if (StartsWith(cValue, "'") and EndsWith(cValue, "'")) or
				   (StartsWith(cValue, '"') and EndsWith(cValue, '"'))

					# Store with quotes for pattern matching
					cNormalizedValue = cValue

				else
					# Add quotes for consistency
					cNormalizedValue = '"' + cValue + '"'
				ok

				# Check for uniqueness if required

				if bCheckUnique
					cUnquotedValue = This.RemoveQuotes(cValue)
					
					for j = 1 to len(aValues)
						if This.RemoveQuotes(aValues[j]) = cUnquotedValue
							raise("Error: Duplicate value in unique set: " + cValue)
						ok
					next
				ok
				
				aValues + cNormalizedValue
				
			on "list"

				# For lists, keep the brackets and format

				if NOT (StartsWith(cValue, "[") and EndsWith(cValue, "]"))
					raise("Error: Invalid list format in set: " + cValue)
				ok
				
				# Check for uniqueness if required

				if bCheckUnique and @Contains(aValues, cValue)
					raise("Error: Duplicate value in unique set: " + cValue)
				ok
				
				aValues + cValue
				
			on "any"
				# Any type can be in the set

				if bCheckUnique and @Contains(aValues, cValue)
					raise("Error: Duplicate value in unique set: " + cValue)
				ok
				
				aValues + cValue
			off
		next
		
		return aValues

	  #--------------------------------#
	 #  OPTIMIZING THE PARSED TOKENS  #
	#================================#

	def OptimizeTokens()

		# This method performs optimizations on the token sequence
		# For now, it just merges adjacent tokens of the same type
		# with min-max constraints
		
		nLen = len(@aTokens)
		
		if nLen <= 1
			return # Nothing to optimize
		ok
		
		for i = nLen to 2
			aToken1 = @aTokens[i-1]
			aToken2 = @aTokens[i]
			
			# Check if tokens can be merged (same keyword, no sets, adjacent ranges)

			if aToken1[:keyword] = aToken2[:keyword] and
			   NOT aToken1[:hasset] and NOT aToken2[:hasset]
				
				# If both tokens have min-max ranges, try to merge them

				if aToken1[:min] != aToken1[:max] and aToken2[:min] != aToken2[:max]
					nNewMin = @Min([ aToken1[:min], aToken2[:min] ])
					nNewMax = aToken1[:max] + aToken2[:max]
					
					# Update the first token and remove the second

					@aTokens[i-1][:min] = nNewMin
					@aTokens[i-1][:max] = nNewMax
					del(@aTokens, i)
				ok
			ok
		next

	  #----------------------------------------------------------#
	 #   MATCHING THE LIST PROVIDED AGAINST THE PATTERN TOKENS  #
	#==========================================================#

	def Match(paList)

		if NOT isList(paList)
			return FALSE
		ok

		# Convert the list to string representations for matching

		aElements = []
		nLen = len(paList)

		for i = 1 to nLen
			aElements + paList[i]  # Store actual values, not string representations
		next

		# Perform the matching

		try
			bResult = This.MatchTokensToElements(@aTokens, aElements)
			@aList = paList
			return bResult

		catch
			if @bDebugMode
				? "Error during matching: " + cError
			ok

			return FALSE
		done

		#< @FunctionMisspelledForm

		def Macth(pList)
			return This.Match(pList)

		#>

	  #--------------------------------------------------#
	 #  MATCHING TOKENS TO THE ELEMENTS OF THE PATTERN  #
	#--------------------------------------------------#
 
	# Method used by Match() and BacktrackMatch() methods

	def MatchTokensToElements(aTokens, aElements)
		nLenTokens = len(aTokens)
		nLenElements = len(aElements)
    
		# Use backtracking to find valid matches

		return This.BacktrackMatch(aTokens, aElements, 1, 1, [])

	  #-------------------------------------------------------#
	 #  A REGEX-LIKE BACKTRACKING MECHANISM, MADE FOR LISTS  #
	#-------------------------------------------------------#

	def BacktrackMatch(aTokens, aElements, nTokenIndex, nElementIndex, aUsedValues)

		nLenTokens = len(aTokens)
		nLenElements = len(aElements)

		# Add debug output if needed

		if @bDebugMode
			? "Matching token " + nTokenIndex + " against element " + nElementIndex
			? "Token: " + @tokens[nTokenIndex][:keyword] + ", Element count: " + (nLenElements - nElementIndex + 1)
		ok

		# Base case: If we've processed all tokens

		if nTokenIndex > nLenTokens
			# Ensure ALL elements have been exactly matched
			return nElementIndex > nLenElements
		ok

		# Get current token

		aToken = aTokens[nTokenIndex]

		# Create local copy of used values for uniqueness tracking

		aLocalUsedValues = []

		for i = 1 to len(aUsedValues)
			aLocalUsedValues + aUsedValues[i]
		next

		# Alternation token handling

		if aToken[:keyword] = "@ALT"

			# Try each alternative

			for i = 1 to len(aToken[:alternatives])

				aAltTokens = aToken[:alternatives]
				aNewTokens = []

				# Prepare tokens list with the current alternative

				for j = 1 to nTokenIndex - 1
					aNewTokens + aTokens[j]
				next

				aNewTokens + aAltTokens[i]

				for j = nTokenIndex + 1 to nLenTokens
					aNewTokens + aTokens[j]
				next

				# Check this alternative's match

				if This.BacktrackMatch(aNewTokens, aElements, nTokenIndex, nElementIndex, aLocalUsedValues)
					return true
				ok
			next

			return false
		ok

		# Handle nested pattern tokens

		if aToken[:keyword] = "@NESTED"

			# Try different match counts within min-max range

			nMin = @Min([aToken[:max], nLenElements - nElementIndex + 1])

			for nMatchCount = aToken[:min] to nMin

				bSuccess = TRUE
				nElemIdx = nElementIndex
				aLocalUsedValuesCopy = aLocalUsedValues

				# Attempt to match exactly nMatchCount nested lists

				for i = 1 to nMatchCount
					if nElemIdx > nLenElements
						bSuccess = false
						exit
					ok

					xElement = aElements[nElemIdx]

					# Check if element is a list for nested matching

					if NOT isList(xElement)
						bSuccess = false
						exit
					ok

					# Apply negation if specified (for the list type check)

					if aToken[:negated]
						bSuccess = false  # If negated and is a list, this fails
						exit
					ok
            
					# Recursively match the nested tokens against the nested list

					if NOT This.MatchTokensToElements(aToken[:nestedTokens], xElement)
						bSuccess = false
						exit
					ok

					nElemIdx++
				next

				if bSuccess
					# For final token, ensure complete matching
					if nTokenIndex = nLenTokens
						if nElemIdx = nLenElements + 1
							return true
						ok
					else
						# For non-final tokens, recursively match the rest
						if This.BacktrackMatch(aTokens, aElements, nTokenIndex + 1, nElemIdx, aLocalUsedValuesCopy)
							return TRUE
						ok
					ok
				ok
			next
    
			# Handle optional nested tokens

			if aToken[:min] = 0
				if This.BacktrackMatch(aTokens, aElements, nTokenIndex + 1, nElementIndex, aLocalUsedValues)
					return TRUE
				ok
			ok
    
			return FALSE
		ok

		# Try different match counts within min-max range (original token handling)

		nMin = @Min([aToken[:max], nLenElements - nElementIndex + 1])

		for nMatchCount = aToken[:min] to nMin

			bSuccess = true
			nElemIdx = nElementIndex
			aMatchedElements = []
			aLocalUsedValuesCopy = aLocalUsedValues

			# Attempt to match exactly nMatchCount elements

			for i = 1 to nMatchCount
				if nElemIdx > nLenElements
					bSuccess = false
					exit
				ok

				xElement = aElements[nElemIdx]
            
				# Convert element to string for pattern matching if needed

				cElement = @@(xElement)

				# Handle negated tokens with stepped ranges
				# We need to separate type checking from set membership checking
            
				# 1. First perform basic type checking

				bTypeMatched = false

				if aToken[:type] = "list"
					bTypeMatched = rx(@cRecursiveListPattern).MatchRecursive(cElement)
				else
					bTypeMatched = rx("^" + aToken[:pattern] + "$").Match(cElement)
				ok
            
				# For negated tokens without sets, we're done with type checking

				if aToken[:negated] and NOT aToken[:hasset]
					bMatched = NOT bTypeMatched
				else
					# For normal tokens or negated tokens with sets, we continue
					bMatched = bTypeMatched
				ok
            
				# Debug output

				if @bDebugMode
					? "Element: " + cElement + ", Type matched: " + bTypeMatched + ", Overall matched: " + bMatched
				ok
            
				# If type check passes, now handle set constraints

				if bMatched and aToken[:hasset]

					xElemValue = This.ConvertToType(cElement, aToken[:type])
					bInSet = false
                
					# Check if the element is in the set

					for j = 1 to len(aToken[:setvalues])
						xSetValue = aToken[:setvalues][j]
                    
						# Direct comparison for set membership

						if This.CompareValues(xElemValue, xSetValue, aToken[:type])
							bInSet = true
							exit
						ok
					next
                
					# Debug output

					if @bDebugMode
						? "Element: " + cElement + ", In set: " + bInSet + ", Negated: " + aToken[:negated]
					ok
                
					# Apply set membership logic

					if aToken[:negated]
						# For negated tokens, we want to match elements NOT in the set
						bMatched = NOT bInSet
					else
						# For normal tokens, we want to match elements IN the set
						bMatched = bInSet
					ok
                
					# Handle uniqueness constraint

					if bMatched and aToken[:requireunique]

						# Check if the element has been used before

						for j = 1 to len(aLocalUsedValuesCopy)

							if This.CompareValues(xElemValue, aLocalUsedValuesCopy[j], aToken[:type])
								bMatched = false
								exit
							ok
						next
                    
						# If still matched, add to used values list

						if bMatched
							aLocalUsedValuesCopy + xElemValue
						ok
					ok
				ok
            
				# Final match decision

				if bMatched
					aMatchedElements + xElement
					nElemIdx++
				else
					bSuccess = false
					exit
				ok
			next

			if bSuccess
				# Ensure COMPLETE matching when processing the last token

				if nTokenIndex = nLenTokens
					if nElemIdx = nLenElements + 1
						return TRUE
					ok
				else
					# For non-final tokens, recursively match the rest

					if This.BacktrackMatch(aTokens, aElements, nTokenIndex + 1, nElemIdx, aLocalUsedValuesCopy)
						return TRUE
					ok
				ok
			ok
		next

		# Handle optional tokens

		if aToken[:min] = 0
			if This.BacktrackMatch(aTokens, aElements, nTokenIndex + 1, nElementIndex, aLocalUsedValues)
				return TRUE
			ok
		ok

		return false

	  #------------------#
	 #  HELPER METHODS  #
	#------------------#

	def JoinSetValues(aValues)

		cResult = ""
		
		for i = 1 to len(aValues)
			if i > 1
				cResult += "; "
			ok
			
			cResult += "" + aValues[i]
		next
		
		return cResult

	def SplitAtTopLevelCommas(cStr)

		acParts = []
		cCurrent = ""
		nDepth = 0
		acChars = Chars(cStr)
		nLen = len(acChars)

		for i = 1 to nLen

			cChar = acChars[i]

			if cChar = "["
				nDepth++
				cCurrent += cChar

			but cChar = "]"
				nDepth--
				cCurrent += cChar

			but cChar = "," and nDepth = 0
				acParts + @trim(cCurrent)
				cCurrent = ""

			else
				cCurrent += cChar
			ok
		next

		if len(cCurrent) > 0
			acParts + @trim(cCurrent)
		ok

		return acParts

	def RemoveQuotes(cStr)
		if (StartsWith(cStr, "'") and EndsWith(cStr, "'")) or
		   (StartsWith(cStr, '"') and EndsWith(cStr, '"'))
			return StzStringQ(cStr).FirstAndLastCharsRemoved()
		ok
		return cStr

	# Helper function for value comparison by type

	def CompareValues(xValue1, xValue2, cType)

		switch cType

		on "number"
			return xValue1 = xValue2

		on "string"
			cVal1 = This.RemoveQuotes("" + xValue1)
			cVal2 = This.RemoveQuotes("" + xValue2)
			return cVal1 = cVal2

		on "list"
			cVal1 = This.NormalizeListString(xValue1)
			cVal2 = This.NormalizeListString(xValue2)
			return cVal1 = cVal2

		on "any"
			if isNumber(xValue1) and isNumber(xValue2)
				return xValue1 = xValue2
			ok
        
			cVal1 = This.RemoveQuotes("" + xValue1)
			cVal2 = This.RemoveQuotes("" + xValue2)
  
			if ( StartsWith(cVal1, "[") and EndsWith(cVal1, "]") ) and
			   ( StartsWith(cVal2, "[") and EndsWith(cVal2, "]") )

				cVal1 = This.NormalizeListString(cVal1)
				cVal2 = This.NormalizeListString(cVal2)
			ok

			return cVal1 = cVal2
		off

	# Convert a string representation to the appropriate type for comparison

	def ConvertToType(cValue, cType)
		
		switch cType

		on "number"
			# Convert to numeric value
			return @number(cValue)
			
		on "string"
			# Return as is - normalization happens in CompareValues
			return cValue
			
		on "list"
			# Keep list representation as is
			return cValue
			
		on "any"
			# Keep as is for any type
			return cValue
		off

	  #--------------------------------#
	 #  CAOTURING THE MATCHED VALUES  #
	#--------------------------------#

	def MatchesXT()

		oStr = new stzString(@@(This.List()))
		acValues = ( oStr.RemoveManyQ([ "[ ", " ]" ]).Split(", ") )
		nLen = len(acValues)

		aValues = []

		for i = 1 to nLen
			cCode = 'val = ' + acValues[i]
			eval(cCode)
			aValues + val
		next
		
		aResult = @Association([ This.Keywords(), aValues ])

		return aResult

	def Matches()

		oStr = new stzString(@@(This.List()))
		acValues = ( oStr.RemoveManyQ([ "[ ", " ]" ]).Split(", ") )
		nLen = len(acValues)

		aResult = []

		for i = 1 to nLen
			cCode = 'val = ' + acValues[i]
			eval(cCode)
			aResult + val
		next

		return aResult

	  #-----------------#
	 #  DEBUG METHODS  #
	#-----------------#

	def EnableDebug()

		@bDebugMode = true
		return self

	def DisableDebug()

		@bDebugMode = false
		return self

	def Pattern()
		return @cPattern

		def DomainPattern()
			return This.Pattern()

	def Tokens()
		return @aTokens

		def MatchInfo()
			return This.Tokens()

		def TokensXT()
			return This.Tokens()

	def Keywords()

		oStr = new stzString(This.Pattern())
		acKeys = ( oStr.RemoveManyQ([ "[ ", " ]" ]).Split(", ") )
		nLen = len(acKeys)

		acResult = []

		for i = 1 to nLen
			cCode = 'cKey = "' + acKeys[i] + '"'
			eval(cCode)
			acResult + cKey
		next

		return acResult

	def List()
		return @aList
