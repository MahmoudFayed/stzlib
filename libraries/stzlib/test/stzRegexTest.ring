load "../max/stzmax.ring"

/*----------------#
#  PARTIAL MATCH  #
#-----------------#
*/
pr()

# A partial match occurs when the pattern matches up to
# the end of the input string, but needs more characters
# to potentially complete the match.

# For example, if your pattern is "hello\d" and the input
# is "hello", it's a partial match because adding a digit
# would make it a full match.

rx("hello\d") {

	Match("hello")

	? HasMatch()

	? HasPartialMatch()

	? PartialMatchStart()

	? PartialMatchEnd()

	? PartialMatchLength()

}

proff()

/*----------------#
#  Recursiveness  #
#-----------------#

# Recursive patterns in REGEX are commonly used to match nested structures in text.
# They can be used to validate the correctness of nested HTML tags, return them or
# replace them ; parse and manipulate complex deep data structures like JSON and XML.

#TODO Reflect on how to simplify it in Softanza

pr()

# Matching a string containing any number of duplicated "abc"

rx("(abc(?R)?)") { ? IsValid() ? Match("abc") ? Match("abcabcabc") + NL }
#--> TRUE
#--> TRUE
#--> TRUE

# Matching a string that contains balanced parentheses

rx("(\((?R)*\))") { ? MatchMany([ "()", "(())", "((()))" ]) + NL }
#--> 3

# Matching nested HTML tags

rx("<([^>]+)>(?R)*") { ? Match("<div><b>HELLO</b></div>") }
#--> TRUE

proff()

/*----------------#
#  Partial Match  #
#-----------------#

pr()

# Partial matching allows you to find patterns that are
# incomplete or still in progress. This is especially
# useful for:

# - Real-time input validation
# - Incremental search
# - Auto-completion features
# - Processing streaming data

# TODO Reflect on how to simplify it in Softanza

rx = new stzRegex("hello")
? rx.Match("hel")
#--> FALSE

# MatchType { NormalMatch, PartialPreferCompleteMatch, PartialPreferFirstMatch, NoMatch }

nQNormalMatch = 0
nQPartialPreferCompleteMatch = 1
nQPartialPreferFirstMatch = 2
nQNoMatch = 3

nStartAt = 0

# nQOption = {
#	"CaseInsensitive" 	|= 1
#	"DotMatchesAll" 	|= 2
#	"MultiLine"		|= 4
#	"ExtendedSyntax"	|= 8
#	"NonGreedy"		|= 16
#	"DontCapture"		|= 32
#	"UseUnicode"		| 64
#	"DisableOptimizations"	|= 128

# Qt macth(str, nStartPos, nMatchType, aMatchOptions)

? rx.QRegexObject().match("hel", nStartAt, nQPartialPreferCompleteMatch, 0).hasPartialmatch()

proff()

/*---------------------------------#
#  Understanding Qt Regex Options  #
#----------------------------------#

# Test 1: Basic dot behavior

pr()

txt = "hello
world"

o = new stzRegex("hello.world")

# Without DotMatchesAll

? o.MatchXT(txt, 1, :NormalMatch, []) # Returns false - dot doesn't match newline
#--> FALSE

# With DotMatchesAll
? o.MatchXT(txt, 1, :NormalMatch, [ "DotMatchesAll" ]) # Returns true - dot matches newline
#--> TRUE

proff()
# Executed in almost 0 second(s) in Ring 1.22

/*-- Test 2: Case sensitivity

pr()

txt = "Hello World"

o = new stzRegex("")
o.SetPattern("hello world")

# Case sensitive (default)

? o.MatchXT(txt, 1, :NormalMacth, [])  # Returns false - different case
#--> FALSE

# Case insensitive

? o.MatchXT(txt, 1, :NormalMatch, [ "CaseInsensitive" ])  # Returns true - case ignored
#--> TRUE

proff()
# Executed in almost 0 second(s) in Ring 1.22

/*-- Test 3: Greedy vs Non-greedy

pr()

txt = "<p>First</p><p>Second</p>"

o = new stzRegex("")
o.SetPattern("<p>.*</p>")

# Greedy (default): Matches entire string

? o.MatchXT(txt, 1, :NormalMatch, [ "DotMatchesAll" ])
#--> TRUE

# Non-greedy: Matches first <p> only

? o.MatchXT(txt, 1, :NormalMatch, [ "DotMatchesAll", "NonGreedy" ])
#--> TRUE

proff()
# Executed in almost 0 second(s) in Ring 1.22

/*-- Test 4: Line boundaries

pr()

txt = "Start: Line1
End: Line2"

o = new stzRegex("")
o.SetPattern("^End:.*$") # ^ only matches start of string

# Without MultiLine

? o.MatchXT(txt, 1, :NormalMatch, [])
#--> FALSE

# With MultiLine: now ^ matches start of any line

? o.MatchXT(txt, 1, :NormalMatch, [ "MultiLine" ])
#--> TRUE

prf()
# Executed in almost 0 second(s) in Ring 1.22

/*-- Test 5: Word boundaries

pr()

txt = "prefix preprocess present"

o = new stzRegex("\bpre\w+")

# Matching words starting with 'pre'

? o.MatchXT(txt, 1, :NormalMatch, [])
#--> TRUE

# Test that fails (no 'pre' words)

txt = "compress express"
? o.MatchXT(txt, 1, :NormalMatch, [])
#--> FALSE

prf()
# Executed in almost 0 second(s) in Ring 1.22

/*-------------------------------------------#
#  Testing Complete stzRegex Implementation  #
#--------------------------------------------#

# Test 1: Basic Pattern Matching with Match

pr()

o1 = new stzRegex("quick.*fox")

# Pattern should match

? o1.Match("The quick brown fox")  # Or MatchString()
#--> TRUE

# Pattern should not match

? o1.Match("slow blue fox")  # false
#--> FALSE

prf()
# Executed in almost 0 second(s) in Ring 1.22

/*-- Test 2: Line Matching

pr()

txt = "First: Line1
Second: Line2
Third: Line3"

o1 = new stzRegex("^Second:.*$")

# Line matching with MatchLinesIn()

? o1.MatchLinesIn(txt)  # Or simly MatchLine(txt)
#--> TRUE

prf()
# Executed in almost 0 second(s) in Ring 1.22

/*-- Test 3: Greedy vs Non-Greedy

pr()

txt = "<div>First</div><div>Second</div>"

o1 = new stzRegex("<div>.*</div>")

# Matching all (greedy) with MatchSegmentsIn()

? o1.MatchSegmentsIn(txt) # matches both divs
#--> TRUE

# Matching first (non-greedy) with MatchFirstSegmentIn()

? o1.MatchFirstSegmentIn(txt) # matches first div
#--> TRUE

prf()
# Executed in almost 0 second(s) in Ring 1.22

/*-- Test 4: Word Boundaries

pr()

o1 = new stzRegex("pre\w+")

# Word boundary matching with MatchWordsIn()

? o1.MatchWordsIn("prefix preprocess present compress")  # matches pre* words
#--> TRUE

# Should fail on compress

? o1.MatchWordsIn("compress")
#--> FALSE

proff()
# Executed in almost 0 second(s) in Ring 1.22

/*-- Test 5: Capture Values of Defined Groups

pr()

txt = "Name: John, Age: 30"

o1 = new stzRegex("Name: (.*), Age: (\d+)")

# First we see if the text matchs the patterns

? o1.Match(txt)
#--> TRUE

# If the pattern includes some defined groups,
# those enclosed between "(" and ")", the we
# can capture them and return them!

? o1.HasGroups()
#--> TRUE

# Captured values

? @@( o1.Capture() )
#--> [ "John", "30" ]

proff()
# Executed in almost 0 second(s) in Ring 1.22

/*-- Test 6: Named Capture Groups

pr()

txt = "Name: John, Age: 30"

o1 = new stzRegex("Name: (?<name>.*), Age: (?<age>\d+)")

# If the pattern includes named groups (between "<" and ">"),
# then we can capture them and return them

? o1.Match(txt)
#--> TRUE

? o1.HasNames() + NL
#--> TRUE

# Capturing names (just names)

? @@( o1.Names() ) + NL
#--> [ "name", "age" ]

# We can see the names and their values when we use
# the eXTended form of Cpature() function

? @@NL( o1.CaptureXT() )
#--> [
#	[ "name", "John" ],
#	[ "age", "30" ]
# ]

proff()
# Executed in almost 0 second(s) in Ring 1.22

/*-- Test 7: Error Handling

pr()

o1 = new stzRegex("(unclosed group")

# Pattern validity

? o1.IsValid()
#--> FALSE

? o1.LastError()
#--> missing closing parenthesis

proff()
# Executed in almost 0 second(s) in Ring 1.22

/*-- Test 8: Qt Options via MatchXT

pr()

o1 = new stzRegex("hello world")

# Case sensitive (should fail)

? o1.MatchXT("HELLO world", 1, :NormalMacth, [])
#--> FALSE

# Case insensitive (should match)

? o1.MatchXT("HELLO world", 1, :NormalMatch, [ "CaseInsensitive" ])
#--> TRUE

proff()
# Executed in almost 0 second(s) in Ring 1.22

/*-------------------------------------------------------#
#  Real-World Regular Expression Examples with Softanza  #
#--------------------------------------------------------#

#-- URL Validation and Parsing

pr()

o1 = new stzRegex("https?://[\w\-.]+(:\d+)?(/[\w\-./?%&=]*)?")
urlText = "Visit https://example.com:8080/path?param=1#section or http://sub.domain.net"

# Basic URL detection

? o1.Match(urlText) + NL
#--> TRUE

# Extract URL components using named groups

o1.SetPattern("(?<protocol>https?)://(?<domain>[\w\-.]+)(?<port>:\d+)?(?<path>/[\w\-./?%&=]*)?")

if o1.Match(urlText) and o1.HasNames()
    ? @@NL(o1.CaptureXT()) + NL
ok
#--> [
#	[ "protocol", "https" ],
#	[ "domain", "example.com" ],
#	[ "port", ":8080" ],
#	[ "path", "/path?param=1" ]
# ]

# Validate specific URL types

o1.SetPattern("^https://.*\.gov$")

# Check a URL of a government site (will match)

? o1.Match("https://whitehouse.gov")
#--> TRUE

# Now we provide a commercial URL (won't match)

? o1.Match("https://example.com")
#--> FALSE

proff()
# Executed in almost 0 second(s) in Ring 1.22

#-- Phone Number Processing

pr()

o1 = new stzRegex("")

cPhoneText = "Call me at +1 (555) 123-4567 or 555.123.8901 or 5551234567"

# Match various phone formats

o1.SetPattern("(\+\d{1,3}[-. ])?\(?\d{3}\)?[-. ]?\d{3}[-. ]?\d{4}")

# Phone number detection

? o1.Match(cPhoneText)
#--> TRUE

# Format phone numbers consistently

o1.SetPattern("(?<country>\+\d{1,3}[-. ])?(?:\(?(?<area>\d{3})\)?[-. ]?)(?<prefix>\d{3})[-. ]?(?<line>\d{4})")

if o1.Match(cPhoneText) and o1.HasGroups()
    ? @@NL( o1.CaptureXT() )
ok
#--> [
#	[ "country", "+1 " ],
#	[ "area", "555" ],
#	[ "prefix", "123" ],
#	[ "line", "4567" ]
# ]

proff()
# Executed in almost 0 second(s) in Ring 1.22

/*--------------------#
#  Log File Analysis  #
#---------------------#

pr()

logText = "
2024-01-12 10:15:30 [ERROR] Failed to connect: timeout
2024-01-12 10:15:35 [INFO] Retry attempt 1
2024-01-12 10:15:40 [ERROR] Connection refused"

o1 = new stzRegex("")

# Match error lines
o1.SetPattern("^.*\[ERROR\].*$")
? o1.MatchLinesIn(logText)
#--> TRUE

# Parse log entries with named groups

o1.SetPattern("(?<date>\d{4}-\d{2}-\d{2})\s+(?<time>\d{2}:\d{2}:\d{2})\s+\[(?<level>\w+)\]\s+(?<message>.+)")

if o1.MatchLinesIn(logText) and o1.HasNames()
    ? @@NL(o1.CaptureXT())
ok
#--> [
#	[ "date", "2024-01-12" ],
#	[ "time", "10:15:30" ],
#	[ "level", "ERROR" ],
#
#	[ "message", "Failed to connect: timeout
# 2024-01-12 10:15:35 [INFO] Retry attempt 1
# 2024-01-12 10:15:40 [ERROR] Connection refused" ]
#
# ]

proff()
# Executed in almost 0 second(s) in Ring 1.22

/*-------------------#
#  Email Processing  #
#--------------------#

pr()

emailText = "Contact us at support@example.com or john.doe+label@sub.domain.co.uk
Invalid emails: missing@domain, @nodomain.com, just.text"

o = new stzRegex("")

# Basic email validation

o.SetPattern("[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}")

? o.Match("support@example.com")
#--> TRUE

? o.Match("invalid@email")
#--> FALSE

# Advanced email parsing

o.SetPattern("(?<user>[a-zA-Z0-9._%+-]+)@(?<domain>[a-zA-Z0-9.-]+\.[a-zA-Z]{2,})")

if o.Match("john.doe+label@sub.domain.co.uk") and o.HasNames()
    ? @@NL(o.CaptureXT())
ok
#--> [
#	[ "user", "john.doe+label" ],
#	[ "domain", "sub.domain.co.uk" ]
# ]

proff()
# Executed in almost 0 second(s) in Ring 1.22

/*----------------#
#  Code Analysis  #
#-----------------#

pr()

codeText = "
function CalculateTotal(price, quantity) {
    // Calculate total with tax
    const tax = 0.2;  // 20% tax rate
    return price * quantity * (1 + tax);
}
"

o1 = new stzRegex("")

# Find function declarations

o1.SetPattern("function\s+(?<name>\w+)\s*\((?<params>[^)]*)\)")

if o1.Match(codeText) and o1.HasNames()
    ? @@NL(o1.CaptureXT()) + NL
ok
#--> [
#	[ "name", "CalculateTotal" ],
#	[ "params", "price, quantity" ]
# ]

# Find comments

o1.SetPattern("//[^\n]*")
? o1.MatchLinesIn(codeText)
#--> TRUE

# Find variable declarations

o1.SetPattern("(?:const|let|var)\s+(?<name>\w+)\s*=\s*(?<value>[^;]+);")

if o1.Match(codeText) and o1.HasNames()
    ? @@NL(o1.CaptureXT())
ok
#--> [
#	[ "name", "tax" ],
#	[ "value", "0.2" ]
# ]

proff()
# Executed in almost 0 second(s) in Ring 1.22

/*-----------------------#
#  Date/Time Processing  #
#------------------------#

pr()

dateText = "Important dates: 2024-01-12, 01/12/2024, Jan 12, 2024"

o1 = new stzRegex("")

# Match various date formats

o1.SetPattern("\d{4}-\d{2}-\d{2}|\d{2}/\d{2}/\d{4}|[A-Z][a-z]{2}\s+\d{1,2},\s+\d{4}")

? o1.Match(dateText)
#--> TRUE

# Parse specific date format

o1.SetPattern("(?<year>\d{4})-(?<month>\d{2})-(?<day>\d{2})")

if o1.Match(dateText) and o1.HasNames()
    ? @@NL( o1.CaptureXT() )
ok
#--> [
#	[ "year", "2024" ],
#	[ "month", "01" ],
#	[ "day", "12" ]
# ]

proff()
# Executed in almost 0 second(s) in Ring 1.22

proff()

/*---------------------#
#  Address Processing  #
#----------------------#

pr()

addressText = "John Doe
123 Main St, Apt 4B
New York, NY 10001
USA"

o1 = new stzRegex("")

# Match ZIP code

o1.SetPattern("\d{5}(-\d{4})?")

? o1.MatchLinesIn(addressText) + NL
#--> TRUE

# Parse address components

o1.SetPattern("(?<street>\d+[^,]+),\s*(?<unit>[^,\n]+)\n(?<city>[^,]+),\s*(?<state>[A-Z]{2})\s*(?<zip>\d{5})")

if o1.Match(addressText) and o1.HasNames()
    ? @@NL(o1.CaptureXT())
ok
#--> [
#	[ "street", "123 Main St" ],
#	[ "unit", "Apt 4B" ],
#	[ "city", "New York" ],
#	[ "state", "NY" ],
#	[ "zip", "10001" ]
# ]

proff()
# Executed in almost 0 second(s) in Ring 1.22

/*-----

pr()

rx = new stzRegex("")
? rx.Match("any text will match")
#--> TRUE

proff()

/*-----

pr()

? pat(:creditCard) + NL
#--> ^\\d{4}[- ]?\\d{4}[- ]?\\d{4}[- ]?\\d{4}$

rx(pat(:cardNumber)) { ? Match("4111-1111-1111-1111") }
#--> TRUE

proff()

/*----------------------#
#  Credit Card Masking  #
#-----------------------#

pr()

cText = "Card numbers: 4111-1111-1111-1111 and 4111111111111111"

o1 = new stzRegex("")

# Validate card format

o1.SetPattern("(?:\d{4}[-\s]?){4}")

? o1.Match(cText)
#--> TRUE

# Mask card number (show only last 4)

o1.SetPattern("(\d{4}[-\s]?){3}(\d{4})")

if o1.Match(cText) and o1.HasGroups()
    captured = o1.Capture()
    ? captured[len(captured)]
ok
#--> 1111

proff()
# Executed in almost 0 second(s) in Ring 1.22s

/*------------------------#
#  MATCHING HTML CONTENT  #
#-------------------------#

pr()

# Simple HTML content with multiple lines

htmlText = '
<html>
    <head>
        <title>Hello World</title>
    </head>
    <body>
        <h1>Welcome</h1>
        <p>First paragraph</p>
        <p>Second paragraph</p>
    </body>
</html>
'

# Match all paragraph lines

o1 = new stzRegex("<p>.*</p>")

# Testing MatchLinesIn() to find all paragraph lines

? o1.MatchLinesIn(htmlText)
#--> TRUE


//? o1.Capture()
#--> ERROR: No capture groups found in pattern. Use groups like (xyz) to capture values.
#NOTE: To protect your code use if HasGroups()

# Match just the first h1 line

o2 = new stzRegex("<h1>.*</h1>")
? o2.MatchLine(htmlText)
#--> TRUE

# Match title line with content capture

o3 = new stzRegex("<title>(.*)</title>")
? o3.MatchLine(htmlText)
#--> TRUE

# Captured title content

if o3.HasGroups()
    ? @@( o3.Capture() )
ok
#--> [ "Hello World" ]

proff()
# Executed in almost 0 second(s) in Ring 1.22

/*-----------------------#
#  Unicode Text Support  #
#------------------------#

pr()

txt = "مرحبا بكم في عالم البرمجة"

o1 = new stzRegex("مرحبا")

? o1.Match(txt)
#--> TRUE

# Test with word boundary

o2 = new stzRegex("عالم")
? o2.Match(txt)
#--> TRUE

# Test capturing

o3 = new stzRegex("(عالم) (البرمجة)")
if o3.Match(txt) and o3.HasGroups()
    ? @@( o3.Capture() )
ok
#-o-> [ "عالم", "البرمجة" ]

proff()
# Executed in almost 0 second(s) in Ring 1.22

