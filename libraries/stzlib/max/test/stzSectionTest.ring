load "../stzmax.ring"

#TODO // check errors!

/*----

pr()

? IsSection(:From = :Start, :To = :End, 10)
#--> TRUE

? Section(:From = :Start, :To = :End, 10)
#--> [ 1, 5 ]

o1 = new stzSection(:From = :Start, :To = :End, 10)
? o1.Content()
#--> [ 1, 5 ]

pf()

/*----

o1 = new stzSection(1, 5, 10) # Or stzSection(:From=1, :To=5, :InAListOfSize = 10)
? o1.Content()
#--> [ 1, 5 ]

pf()

/*---

o1 = new stzSection(:From = :EndOfList, :To = :StartOfList, :InAListOfSize = 10)
? o1.Content()
#--> [ 1, 5 ]

pf()
# Executed in 0.06 second(s)
