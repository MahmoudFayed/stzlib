load "../max/stzmax.ring"



/*----------------- ERROR

if _("ring").IsA(:String).Which(:IsLowercase).Containing(TheLetter("g")).Having('FirstChar() = "r"')._

	? "Got it!"
else
	? "Sorry. May be next time..."
ok

/*----------------- ok

# All these return TRUE:

? _(1234).IsA(:Number).Which(:IsEven)._
? _("ring").IsA(:String).Which(:IsLowercase)._
? _([]).IsA(:List).Which(:IsEmpty)._
#TODO: an example for objects

/*----------------- ok

# All these are FALSE:

? _(1234).IsA(:String).Which(:IsEven)._
? _("ring").IsA(:Number).Which(:IsUppercase)._
? _("ring").IsA(:String).Which(:IsUppercase)._
#TODO: an example for objects

/*----------------- ERROR

# All these return TRUE:

? _("Ring").IsA(:String).Where('NumberOfChars() = 4')._
? _("Ring").IsA(:String).Having('FirstChar() = "R"')._
? _("Ring").IsA(:String).That('Contains("in")')._
? _("Ring").IsA(:String).Containing('in')._

/*----------------- ok
*/
# This returns FALSE:
/*
? _(1854).IsA(:String).Containing('in')._

/*----------------- ok

# All these return TRUE

? _("ring").IsA(:String)._
? _("f").IsA(:Letter)._

/*------------------- ok!

? _([]).IsA(:List)._	#--> TRUE
? _(12).IsA(:Number)._	#--> TRUE

? _("g").IsA(:Letter)._	#--> TRUE
? _([ :name = "mio", :age = 12 ]).IsA(:HashList)._	#--> TRUE
? _([ "Tunis", "Cairo", "Prag" ]).IsA(:ListOfStrings)._	#--> TRUE

o1 = new person { name = "ali" }
? _(:o1).IsAn(:Object)._ #--> ERRO: should return TRUE

class Person
	name

/*-----------------

# These return TRUE

? _("ring").IsA(:String).Which(:IsLowercase).Containing(TheLetter("g"))._
? _("ring").IsA(:String).Which(:IsLowercase).Containing(TheLetter("g")).Having('FirstChar() = "r"')._

/*----------------- ok

? _(8)._ 	# Returns 8
? _("ring")._ 	# Returns "ring"

/*----------------- ok

# All these return TRUE

? _(8).Is('DoubleOf(4)')._
? _("ring").Is('Lowercase()')._
? _("ring").Is(:Lowercase)._

/*----------------- ERRO

# These return TRUE
*/
? _("ring").Is('Lowercase()').Containing("in")._
? _("ring").Is('Lowercase()').Having('NumberOfchars() = 4')._

/*----------------- ERROR

? _("ring").Containing("in")._

/*----------------- ok

? _("ring").Is(:Lowercase).Is(:Even)._ #--> FALSE

/*-----------------

# All these return TRUE

? _(8).IsA(:Number).Which('IsDoubleOf(4)')._
? _(8).IsA(:Number).Which('IsEven()')._
? _(8).IsA(:Number).Which('IsEven')._


/*----------------- ERROR

# All these return TRUE

? _(9).IsNot('DoubleOf(4)')._
? _(9).IsA(:Number).Which('IsNotEven')._
? _(9).IsNotA(:Number).Which('IsEven')._

/*----------------- ERROR

? _("ring").IsNotA(:String)._	#--> FALSE
? _("ring").IsNotA(:String).Which('Contains("x")')._	#--> TRUE
? _("ring").IsNotA(:String).Which('Contains("i")')._	#--> FALSE

/*----------------- ERROR

# All these return TRUE

# Well, nothing prevents you from saying
? _("ring").Containing("i")._
# But, it's linguistically more elegant to say:
? _("ring").Contains("i")._
# or
? _("ring").IsContaining("i")._

/*----------------- ERROR


# All these are semantically equivalent and return TRUE

? _("ring").ContainingNo("x")._
? _("ring").IsContainingNo("x")._

? _("ring").ContainsNo("x")._	
? _("ring").DoesNotContain("x")._

/*-----------------

# All these return TRUE

? _("ring").ContainsNo("x").ContainsNo("y")._
? _("ring").ContainsNo("x").Nor("y")._
? _("ring").ContainsNeighther("x").Nor("y")._

/*-----------------

? _([]).IsNotA(:String)._	#--> FALSE
? _([]).IsNot(:AString)._	#--> FALSE

/*-----------------

? _([]).IsNor(:String).Nor(:Number).Nor(:Object)._

/*-----------------
*/


#? _("ring").ContainsNoOneOfThese([ "x", "y", "z" ])._
#? _("ring").ContainsEachOfThese([ "r", "i", "n", "g" ])._

#? ("This text").IsNeighther(:Arabic).Nor(:Cyrillic)
/*-----------------

_("G").IsThe(:Lowercase).Of("g")._

? _("G").IsAString().Which(:IsLetter)._

/*-----------------

? _("Ring").IsAString()//.Containing(TheLetter("G")).In('Lowercase()')
//? _("Ring").IsAString().Containing("in").Whaterver('StringCase()').ItHas()

/*-----------------
*/

//IsFunctionCall()
//ExtractFunctionParams()
	
	

