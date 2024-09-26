load "stdlib.ring"

#NOTE This class is dedicatd to Mahmoud for the effors he deployed
# in delivering the 1.21 version of Ring

$ART_LETTERS = [
	[ "A" , ["░▄███▄░", "██▀░▀██", "███████", "██░░░██", "██░░░██"] ],
        [ "B" , ["███▄▄░░", "██░░░██", "███▄▄░░", "██░░░██", "███▄▄░░"] ],
        [ "C" , ["░▄███▄░", "██▀░░░░", "██░░░░░", "██▄░░░░", "░▀███▀░"] ],
        [ "D" , ["███▄▄░░", "██░░░██", "██░░░██", "██░░░██", "███▄▄░░"] ],
        [ "E" , ["███████", "██░░░░░", "█████░░", "██░░░░░", "███████"] ],
        [ "F" , ["███████", "██░░░░░", "█████░░", "██░░░░░", "██░░░░░"] ],
        [ "G" , ["░▄███▄░", "██▀░░░░", "██░░███", "██▄░░██", "░▀███▀░"] ],
        [ "H" , ["██░░░██", "██░░░██", "███████", "██░░░██", "██░░░██"] ],
        [ "I" , ["███████", "░░██░░░", "░░██░░░", "░░██░░░", "███████"] ],
        [ "J" , ["░░░░░██", "░░░░░██", "░░░░░██", "██░░░██", "░▀███▀░"] ],
        [ "K" , ["██░░░██", "██░░██░", "█████░░", "██░░██░", "██░░░██"] ],
        [ "L" , ["██░░░░░", "██░░░░░", "██░░░░░", "██░░░░░", "███████"] ],
        [ "M" , ["██░░░██", "███░███", "██▀█▀██", "██░░░██", "██░░░██"] ],
        [ "N" , ["██░░░██", "███░░██", "██▀█░██", "██░▀███", "██░░░██"] ],
        [ "O" , ["░▄███▄░", "██▀░▀██", "██░░░██", "██▄░▄██", "░▀███▀░"] ],
        [ "P" , ["███▄▄░░", "██░░░██", "███▄▄░░", "██░░░░░", "██░░░░░"] ],
        [ "Q" , ["░▄███▄░", "██▀░▀██", "██░▄▄██", "██▄░▀██", "░▀███▀█"] ],
        [ "R" , ["███▄▄░░", "██░░░██", "███▄▄░░", "██░▀██░", "██░░░██"] ],
        [ "S" , ["░▄███▄░", "██▀░░░░", "░▀███▄░", "░░░░▀██", "███▄▄█▀"] ],
        [ "T" , ["███████", "░░██░░░", "░░██░░░", "░░██░░░", "░░██░░░"] ],
        [ "U" , ["██░░░██", "██░░░██", "██░░░██", "██▄░▄██", "░▀███▀░"] ],
        [ "V" , ["██░░░██", "██░░░██", "██░░░██", "░██░██░", "░░▀█▀░░"] ],
        [ "W" , ["██░░░██", "██░░░██", "██░█░██", "███▄███", "░██▀██░"] ],
        [ "X" , ["██░░░██", "░██░██░", "░░███░░", "░██░██░", "██░░░██"] ],
        [ "Y" , ["██░░░██", "░██░██░", "░░███░░", "░░██░░░", "░░██░░░"] ],
        [ "Z" , ["███████", "░░░▄██░", "░▄██░░░", "▄██░░░░", "███████"] ],

        [ " " , ["░░░", "░░░", "░░░", "░░░", "░░░"] ],
        [ "." , ["░░░", "░░░", "░░░", "░░░", "▓▓░"] ],
        [ "," , ["░░░", "░░░", "░░░", "▄▄░", "▀░░"] ],
        [ "!" , ["██░", "██░", "██░", "░░░", "██░"] ],
        [ "?" , ["▄▄█", "░░█", "▄█░", "░░░", "▄▄░"] ],

	[ "0" , ["░█████░", "██░░░██", "██░░░██", "██░░░██", "░█████░"] ],
	[ "1" , ["░░███░░", "░████░░", "░░░██░░", "░░░██░░", "░█████░"] ],
	[ "2" , ["░█████░", "██░░░██", "░░░███░", "░███░░░", "███████"] ],
	[ "3" , ["░█████░", "██░░░██", "░░░███░", "██░░░██", "░█████░"] ],
	[ "4" , ["░░░███░", "░░████░", "░██░██░", "███████", "░░░░██░"] ],
	[ "5" , ["███████", "██░░░░░", "██████░", "░░░░░██", "██████░"] ],
	[ "6" , ["░█████░", "██░░░░░", "██████░", "██░░░██", "░█████░"] ],
	[ "7" , ["███████", "░░░░░██", "░░░███░", "░░██░░░", "░██░░░░"] ],
	[ "8" , ["░█████░", "██░░░██", "░█████░", "██░░░██", "░█████░"] ],
	[ "9" , ["░█████░", "██░░░██", "░██████", "░░░░░██", "░█████░"] ],
	[ "+" , ["░░░██░░░", "░░░██░░░", "███████░", "░░░██░░░", "░░░██░░░"] ],
	[ "-" , ["░░░░░░░", "░░░░░░░", "███████", "░░░░░░░", "░░░░░░░"] ],
	[ "*" , ["░░░░░░░", "██░░██░", "░░██░░░", "██░░██░", "░░░░░░░"] ],
	[ "/" , ["░░░░░██", "░░░░██░", "░░░██░░", "░░██░░░", "░██░░░░"] ],
	[ "=" , ["░░░░░░░", "███████", "░░░░░░░", "███████", "░░░░░░░"] ]

]

func StringArt(str)
	oStr = new stkStringArt(str)
	return oStr.Art()

func BoxedStringArt(str)
	oStr = new stkStringArt(str)
	return oStr.Boxed()

class stkStringArt
	@content

	def init(str)
		if not isString(str)
			raise("ERR-" + StkError(:IncorrectParamType))
		ok

		@content = str

	def Content()
		return @content

		def String()
			return @content

	def Art()
 
		result = ""
		word = pvtSpacify(@content)
		for i = 1 to 5
			for char in word
				result += pvtGetCharArt($ART_LETTERS, char, i)
			next
			result += nl
		next
			
		return left(result, len(result) - 1)  // Remove the last newline

	def Boxed()

	    # First, convert the input string to string art
	    artContent = This.Art()
	    
	    # Split the string art into lines
	    lines = split(artContent, nl)
	    
	    # Find the maximum line length
	    maxLength = 0
	    for line in lines
	        if len(line) > maxLength
	            maxLength = len(line) / 3
	        ok
	    next
	    
	    # Create the boxed result
	    result = "╭" + copy("─", (maxLength + 2)) + "╮" + nl
	    
	    for line in lines
	        result += "│ " + line + copy(" ", (maxLength - len(line))) + " │" + nl
	    next
	    
	    result += "╰" + copy("─", (maxLength + 2)) + "╯"
	    
	    return result


	PRIVATE

	func pvtGetCharArt(letters, char, line)
	    char = upper(char)
	    for letter in letters
	        if letter[1] = char
	            return letter[2][line]
	        ok
	    next
	    return "██"  // Default for unknown characters
	
	func pvtSpacify(str)
	    nLen = len(str)
	    cResult = ""
	    for i = 1 to nLen
	        cResult += str[i] + " "
	    next
	    
	    return trim(cResult)
	