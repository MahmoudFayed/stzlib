  /////////////////////////////////////////////
 ///   FUNCTIONS FOR THE STZSTRING CLASS   ///
/////////////////////////////////////////////

func StzStringQ(str)
	return new stzString(str)

	#< @FunctionMisspelledForm

	func StzSrtringQ(str)
		return StzStringQ(str)

func StzNamedString(paNamed)
	if CheckingParams()
		if NOT (isList(paNamed) and Q(paNamed).IsPairOfStrings())
			StzRaise("Incorrect param type! paNamed must be a pair of strings.")
		ok
	ok

	oStr = new stzString(paNamed[2])
	oStr.SetName(paNamed[1])
	return ostr

	func StzNamedStringQ(paNamed)
		return StzNamedString(paNamed)

	func StzNamedStringXTQ(paNamed)
		return StzNamedString(paNamed)

func StzStringMethods()
	return Stz(:String, :Methods)

func StzStringAttributes()
	return Stz(:String, :Attributes)

func StzStringClassName()
	return Stz(:String, :ClassName)

	func StzStringClass()
		return StzStringClassName()

func IsNotString(pcStr)
	return NOT isString(pcStr)

	func IsNotAString(pcStr)
		return IsNotString(pcStr)

	func @IsNotString(pcStr)
		return IsNotString(pcStr)

	func @IsNotAString(pcStr)
		return IsNotString(pcStr)

func @IsAlpha(cStr)
	return StzStringQ(cStr).IsAlpha()

	#< @FunctionAlternativeForms

	func IsAlphabetical(cStr)
		return @IsAlpha(cStr)

	func @IsAlphabetical(cStr)
		return @IsAlpha(cStr)

	#--

	func IsAlphabetic(cStr)
		return @IsAlpha(cStr)

	func @IsAlphabetic(cStr)
		return @IsAlpha(cStr)

	#>

func @IsAlnum(cStr)
	return StzStringQ(cStr).IsAlnum()

	#< @FunctionAlternativeForms

	func IsAlphaNumerical(cStr)
		return @IsAlnum(cStr)

	func @IsAlphaNumerical(cStr)
		return @IsAlnum(cStr)

	#--

	func IsAlphaNumeric(cStr)
		return @IsAlnum(cStr)

	func @IsAlphanumeric(cStr)
		return @IsAlnum(cStr)

	#>

func IsNullString(cStr)
	if isString(cStr) and cStr = _NULL_
		return _TRUE_
	else
		return _FALSE_
	ok

	#< @FunctionAlternativeForms

	func IsEmptyString(cStr)
		return IsNullString(cStr)

	func ANullString(pcStr)
		return IsNullString(cStr)

	func IsAnEmptyString(cStr)
		return IsNullString(cStr)

	#--

	func @IsNullString(cStr)
		return IsNullString(cStr)

	func @IsEmptyString(cStr)
		return IsNullString(cStr)

	func @ANullString(pcStr)
		return IsNullString(cStr)

	func @IsAnEmptyString(cStr)
		return IsNullString(cStr)

	#==

	func IsNull(cStr)
		return IsNullString(cStr)

	func IsEmpty(cStr)
		return IsNullString(cStr)

	#--

	func @IsNull(cStr)
		return IsNullString(cStr)

	func @IsEmpty(cStr)
		return IsNullString(cStr)

	#==

	func StringIsEmpty(pcStr)
		return isString(pcStr) and pcStr = ""

		func StringIsNull(pcStr)
			return isString(pcStr) and pcStr = ""

	#>

func IsNonNullString(cStr)
	return NOT IsNullString(cStr)

	#< @FunctionAlternativeForms

	func IsNonEmptyString(cStr)
		return IsNonNullString(cStr)

	func ANonNullString(pcStr)
		return IsNonNullString(cStr)

	func IsANonEmptyString(cStr)
		return IsNonNullString(cStr)

	#--

	func @IsNonNullString(cStr)
		return IsNonNullString(cStr)

	func @IsNonEmptyString(cStr)
		return IsNonNullString(cStr)

	func @ANonNullString(pcStr)
		return IsNonNullString(cStr)

	func @IsANonEmptyString(cStr)
		return IsNonNullString(cStr)

	#>

func IsBlank(pcStr)
	return StzStringQ(pcStr).IsMadeOfSpaces()

	#< @FunctionAlternativeForms

	func IsBlankString(pcStr)
		return IsBlank(pcStr)

	func IsABlankString(pcStr)
		return IsBlank(pcStr)

	#--

	func @IsBlank(pcStr)
		return IsBlank(pcStr)

	func @IsBlankString(pcStr)
		return IsBlank(pcStr)

	func @IsABlankString(pcStr)
		return IsBlank(pcStr)

	#>

#TODO Some of these functions should call their corresponding (same)
# functions in the core layer

func StzContainsCS(pStrOrList, pSubStrOrItem, bCaseSensitive)
	if isString(pStrOrList)
		return StringContainsCS(pStrOrList, pSubStrOrItem, bCaseSensitive)

	but isList(pStrOrList)
		nPos = @FindFirstCS(pStrOrList, pSubStrOrItem, bCaseSensitive)
		if nPos > 0
			return _TRUE_
		else
			return _FALSE_
		ok
	else
		StzRaise("Can't proceed! pStrOrList must be a string or list.")
	ok

	func @ContainsCS(pStrOrList, pSubStrOrItem, bCaseSensitive)
		return StzContainsCS(pStrOrList, pSubStrOrItem, bCaseSensitive)

func StzContains(pStrOrList, pSubStrOrItem)
	return StzContainsCS(pStrOrList, pSubStrOrItem, _TRUE_)

	func @Contains(pStrOrList, pSubStrOrItem)
		return StzContains(pStrOrList, pSubStrOrItem)

#--

# A Ring-based implementation (#NOTE Internally, stzString uses Qt)
# This is made as altenartive to show how Softanza enhances Ring

#~> Solves the problem where substr() function in Ring returns 1
# if we are searching for an empty string!

func StringContainsCS(pcStr, pcSubStr, pCaseSensitive)
	if pcStr = "" or
	   pcSubStr = ""
		return _FALSE_
	ok

	bCase = CaseSensitive(pCaseSensitive)

	if bCase = _TRUE_
		if ring_substr1(pcStr, pcSubStr) > 0
			return _TRUE_
		else
			return _FALSE_
		ok
	else
		cStrLow = lower(pcStr)
		cSubStrLow = lower(pcSubStr)

		if ring_substr1(cStrLow, cSubStrLow) > 0
			return _TRUE_
		else
			return _FALSE_
		ok

	ok

	#< @FunctionAlternativeForms

	func @StringContainsCS(pcStr, pcSubStr, bCaseSensitive)
		return StringContainsCS(pcStr, pcSubStr, bCaseSensitive)

	func StzStringContainsCS(pcStr, pcSubStr, bCaseSensitive)
		return StringContainsCS(pcStr, pcSubStr, bCaseSensitive)

	func @StzStringContainsCS(pcStr, pcSubStr, bCaseSensitive)
		return StringContainsCS(pcStr, pcSubStr, bCaseSensitive)

	#>

func StringContains(pcStr, pcSubStr)
	return StringContainsCS(pcStr, pcSubStr, _TRUE_)

	func @StringContains(pcStr, pcSubStr)
		return StringContains(pcStr, pcSubStr)

	func StzStringContains(pcStr, pcSubStr)
		return StringContainsCS(pcStr, pcSubStr)

	func @StzStringContains(pcStr, pcSubStr)
		return StringContains(pcStr, pcSubStr)
#==

func StzReplaceCS(cStr, cSubStr, cNewSubStr, bCaseSensitive)
	if CheckParams()
		if NOT ( isString(cStr) and isString(cSubStr) and isString(cNewSubStr) )
			StzRaise("Incorrect params types! cStr, cSubStr, and cNewSubStr must all be strings.")
		ok
	ok

	if cStr = "" or cSubStr = ''
		return cStr
	ok
	
	bCase = CaseSensitive(bCaseSensitive)

	_oQStr_ = new QString2()
	_oQStr_.append(cStr)
	_oQStr_.replace_2(cSubStr, cNewSubStr, bCase)

	cResult = _oQStr_.mid(0, _oQStr_.size())
	return cResult

	#< @FunctionAlternativeForms

	func @ReplaceCS(cStr, cSubStr, cNewSubStr, bCaseSensitive)
		return StzReplaceCS(cStr, cSubStr, cNewSubStr, bCaseSensitive)

	func ReplaceCS(str, cSubStr, cNewSubStr, bCaseSensitive)
		return StzReplaceCS(cStr, cSubStr, cNewSubStr, bCaseSensitive)

	#>

func StzReplace(cStr, cSubStr, cNewSubStr)
	return StzReplaceCS(cStr, cSubStr, cNewSubStr, _TRUE_)

	func @Replace(cStr, cSubStr, cNewSubStr)
		return StzReplace(cStr, cSubStr, cNewSubStr)

	func Replace(cStr, cSubStr, cNewSubStr)
		return StzReplace(cStr, cSubStr, cNewSubStr)

func StzSplitCS(cStr, cSubStr, bCaseSensitive)

	oQStr = new QString2()
	oQStr.append(cStr)
	
	oQStrList = oQStr.split(cSubStr, 0, bCaseSensitive)
	
	acResult = []
	for i = 0 to oQStrList.size()-1
		acResult + oQStrList.at(i)	
	next

	return acResult

func StzSplit(cStr, cSubStr)
	return StzSplitCS(cStr, cSubStr, 0)

#--

# Trim function (to use instead of the one provided by the standard library)

func StzTrim(cStrOrList)
	if CheckParams()
		if NOT (isString(cStrOrList) or isList(cStrOrList))
			StzRaise("Incorrect param type! cStrOrList must be a string or list.")
		ok
	ok

	if isString(cStrOrList)
		return TrimString(cStrOrList)

	else // isList()
		return TrimList(cStrOrList)
	ok

	func @trim(cStrOrList)
		return StzTrim(cStrOrList)

func TrimString(cStr)
	if CheckParams()
		if NOT isString(cStr)
			StzRaise("Incorrect param type! cStr must be a string.")
		ok
	ok

	oQStr = new QString2()
	oQStr.append(cStr)

	cResult = oQStr.trimmed()
	return cResult

	func @TrimString(cStr)
		return TrimString(cStr)

	func StzTrimString(cStr)
		return TrimString(cStr)

func TrimList(aList)
	if CheckParams()
		if NOT isList(aList)
			StzRaise("Incorrect param type! aList must be a list.")
		ok
	ok

	oList = new stzList(aList)
	aResult = oList.Trimmed()
	return aResult

	func @TrimList(aList)
		return TrimList(aList)

	func StzTrimList(aList)
		return TrimList(aList)

func StzTrimLeft(cStrOrList)
	if CheckParams()
		if NOT (isString(cStrOrList) or isList(cStrOrList))
			StzRaise("Incorrect param type! cStrOrList must be a string or list.")
		ok
	ok

	if isString(cStrOrList)
		return StzStringQ(cStrOrList).TrimmedLeft()
	else
		return StzListQ(cStrOrList).TrimmedLeft()
	ok

	func @TrimLeft(cStrOrList)
		return StzTrimLeft(cStrOrList)

func StzTrimRight(cStrOrList)
	if CheckParams()
		if NOT (isString(cStrOrList) or isList(cStrOrList))
			StzRaise("Incorrect param type! cStrOrList must be a string or list.")
		ok
	ok

	if isString(cStrOrList)
		return StzStringQ(cStrOrList).TrimmedRight()
	else
		return StzListQ(cStrOrList).Trimmedright()
	ok

	func @TrimRight(cStrOrList)
		return StzTrimRight(cStrOrList)

func StzTrimStart(cStrOrList)
	if CheckParams()
		if NOT (isString(cStrOrList) or isList(cStrOrList))
			StzRaise("Incorrect param type! cStrOrList must be a string or list.")
		ok
	ok

	if isString(cStrOrList)
		return StzStringQ(cStrOrList).TrimmedStart()
	else
		return StzListQ(cStrOrList).TrimmedStart()
	ok

	func @TrimStart(cStrOrList)
		return StzTrimStart(cStrOrList)

	func TrimStart(cStrOrList)
		return StzTrimStart(cStrOrList)

func StzTrimEnd(cStrOrList)
	if CheckParams()
		if NOT (isString(cStrOrList) or isList(cStrOrList))
			StzRaise("Incorrect param type! cStrOrList must be a string or list.")
		ok
	ok

	if isString(cStrOrList)
		return StzStringQ(cStrOrList).TrimmedEnd()
	else
		return StzListQ(cStrOrList).Trimmedright()
	ok

	func @TrimEnd(cStrOrList)
		return StzTrimEnd(cStrOrList)

	func TrimEnd(cStrOrList)
		return StzTrimStart(cStrOrList)


#--

func StzStringToQString(oStr)
	return oStr.QStringObject()
	
func StringIsLocaleAbbreviation(cStr)
	oStr = new stzString(cStr)
	return oStr.IsLocaleAbbreviation()
	
	func @IsLocaleAbbreviation(cStr)
		return StringIsLocaleAbbreviation(cStr)

func StringIsLanguageAbbreviation(cStr)
	oStr = new stzString(cStr)
	return oStr.IsLanguageAbbreviation()

	func @IsLanguageAbbreviation(cStr)
		return StringIsLanguageAbbreviation(cStr)

func StringIsShortLanguageAbbreviation(cStr)
	oStr = new stzString(cStr)
	return oStr.IsShortLanguageAbbreviation()

	func @IsShortLanguageAbbreviation(cStr)
		return StringIsShortLanguageAbbreviation(cStr)

func StringIsLongLanguageAbbreviation(cStr)
	oStr = new stzString(cStr)
	return oStr.IsLongLanguageAbbreviation()

	func @IsLongLanguageAbbreviation(cStr)
		return StringIsLongLanguageAbbreviation(cStr)

func StringIsLanguageName(cStr)
	oStr = new stzString(cStr)
	return oStr.IsLanguageName()

	func @IsLanguageName(cStr)
		return StringIsLanguageName(cStr)

func StringIsLanguageNumber(cStr)
	oStr = new stzString(cStr)
	return oStr.IsLanguageNumber()

	func @IsLanguageNumber(cStr)
		return StringIsLanguageNumber(cStr)

func StringIsCountryAbbreviation(cStr)
	oStr = new stzString(cStr)
	return oStr.IsCountryAbbreviation()

	func @IsCountryAbbreviation(cStr)
		return StringIsCountryAbbreviation(cStr)

func StringIsCountryName(cStr)
	oStr = new stzString(cStr)
	return oStr.IsCountryName()

	func @IsCountryName(cStr)
		return StringIsCountryName(cStr)

func StringIsCountryNumber(cStr)
	oStr = new stzString(cStr)
	return oStr.IsCountryNumber()

	func @IsCountryNumber(cStr)
		return StringIsCountryNumber(cStr)

func StringIsShortCountryAbbreviation(cStr)
	oStr = new stzString(cStr)
	return oStr.IsShortCountryAbbreviation()

	func @IsShortCountryAbbreviation(cStr)
		return StringIsShortCountryAbbreviation(cStr)

func StringIsLongCountryAbbreviation(cStr)
	oStr = new stzString(cStr)
	return oStr.IsLongCountryAbbreviation()

	func @IsLongCountryAbbreviation(cStr)
		return StringIsLongCountryAbbreviation(cStr)

func StringIsScriptAbbreviation(cStr)
	oStr = new stzString(cStr)
	return oStr.IsScriptAbbreviation()

	func @IsScriptAbbreviation(cStr)
		return StringIsScriptAbbreviation(cStr)

func StringIsScriptName(cStr)
	oStr = new stzString(cStr)
	return oStr.IsScriptName()

	func @IsScriptName(cStr)
		return StringIsScriptName(cStr)

func StringIsScriptNumber(cStr)
	oStr = new stzString(cStr)
	return oStr.IsScriptNumber()

	func @IsScriptNumber(cStr)
		return StringIsScriptNumber(cStr)

func StringIsLowercase(cStr)
	return StzStringQ(cStr).IsLowercase()

	func @IsLowercase(cStr)
		return StringIsLowercase(cStr)

func StringIsUppercase(cStr)
	return StzStringQ(cStr).IsUppercase()

	func @IsUppercase(cStr)
		return StringIsUppercase(cStr)

func StringLowercased(cStr)
	oStr = new stzString(cStr)
	return oStr.Lowercased()
	
	func StringLowercase(cStr)
		return StringLowercased(cStr)

	func @Lowercased(cStr)
		return StringLowercased(cStr)

	func @Lowercase(cStr)
		return StringLowercased(cStr)

func StringUppercased(cStr)
	oStr = new stzString(cStr)
	return oStr.Uppercased()
	
	func StringUppercase(cStr)
		return StringUppercased(cStr)

	func @Uppercased(cStr)
		return StringUppercased(cStr)

	func @Uppercase(cStr)
		return StringUppercased(cStr)

func StringTitlecased(cStr)
	oStr = new stzString(cStr)
	return oStr.Titlecased()
	
	func StringTitlecase(cStr)
		return StringTitlecased(cStr)

	func Titlecase(cStr)
		return StringTitlecased(cStr)

	func Titlecased(cStr)
		return StringTitlecased(cStr)

	func @Titlecased(cStr)
		return StringTitlecased(cStr)
	
	func @Titlecase(cStr)
		return StringTitlecased(cStr)

#===

func IsSorted(pcStrOrList)
	if IsSortedString(pcStrOrList) or IsSortedList(pcStrOrList)
		return _TRUE_
	else
		return _FALSE_
	ok

	func @IsSorted(pcStrOrList)
		return IsSorted(pcStrOrList)

func IsSortedInAscending(pcStrOrList)
	if IsSortedStringInAscending(pcStrOrList) or IsSortedListInAscending(pcStrOrList)
		return _TRUE_
	else
		return _FALSE_
	ok

	#< @FunctionAlternativeForms

	func IsSortedUp(pcStrOrList)
		return IsSortedInAscending(pcStrOrList)

	#--

	func @IsSortedInAscending(pcStrOrList)
		return IsSortedInAscending(pcStrOrList)

	func @IsSortedUp(pcStrOrList)
		return IsSortedInAscending(pcStrOrList)

	#>

func IsSortedInDescending(pcStrOrList)
	if IsSortedStringInDescending(pcStrOrList) or IsSortedListInDescending(pcStrOrList)
		return _TRUE_
	else
		return _FALSE_
	ok

	#< @FunctionAlternativeForms

	func IsSortedDown(pcStrOrList)
		return IsSortedInDescending(pcStrOrList)

	func @IsSortedInDescending(pcStrOrList)
		return IsSortedInDescending(pcStrOrList)

	func @IsSortedDown(pcStrOrList)
		return IsSortedInDescending(pcStrOrList)

	#>

#--

func IsSortedString(pcStr)
	if IsSortedStringInAscending(pcStr) or IsSortedStringInDescending(pcStr)
		return _TRUE_
	else
		return _FALSE_
	ok

	#< @FunctionAlternativeForms

	func IsStringSorted(pcStr)
		return IsSortedString(pcStr)

	#--

	func @IsSortedString(pcStr)
		return IsSortedString(pcStr)

	func @IsStringSorted(pcStr)
		return IsSortedString(pcStr)

	#>

func IsSortedStringInAscending(pcStr)
	if NOT isString(pcStr)
		return _FALSE_
	ok

	return StzStringQ(pcStr).IsSortedInAscending()

	#< @FunctionAlternativeForms

	func IsStringSortedInAscending(pcStr)
		return IsSortedStringInAscending(pcStr)

	#--

	func IsSortedStringUp(pcStr)
		return IsSortedStringInAscending(pcStr)

	func IsSortedUpString(pcStr)
		return IsSortedStringInAscending(pcStr)

	func IsStringSortedUp(pcStr)
		return IsSortedStringInAscending(pcStr)

	#==

	func @IsSortedStringInAscending(pcStr)
		return IsSortedStringInAscending(pcStr)

	func @IsStringSortedInAscending(pcStr)
		return IsSortedStringInAscending(pcStr)

	#--

	func @IsSortedStringUp(pcStr)
		return IsSortedStringInAscending(pcStr)

	func @IsSortedUpString(pcStr)
		return IsSortedStringInAscending(pcStr)

	func @IsStringSortedUp(pcStr)
		return IsSortedStringInAscending(pcStr)

	#>

func IsSortedStringInDescending(pcStr)

	if NOT isString(pcStr)
		return _FALSE_
	ok

	return StzStringQ(pcStr).IsSortedInDescending()

	#< @FunctionAlternativeForms

	func IsStringSortedInDescending(pcStr)
		return IsSortedStringInDescending(pcStr)

	#--

	func IsSortedStringDown(pcStr)
		return IsSortedStringInDescending(pcStr)

	func IsSortedDownString(pcStr)
		return IsSortedStringInDescending(pcStr)

	func IsStringSortedDown(pcStr)
		return IsSortedStringInDescending(pcStr)

	#==

	func @IsSortedStringInDescending(pcStr)
		return IsSortedStringInDescending(pcStr)

	func @IsStringSortedInDescending(pcStr)
		return IsSortedStringInDescending(pcStr)

	#--

	func @IsSortedStringDown(pcStr)
		return IsSortedStringInDescending(pcStr)

	func @IsSortedDownString(pcStr)
		return IsSortedStringInDescending(pcStr)

	func @IsStringSortedDown(pcStr)
		return IsSortedStringInDescending(pcStr)

	#>

#===

#TODO: Review if the String...() functions are necessary

func StringAlignXT(cStr, nWidth, cChar, cDirection)
	oString = new stzString(cStr)
	return oString.AlignXTQ(nWidth, cChar, cDirection).Content()
	
	func @AlignXT(cStr, nWidth, cChar, cDirection)
		return StringAlignXT(cStr, nWidth, cChar, cDirection)

	func AlignXT(cStr, nWidth, cChar, cDirection)
		return StringAlignXT(cStr, nWidth, cChar, cDirection)

#--

func StringLeftAlign(cStr, nWidth)
	return StringAlignXT(cStr, nWidth, " ", :Left)

	func StringAlignLeft(cStr, nWidth)
		return StringLeftAlign(cStr, nWidth)

	func LeftAlign(cStr, nWidth)
		return StringLeftAlign(cStr, nWidth)

	func AlignLeft(cStr, nWidth)
		return StringLeftAlign(cStr, nWidth)

	func @LeftAlign(cStr, nWidth)
		return StringLeftAlign(cStr, nWidth)

	func @AlignLeft(cStr, nWidth)
		return StringLeftAlign(cStr, nWidth)

func StringLeftAlignXT(cStr, nWidth, cChar)
	return StringAlignXT(cStr, nWidth, cChar, :Left)

	func StringAlignLeftXT(cStr, nWidth, cChar)
		return StringLeftAlignXT(cStr, nWidth, cChar)

	func LeftAlignXT(cStr, nWidth, cChar)
		return StringLeftAlignXT(cStr, nWidth, cChar)

	func AlignLeftXT(cStr, nWidth, cChar)
		return StringLeftAlignXT(cStr, nWidth, cChar)

	func @LeftAlignXT(cStr, nWidth, cChar)
		return StringLeftAlignXT(cStr, nWidth, cChar)

	func @AlignLeftXT(cStr, nWidth, cChar)
		return StringLeftAlignXT(cStr, nWidth, cChar)

#--

func StringRightAlign(cStr, nWidth)
	return StringAlignXT(cStr, nWidth, " ", :Right)

	func StringAlignRight(cStr, nWidth)
		return StringRightAlign(cStr, nWidth)

	func RightAlign(cStr, nWidth)
		return StringRightAlign(cStr, nWidth)

	func AlignRight(cStr, nWidth)
		return StringRightAlign(cStr, nWidth)

	func @RightAlign(cStr, nWidth)
		return StringRightAlign(cStr, nWidth)

	func @AlignRight(cStr, nWidth)
		return StringRightAlign(cStr, nWidth)

func StringRightAlignXT(cStr, nWidth, cChar)
	return StringAlignXT(cStr, nWidth, cChar, :Right)

	func StringAlignRightXT(cStr, nWidth, cChar)
		return StringRightAlignXT(cStr, nWidth, cChar)

	func RightAlignXT(cStr, nWidth, cChar)
		return StringRightAlignXT(cStr, nWidth, cChar)

	func AlignRightXT(cStr, nWidth, cChar)
		return StringRightAlignXT(cStr, nWidth, cChar)

	func @RightAlignXT(cStr, nWidth, cChar)
		return StringRightAlignXT(cStr, nWidth, cChar)

	func @AlignRightXT(cStr, nWidth, cChar)
		return StringRightAlignXT(cStr, nWidth, cChar)
#--

func StringCenterAlign(cStr, nWidth)
	return StringAlignXT(cStr, nWidth, " ", :Center)

	func StringAlignCenter(cStr, nWidth)
		return StringCenterAlign(cStr, nWidth)

	func CenterAlign(cStr, nWidth)
		return StringCenterAlign(cStr, nWidth)

	func AlignCenter(cStr, nWidth)
		return StringCenterAlign(cStr, nWidth)

	func @CenterAlign(cStr, nWidth)
		return StringCenterAlign(cStr, nWidth)

	func @AlignCenter(cStr, nWidth)
		return StringCenterAlign(cStr, nWidth)

func StringCenterAlignXT(cStr, nWidth, cChar)
	return StringAlignXT(cStr, nWidth, cChar, :Center)

	func StringAlignCenterXT(cStr, nWidth, cChar)
		return StringCenterAlignXT(cStr, nWidth, cChar)

	func CenterAlignXT(cStr, nWidth, cChar)
		return StringCenterAlignXT(cStr, nWidth, cChar)

	func AlignCenterXT(cStr, nWidth, cChar)
		return StringCenterAlignXT(cStr, nWidth, cChar)

	func @CenterAlignXT(cStr, nWidth, cChar)
		return StringCenterAlignXT(cStr, nWidth, cChar)

	func @AlignCenterXT(cStr, nWidth, cChar)
		return StringCenterAlignXT(cStr, nWidth, cChar)
#===

func CountCS(pStrOrList, pSubStrOrItem, pCaseSensitive)
	if isSrtring(pStrOrList)
		return StringCountCS(pStrOrList, pSubStrOrItem, pCaseSensitive)

	but isList(pStrOrList)
		return ListCountCS(pStrOrList, pSubStrOrItem, pCaseSensitive)

	else
		StzRaise("Incorrect param type! pStrOrList must be a string or list.")
	ok

	func StzCountCS(pStrOrList, pSubStrOrItem, pCaseSensitive)
		return CountCS(pStrOrList, pSubStrOrItem, pCaseSensitive)

func Count(pStrOrList, pSubStrOrItem)
	return CountCS(pstrOrList, pSubStrOrItem, _TRUE_)

	func StzCount(pStrOrList, pSubStrOrItem)
		return Count(pStrOrList, pSubStrOrItem)

#--

func StringCountCS(pcStr, pcSubStr, pCaseSensitive)
	if CheckingParams()

		if isList(pcSubStr) and StzListQ(pcSubStr).IsOfNamedParam()
			pcSubStr = pcSubStr[2]
		ok

	ok

	if pcSubStr = ""
		return 0
	ok

	bCase = @CaseSensitive(pCaseSensitive)

	_cTempStr_ = pcStr
	_cSubStr_ = pcSubStr

	if bCase = _FALSE_
		_cTempStr_ = ring_lower(_cTempStr_)
		_cSubStr_  = ring_lower(_cSubStr_)
	ok

	# Early check

	n = ring_substr1(_cTempStr_, _cSubStr_)
	if n = 0
		return 0
	ok

	# Removing the substring from the string

	nLenBeforeRemove = StzStringQ(_cTempStr_).NumberOfChars()
	_cTempStr2_ = ring_substr2(_cTempStr_, _cSubStr_, "")
	nLenAfterRemove = StzStringQ(_cTempStr2_).NumberOfChars()

	nLenSubStr = StzStringQ(_cSubStr_).NumberOfChars()
	nResult = ( (nLenBeforeRemove - nLenAfterRemove) / nLenSubStr )

	return nResult

	func StzStringCountCS(pcStr, pcSubStr, pCaseSensitive)
		return StringCountCS(pcStr, pcSubStr, pCaseSensitive)

func StringCount(pcStr, pcSubStr)
	return StringCount(pcStr, pcSubStr, _TRUE_)

	func StzStringCount(pcStr, pcSubStr)
		return StringCount(pcStr, pcSubStr)

#--

func StringNumberOfChars(cStr)
	oString = new stzString(cStr)
	return oString.NumberOfChars()
	
	func @NumberOfChars(cStr)
		return StringNumberOfChars(cStr)

func StringReverseChars(cStr)
	oString = new stzString(cStr)
	return oString.CharsReversed()
	
	func @ReverseChars(cStr)
		return StringReverseChars(cStr)

func StringIsWord(cStr)
	oString = new stzString(cStr)
	return oString.IsWord()
	
	func @IsWord(cStr)
		return StringIsWord(cStr)

func StringNumberOfOccurrence(pcStr, pcSubStr)
	return StzStringQ(pcStr).NumberOfOccurrence(pcSubStr)
	
	func @NumberOfOccurrence(pcStr, pcSubStr)
		return StringNumberOfOccurrence(pcStr, pcSubStr)

func StringToUnicodes(pcStr)
	return StzStringQ(pcStr).Unicodes()
		
	func @ToUnicodes(pcStr)
		return StringToUnicodes(pcStr)

# Some functions used mainly in natural-code

func UppercaseOf(cStr)
	return StzStringQ(cStr).Uppercased()

	func UppercaseIn(cStr)
		return UppercaseOf(cStr)

func LowercaseOf(cStr)
	return StzStringQ(cStr).Lowercased()

	func LowercaseIn(cStr)
		return LowercaseOf(cStr)

func FoldcaseOf(cStr)
	return StzStringQ(cStr).Foldcase()

	func FoldcaseIn(cStr)
		return FoldcaseOf(cStr)

func NthCharOf(n, cStr)
	return StzStringQ(cStr)[n]

	func NthCharIn(n, cStr)
		return NthCharOf(n, cStr)

func NthLetterOf(n, cStr)
		aOnlyLetters = StzStringQ(cStr).OnlyLetters()
		return aOnlyLetters[n]

	func NthLetterIn(n, cStr)
		return NthLetterOf(n, cStr)

func StringIsArabicWord(pcStr)
	return StzStringQ(pcStr).IsArabicWord()

func StringIsCharName(pcStr)
	return StzStringQ(pcStr).IsCharName()

# Used for natural-coding

func Text(pcStr)
	#NOTE: In the future, there will be a difference
	# between String and Text
	if isString(pcStr)
		return pcStr
	ok

func NumberOfCharsOf(pcStr)
	return StzStringQ(pcStr).NumberOfChars()

	func NumberOfCharsIn(pcStr)
		return NumberOfCharsOf(pcStr)

func BothStringsAreEqualCS(pcStr1, pcStr2, pCaseSensitive)
	return StringsAreEqualCS( [ pcStr1, pcStr2 ], pCaseSensitive )

func BothStringsAreEqual(pcStr1, pcStr2)
	return BothStringsAreEqualCS(pcStr1, pcStr2, _TRUE_)

func StringsAreEqualCS(pacStr, pCaseSensitive)

	if CheckParams()
		if NOT @IsListOfStrings(pacStr)
			stzRaise("Incorrect param type! pacStr must b a list of strings!")
		ok
	
		if NOT len(pacStr) > 1
			stzRaise("You must provide at least two strings pacStr!")
		ok
	ok

	# Resolving pCaseSensitive

	_bCase_ = @CaseSensitive(pCaseSensitive)

	# Doing the job

	bResult = _TRUE_
	nLen = len(pacStr)

	if _bCase_ = _TRUE_
		
		cFirstStr = StzStringQ(pacStr[1]).Lowercased()
		
		for i = 2 to nLen
			if StzStringQ(pacStr[i]).Lowercased() != cFirstStr
				bResult = _FALSE_
				exit
			ok 
		next

		return bResult
	else

		cFirstStr = pacStr[1]
		
		for i = 1 to nLen
			if pacStr[i] != cFirstStr
				bResult = _FALSE_
				exit
			ok
		next

	ok

	return bResult

func StringsAreEqual(paStr)
	return StringsAreEqualCS(paStr, _TRUE_)

func RemoveDiacritics(pcStr)
	return StzStringQ(pcStr).DiacriticsRemoved()

func StringCases()
	return [ :Lowercase, :Uppercase, :Capitalcase, :Titlecase, :Foldercase ]

func StringCase(pcStr)

	return StzStringQ(pcStr).StringCase()

func Interpolate(pcStr)
	return Q(pcStr).Interpolated()

	#< @FunctionMisspelledForm

	func Interpoltate(pcStr)
		return Intrepolate(pcStr)

	func Intrepolate(pcStr)
		return Interpolate(pcStr)

	#>

func NCopies(n, p)
	if isList(p) and Q(p).IsFromOrOfNamedParam()
		p = p[2]
	ok

	return Q(p).CopiedNTimes(n)

	func 2Copies(p)
		return NCopies(2, p)
	
	func 3Copies(p)
		return NCopies(3, p)

	func 4Copies(p)
		return NCopies(4, p)

	func 5Copies(p)
		return NCopies(3, p)

func WithoutSpaces(pcStr)
	cResult = StzSrtringQ(pcStr).WithoutSpaces()
	#NOTE: StzSrtringQ() is misspelled but Softanza recognizes it!

	return cResult

	func @WithoutSpaces(pcStr)
		return WithoutSpaces(pcStr)

	#< @FunctionMisspelledForms

	func WithoutSapces(pcStr)
		return WithoutSpaces(pcStr)

	func @WithoutSapces(pcStr)
		return WithoutSpaces(pcStr)

	#>

func IsMarquer(cStr)
	if CheckingParams()
		if NOT isString(cStr)
			StzRaise("Incorrect param type! cStr must be a string.")
		ok
	ok

	return Q(cStr).IsMarquer()

	func IsAMarquer(cStr)
		return IsMarquer(cStr)

	func StringIsMarquer(cStr)
		return IsMarquer(cStr)

	func StringIsAMarquer(cStr)
		return IsMarquer(cStr)

	func @IsMarquer(cStr)
		return IsMarquer(cStr)

	func @IsAMarquer(cStr)
		return IsMarquer(cStr)

	func @StringIsMarquer(cStr)
		return IsMarquer(cStr)

	func @StringIsAMarquer(cStr)
		return IsMarquer(cStr)

func RepeatInString(pcSubStr, nTimes)
	if CheckParams()
		if NOT isString(pcSubStr)
			StzRaise("Incorrect param type! pcSubStr must be a string.")
		ok

		if NOT isNumber(nTimes)
			StzRaise("incorrect param type! nTimes must be a number.")
		ok
	ok

	#WARING // don't use Ring + concatenation, becuase it shows performance
	# issues with large unciode strings (tested with an arabic string, 1M times)

	_oQStrList_ = new QStringList()
	for i = 1 to nTimes
		_oQStrList_.append(pcSubStr)
	next

	cResult = _oQStrList_.join("")
	return cResult

	#< @FunctionAlternativeForms

	func RepeatInAString(pcSubStr, nTimes)
		return RepeatInString(pcSubStr, nTimes)

	func @RepeatInString(pcSubStr, nTimes)
		return RepeatInString(pcSubStr, nTimes)

	func @RepeatInAString(pcSubStr, nTimes)
		return RepeatInString(pcSubStr, nTimes)

	#>

func BothAreMarquers(pcStr1, pcStr2)
	if BothAreStrings(pcStr1, pcStr2) and
	   Q(pcStr1).IsMarquer() and Q(pcStr2).IsMarquer()

		return _TRUE_
	else
		return _FALSE_
	ok

	func @BothAreMarquers(pcStr1, pcStr2)
		return BothAreMarquers(pcStr1, pcStr2)

func IsNumberInString(str)
	return StzStringQ(str).IsNumberInString()

	func @IsNumberInstring(str)
		return IsNumberInString(str)

func IsIntegerInString(str)
	return StzStringQ(str).IsIntegerInString()

	func @IsIntegerInstring(str)
		return IsIntegerInString(str)

func IsNumberOrListInString(str)
	return StzStringQ(str).IsNumberOrListInString()

	func IsStringOrNumberInString(str)
		return IsNumberOrListInString(str)

	func @IsNumberOrListInString(str)
		return IsNumberOrListInString(str)

	func @IsStringOrNumberInString(str)
		return IsNumberOrListInString(str)

func IsRealInString(str)
	return StzStringQ(str).IsRealInString()

	func @IsRealInstring(str)
		return IsRealInString(str)

func @IsPalindrome(p)
	if isList(p)
		if len(p) < 2
			return _FALSE_
		ok

		return StzListQ(p).IsPalindrome()

	but isString(p)
		oStr = new stzString(p)
		if oStr.NumberOfChars() < 2
			return _FALSE_
		ok

		return StzStringQ(p).IsPalindrome()
	else
		StzRaise("Incorrect param type! p must be a string or list.")
	ok

	def IsPalindrom(p)
		return @IsPalindrome(p)

	func @IsPalindrom(p)
		return @IsPalindrome(p)

	func IsMirrored(p)
		return @IsPalindrome(p)

	func @IsMirrored(p)
		return @IsPalindrome(p)

func @IsPunct(p)
	if isString(p)
		return StzStringQ(p).IsPunct()

	but isList(p) and @IsListOfChars(p)
		#TODO
	else
		StzRaise("Incorrect param type! p must be a string or list of chars.")
	ok

#--

func MarquerChar()
	return _cMarquerChar

	func DefaultMarquerChar()
		return _cMarquerChar

	func @MarquerChar()
		return _cMarquerChar

	func Marquer()
		return _cMarquerChar

	func @Marquer()
		return _cMarquerChar

func SetMarquerChar(c)
	if NOT (isString(c) and IsChar(c))
		StzRaise("Incorrect param type! c must be a char.")
	ok

	_cMarquerChar = c

	#NOTE // A marquer char can be set at the global level or string object level

	func SetDefaultMarquerChar()
		_cMarquerChar = c

	func @SetMarquerChar()
		_cMarquerChar = c

	func SetMarquer()
		_cMarquerChar = c

	func @SetMarquer()
		_cMarquerChar = c