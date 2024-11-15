load "../max/stzmax.ring"

/*=====

pron()

o1 = new stzListOfNumbers([ 2.07, 0.39, 0.12])

? o1.PerfGain100() 	# 100 ~> In percentage
#--> [ 81.16, 69.23 ])

? o1.SpeedUpX()		# X ~> In factor
#--> [ 5.31, 3.25 ]

proff()
#--> Executed in 0.02 second(s).

/*-----

pron()

o1 = new stzPairOfNumbers([ 2.07, 0.39 ])

? o1.PerfGain100() 	# 100 ~> In percentage
#--> 81.16

? o1.SpeedUpX()		# X ~> In factor
#--> 5.31

proff()
#--> Executed in 0.02 second(s).

/*=====

pron()

# Multiple calculation

? Divide([ 12, 2, 3 ])
#--> 2

? Substruct([ 10, 2, 3 ])
#--> 5

? Multiply([ 10, 2, 3 ])
#--> 60

? Sum([ 10, 2, 4 ]) + NL
#--> 16

#-- Cumulated

? DivideXT([ 12, 2, 3 ]) # Or DivideAndCumulate
#--> [ 12, 6, 2 ]

? SubstructXT([ 10, 2, 3 ])
#--> [ 10, 8, 5 ]

? MultiplyXT([ 10, 2, 3 ])
#--> [ 10, 20, 60 ]

? SumXT([ 10, 2, 4 ])
#--> [ 10, 12, 16 ]

proff()
# Executed in 0.01 second(s)

/*=====

pron()

o1 = new stzListOfNumbers([
	370, 4120.34, 493.12, 45, 370, 12.1, 7
])

decimals(3)

? o1.Justified()
#-->
# 	  370.000
#	 4120.340
#	  493.120
#	   45.000
#	  370.000
#	   12.100
#	    7.000

? o1.JustifiedUsing("0") # Or JustifiedXT()
#-->
#	0370.000
#	4120.340
#	0493.120
#	0045.000
#	0370.000
#	0012.100
#	0007.000

proff()
# Executed in 0.03 second(s)

/*=====

pron()

? Min([ 2, 4 ])
#--> 2

? Max([ 2, 4 ])
#--> 4

proff()
# Executed in 0.02 second(s)

/*=====

pron()

? @@( Association([ [ 1, 2, 3 ] , [ 1, 3, 8 ] ]) )
#--> [ [ 1, 1 ], [ 2, 3 ], [ 3, 8 ] ]

proff()
# Executed in 0.02 second(s)

/*====

pron()

o1 = new stzListOfNumbers([ 2, 7, 3, 10, 5, 4, 9, 1, 6, 8 ])

? o1.NSmallestNumbers(3) # Or Bottom3()
#--> [ 1, 2, 3 ]

? @@( o1.Bottom3Z() ) + NL # Or Bottom3AndTheirPositions()

# [ [ 1, 1 ], [ 2, 3 ], [ 3, 8 ] ]

? o1.NLargestNumbers(3)
#--> [ 8, 9, 10 ]

? @@( o1.Top3Z() )
# [ [ 8, 4 ], [ 9, 7 ], [ 10, 10 ] ]

proff()
# Executed in 0.04 second(s)

/*=====

pron()

? NZeros(5)
#--> [ 0, 0, 0, 0, 0 ]

proff()
# Executed in 0.01 second(s)

/*=====

pron()

o1 = new stzNumber("1234567.1234567")

? o1.Integers()
#--> [ 1, 2, 3, 4, 5, 6, 7 ]

? o1.IntergersQR(:stzListOfNumbers).Sum() + NL # Misspelled, but works!
#--> 28

? o1.Decimals()
#--> [ 1, 2, 3, 4, 5, 6, 7 ]

? o1.DecimalsQR(:stzListOfNumbers).Sum()
#--> 28

proff()
# Executed in 0.05 second(s) in Ring 1.20
# Executed in 0.11 second(s) in ring 1.18

/*--------------

pron()

? QQ(1:3).StzType()
#--> StzListOfNumbers

proff()

/*================= #todo write a #narration

pron()

? Q([ 1, 2, 3, 4, 5]) - [1, 3 , 5]
#--> [ 1, 2, 3, 4, 5 ]
# Because [1, 3, 5 ] is not an item in the list [ 1, 2, 3, 4, 5 ]

? Q([ 1, 2, 3, [1, 3 , 5], 4, 5]) - [1, 3 , 5]
#--> [ 1, 2, 3, 4, 5 ]
# Now [ 1, 3, 5 ] is removed because it is an item from the list

# If you want to remove 1, 3, and 5 in the same statement, you use These():

? Q([ 1, 2, 3, 4, 5]) - These([1, 3 , 5])
#--> [ 2, 4 ]

# If you want to get a stzList object as an output add Q() to the second member:

//? ( Q([ 1, 2, 3, 4, 5]) - TheseQ([1, 3 , 5]) ).Content()
#  \____________________ _______________________/
#                       V
#               A stzList object

#--> [ 2, 4 ]


proff()
# Executed in 0.01 second(s) in Ring 1.21s

/*----------------

pron()

? Q([1, "*", 2, "*", 3 ]) - "*"
#--> [ 1, 2, 3 ]

? ( Q([1,"*",  2, "*", 3 ]) - Q("*") ).Content()
# \_______________ _____________/
#                 V
#          A stzList object

#--> [ 1, 2, 3 ]

proff()
# Executed in 0.02 second(s)

/*----------------

pron()

? Q([1, 2, 3 ]) + 4
#--> [ 1, 2, 3, 4 ]

? ( Q([1, 2, 3 ]) + Q(4) ).Content()
# \___________ __________/
#             V
#         A StzList object

# [ 1, 2, 3, 4 ]

proff()
# Executed in 0.02 second(s)

/*----------------
 
pron()

? @@( Q([1, 2, 3 ]) * 4 )
#--> [ 1, 2, 3, 1, 2, 3, 1, 2, 3, 1, 2, 3 ]

? ( Q([1, 2, 3 ]) * Q(4) ).Content()
# \___________ __________/
#             V
#       A stzList object

#--> 

proff()
# Executed in 0.02 second(s)

/*----------------

pron()

? @@( Q(["A", "B" ]) * 3 )
#--> [ [ "A", "B" ], [ "A", "B" ], [ "A", "B" ] ]

? @@( ( Q(["A", "B" ]) * Q(3) ).Content() )
#     \____________ __________/
#                  V
#           A stzList object

#--> [ [ "A", "B" ], [ "A", "B" ], [ "A", "B" ] ]

proff()
# Executed in 0.02 second(s)

/*----------------

pron()

o1 = new stzList(["one", "two", "three", "four", "five", "six" ])

? @@( o1.SplittedToPartsOfNItems(3) ) + NL
#--> [ [ "one", "two", "three" ], [ "four", "five", "six" ] ]

? @@( o1.SplittedToNParts(3) )
#--> [ [ "one", "two" ], [ "three", "four" ], [ "five", "six" ] ]

proff()
# Executed in 0.03 second(s) in Ring 1.21

/*----------------

pron()

? @@( Q(["one", "two", "three", "four", "five", "six" ]) / 3 ) + NL
#--> [ [ "one", "two" ], [ "three", "four" ], [ "five", "six" ] ]

? @@( ( Q(["one", "two", "three", "four", "five", "six" ]) / Q(3) ).Content() )
#     \______________________________ ____________________________/
#                                    V
#                           a stzList object

#--> [ [ "one", "two" ], [ "three", "four" ], [ "five", "six" ] ]

proff()
# Executed in 0.03 second(s) in Ring 1.21

/*----------------

pron()

? @@( Q([4, 44, 444 ]) / 3 )
#--> [ [ 4 ], [ 44 ], [ 444 ] ]

? @@( ( Q([4, 44, 444 ]) / Q(3) ).Content() )
#      \____________ ___________/
#                   V
#           a stzList object

#--> [ [ 4 ], [ 44 ], [ 444 ] ]

proff()
# Executed in 0.03 second(s) in Ring 1.21

/*----------------

pron()

o1 = new stzList([ "A", "B" ])

? @@( o1.SplittedToNParts(2) )
#--> [ [ "A" ], [ "B" ] ]

? @@( o1.SplittedToNParts(1) )
#--> [ [ "A", "B" ] ]

? @@( o1.SplittedToNParts(0) )
#--> [ ]

proff()
# Executed in 0.03 second(s) in Ring 1.21
# Executed in 0.06 second(s) in Ring 1.18

/*----------------

pron()

? Q(["A", 1, "B", 2, "C", 3 ]) / 3
#--> [ [ "A", 1 ], [ "B", 2 ], [ "C", 3 ] ]

? Q(["A", 1, "B", 2, "C", 3 ]) / Q(3)
#--> A stzList object containg [ [ "A", 1 ], [ "B", 2 ], [ "C", 3 ] ]

# To check it add ( ... ).Content() around it:

? ( Q(["A", 1, "B", 2, "C", 3 ]) / Q(3) ).Content()
# [ [ "A", 1 ], [ "B", 2 ], [ "C", 3 ] ]

proff()
# Executed in 0.05 second(s)

/*===============

pron()

? Q([1, 2, "*", 3 ]) + "*"
#--> [ 1, 2, 3 ]

? Q([1, 2, "*", 3 ]) + Q("*")
#--> A stzList object containg [ 1, 2, 3 ]

proff()
# Executed in 0.03 second(s)

/*================

pron()

? Q("Ringggg") - "ggg"
#--> Ring

? (Q("Ringggg") - Q("ggg")).Content()
#--> A StzString object containg "Ring"

proff()

/*---------------

pron()

? Q("Rin") + "g"
#--> Ring

? Q("Rin") + Q("g")
#--> A StzString object containg "Ring"

proff()

/*---------------

pron()

o1 = new stzListOfNumbers(1:5)
? o1.NumbersGreaterThan(3)
#--> [4, 5]

? o1.NumbersLessThan(3)
#--> [1, 2]

? o1.NumbersOtherThan(3)
#--> [1, 2, 4, 5]

proff()
# Executed in 0.04 second(s)

/*---------------

pron()

? 3RandomNumbersIn(1:10)
#--> [10, 9, 10]

proff()

/*---------------

pron()

? NRandomNumbersIn(3, 1:10)
#--> [10, 10, 10]

proff()

/*---------------

pron()

? QQ(1:10).NRandomNumbers(3)
#--> [9, 10, 10]
#--> [10, 10, 10]
#--> [10, 9, 9]

proff()
# Executed in 0.04 second(s)

/*---------------

pron()

? QQ(1:100_000).NRandomNumbers(3)
#--> [100_000, 100_000, 100_000]
#--> [100_000, 99_999, 100_000]
#--> [99_999, 99_999, 99_999]

proff()
# Executed in 0.62 second(s)

/*---------------

pron()

? QQ(1:7).AnyNumberBeforePosition(5)
#--> 3
#--> 2
#--> 3
#--> 2
#--> 1


proff()
# Executed in 0.03 second(s)

/*---------------
*/
pron()

? QQ([ 12, 4, 35, 102, 22, 98, 5 ]).AnyNumberBefore(22)
#--> 102
#--> 4
#--> 4
#--> 12
#--> 192


proff()
# Executed in 0.01 second(s)

/*---------------

pron()

? QQ(1:7).AnyNumberAfterPosition(5)
#--> 7
#--> 5
#--> 5
#--> 4
#--> 4


proff()
# Executed in 0.01 second(s)

/*---------------

pron()

? QQ([ 12, 4, 35, 102, 22, 98, 5 ]).AnyNumberBefore(22)
#--> 102
#--> 4
#--> 4
#--> 12
#--> 192


proff()
# Executed in 0.03 second(s)
/*---------------

pron()

? QQ(1:7).AnyNumberBeforeOrAfter(3)

proff()

/*---------------

pron()

o1 = new stzListOfNumbers(1: 10)
? o1.ANumberOtherThan(5)

proff()

/*===============

pron()

o1 = new stzListOfNumbers([ 2, 7, 18, 18, 10, 25, 4 ])

? @@( o1.Neighbors(10) )
#--> [ 7, 18 ]

? @@( o1.Neighbors(25) )
#--> [18, NULL ]

? @@( o1.Neighbors(2) )
#--> [ NULL, 4 ]

? @@( o1.Neighbors(88) )
#--> [ 25, NULL ]

? @@( o1.FarthestNighbors(10) ) # Misspelled form of FarthestNeighbors()
				# You can use the short form FNeighbors()
#--> [ 2, 25 ]

proff()
# Executed in 0.15 second(s)

/*-------------

pron()

o1 = new stzListOfNumbers([ 2, 7, 18, 18, 10, 12, 25, 4 ])

? o1.Nearest(88)
#--> 25

? o1.Nearst(17) #NOTE this is a misspelled form of Nearest()
#--> 18

? o1.NearestTo(10)
#--> 12

? o1.Nearest( :To = 12 )
#--> 10

? o1.Nearest(2)
#--> 4

? o1.Nearest(1)
#--> 2

proff()
# Executed in 0.18 second(s)

/*-------------

pron()

o1 = new stzListOfNumbers([ 4, 8, 10, 16, 18 ])

? o1.Farthest(88)
#--> 4

? o1.Farthest(17) 
#--> 4

? o1.FarthestTo(10)
#--> 18

? o1.Farthest( :To = 12 )
#--> 4

? o1.Farthest(2)
#--> 18

? o1.Farthest(1)
#--> 18

proff()
# Executed in 0.13 second(s)

/*-----------------

pron()

o1 = new stzListOfNumbers([ 1, 4, 6, 11, 18 ])

? @@( o1.NeighborsOf(5) )
#--> [ NULL, NULL ]

? @@( o1.Neighbors(11) )
#--> [ 6, 18 ]

? @@( o1.Neighbors(1) )
#--> [ NULL, 4 ]

? @@( o1.Neighbors(22) )
#--> [ 18, NULL ]

proff()
# Executed in 0.10 second(s)

/*-----------------

pron()

o1 = new stzListOfNumbers([ 1, 4, 6, 11, 18 ])

? @@( o1.FarthestNeighborsOf(5) ) # or FNeighborsOf(5)
#--> [ NULL, NULL ]

? @@( o1.FNeighbors(11) )
#--> [ 1, 18 ]

? @@( o1.FNeighbors(1) )
#--> [ NULL, 18 ]

? @@( o1.FNeighbors(18) )
#--> [ 1, NULL ]

proff()
# Executed in 0.10 second(s)

/*-------------

pron()

o1 = new stzListOfNumbers([ 2, 4, 7, 10, 12, 15, 18, 25 ])

? o1.FarthestToXT(12, :Coming = :BeforeIt)
#--> 2

? @@( o1.FarthestToXT(12, :Coming = :AfterIt) )
#--> 25

? @@( o1.FarthestXT( :To = 2, :Before) )
#--> NULL

? @@( o1.FarthestToXT(17, :ComingAfterIt) )
#--> NULL

? @@( o1.FarthestToXT(25, :ComingAfterIt) )
#--> NULL

proff()
# Executed in 0.30 second(s)

/*-------------

pron()

o1 = new stzListOfNumbers([ 2, 4, 7, 10, 12, 15, 18, 25 ])

? o1.NearestToXT(12, :Coming = :BeforeIt)
#--> 2

? @@( o1.NearestToXT(12, :Coming = :AfterIt) )
#--> 25

? @@( o1.NearestXT( :To = 2, :Before) )
#--> NULL

? @@( o1.NearestToXT(17, :ComingAfterIt) )
#--> NULL

? @@( o1.NearestToXT(25, :ComingAfterIt) )
#--> NULL

proff()
# Executed in 0.30 second(s)

/*===========

pron()

? Min([1, 10])
#--> 1

? Max([1, 10])
#--> 10

proff()
# Executed in 0.04 second(s)

/*===============

? Sum([ 2, 3, 2 ])
#--> 7

? Product([2, 3, 2])
#--> 12

/*============

StartProfiler()

o1 = new stzListOfNumbers([ 1, 2, 999, 4, 5, 999, 7, 8, 999 ])

? @@( o1.FindAll(999) )
#--> [3, 6, 9]

#NOTE: the following functions work the same for stzString, 
# stzList, and stzListOfStrings, because they are abstracted in stzObject

? @@( o1.NFirstOccurrences(2, :Of = 999) )
#--> [3, 6]

? @@( o1.NFirstOccurrencesXT(2, :Of = 999, :StartingAt = 1) )
#--> [3, 6]

? @@( o1.NLastOccurrences(2, :Of = 999) )
#--> [6, 9]

? @@( o1.NLastOccurrencesXT(2, 999, :StartingAt = 1) )
#--> [6, 9]

? @@( o1.NFirstOccurrencesXT(2, :Of = 999, :StartingAt = 6) )
#--> [6, 9]

? @@( o1.LastNOccurrencesXT(1, :Of = 999, :StartingAt = 9) )
#ERROR : Array Access (Index out of range) ! In method section() in tzList.ring
#--> [ 9 ]

StopProfiler()
# Executed in 0.44 second(s)

/*===============

pron()

? StzListOfNumbersQ( 12:22 ).SortingOrder()
#--> :Ascending

? StzListOfNumbersQ( 17:8 ).SortingOrder()
#--> :Descending

proff()
# Executed in 0.15 second(s)

/*==============

pron()

? StzListOfNumbersQ( 12:22 ).IsContiguous()
#--> TRUE

? StzListOfNumbersQ( 17:8 ).IsContiguous()
#--> TRUE

? StzListOfNumbersQ([10, 12, 18]).IsContiguous()
#--> FALSE

? StzListOfNumbersQ([10, 11, 10]).IsContiguous()
#--> FALSE

proff()
# Executed in 0.03 second(s)

/*========

pron()

o1 = new stzListOfNumbers([ 1, 2, 3, 4, 5, 6, 7, 8, 9 ])

o1.Cumulate()

? @@( o1.Content() )
#--> [ 1, 2, 5, 9, 14, 20, 27, 35, 44 ]

proff()
# Executed in 0.03 second(s)

/*========

pron()

? StzListOfNumbersQ( 1:5 ).Reversed()
#--> 5:1

proff()
# Executed in 0.03 second(s)

/*========

pron()

StzListOfNumbersQ([ 2, 10, 7, 4, 19, 7, 19 ]) {

	# Let's play with max numbers in the list

	? Max() + NL 	#--> 19
	? FindMax() 	#--> [ 5, 7 ]

	? MaxNumbers(3) #--> [ 19, 10, 7 ]
	# You can alos say: ? Top(3)


	? FindMaxNumbers(3) #--> [ 2, 3, 5, 6, 7 ]
	# You can also say: ? FindTop(3)

	? @@( MaxNumbersZ(3) )
	#--> [ "19" = [ 5, 7 ], "10" = [ 2 ], "7" = [ 3, 6 ] ]
	# You can also say: ? TopZ(3)

	# Let's do the same with the min numbers

	? Min() + NL	#--> 2
	? FindMin()	#--> [ 1 ]

	? MinNumbers(3)     #--> [ 2, 4, 7 ]
	? FindMinNumbers(3) #--> [ 1, 3, 4, 6 ]

}

proff()
# Executed in 0.55 second(s)

/*==================

pron()

? StzListOfNumbersQ([ 1, 2, 3 ]).AddedToEach(5)
#--> [6, 7, 8]

proff()
# Executed in 0.03 second(s)

/*-----------------
pron()

StzListOfNumbersQ([ 1, 2, 3 ]) {

	? @@( Content() )
	#--> [ 1, 2, 3 ]
 
	AddToEach(3)
	? @@( Content() )
	#--> [ 4, 5, 6 ]

	MultiplyEachBy(3)
	? @@( Content() )
	#--> [ 12, 15, 18 ]

	DivideEachBy(3)
	? @@( Content() )
	#--> [ 4, 5, 6 ]
}

proff()
# Executed in 0.04 second(s)

/*-------------------

pron()

o1 = new stzListOfNumbers([ 8, 10, 14 ])

o1.SubStructManyOneByOne([ 6, 7, 7 ])

? @@( o1.Content() )
#--> [ 2, 3, 7 ]

proff()
# Executed in 0.03 second(s)

/*-------------------

pron()

StzListOfNumbersQ([ 2, 4, 8 , 10 , 12 ]) {

	AddManyOneByOne([ 8, 6, 2, 0, -2 ])
	? @@( Content() )
	#--> [ 10, 10, 10 , 10 , 10 ]

	SubStructManyOneByOne([ 5, 5, 5, 5, 5 ])
	? @@( Content() )
	#--> [ 5, 5, 5, 5, 5 ]

	MultiplyByManyOneByOne([ 1, 2, 3, 4, 5 ])
	? @@( Content() )
	#--> [ 5, 10, 15, 20, 25 ]

	DivideByManyOneByOne([ 5, 5, 5, 5, 5 ])
	? @@( Content() )
	#--> [ 1, 2, 3, 4, 5 ])

}

proff()
# Executed in 0.05 second(s)

/*-------------------

pron()

o1 = new stzString("helloringprogrammer!")
o1.SpacifySubStringUsing("ring", "_")
? o1.Content()
#--> hello_ring_programmer!

proff()
# Executed in 0.04 second(s)

/*-------------------

pron()

o1 = new stzString("whatisyournameplease?")
o1.SpacifySubStringsUsing(["is", "your", "name"], "_")
#--> what_is_your_name_please?

? o1.Content()

proff()
# Executed in 0.09 second(s)

/*-------------------

pron()

o1 = new stzString("whatisyournameplease?")

o1.SpacifySubStringsUsing(["is", "your", "name"], " ")
? o1.Content()
#--> what is your name please?

proff()
# Executed in 0.10 second(s)

/*=================

pron()

o1 = new stzCCode('{ Q(This[@i]).IsDividableBy(4) and This[@i] <= 20 }')
? o1.ExecutableSection()
#--> [1, :Last]

proff()
# Executed in 0.12 second(s)

/*-------------------

pron()

o1 = new stzListOfNumbers([ 4, 7, 36, 9, 20 ])

? o1.FindW('{ Q(This[@i]).IsDividableBy(4) and This[@i] <= 20 }')
#--> [1, 5]

proff()
# Executed in 0.15 second(s)

/*-------------------

pron()

o1 = new stzList("A":"E")
o1.Update([])

? @@( o1.Content() )
#--> [ ]

proff()
# Executed in 0.03 second(s)

/*======================

pron()

o1 = new stzString("---ring---ring--ring--")
? @@( o1.FindInSections("ring", [ [3, 8], [10, 15], [16, 21] ]) )
#--> [4, 11, 17 ]

? @@( o1.FindInSectionsAsSections("ring", [ [3, 8], [10, 15], [16, 21] ]) )
#--> [ [ 4, 7 ], [ 11, 14 ], [ 17, 20 ] ]

proff()
# Executed in 0.10 second(s)

/*--------------------

pron()

o1 = new stzString("---ring---ruby--python--python--")
? @@( o1.FindInSection("ring", 4, 7) )
#--> [ 4 ]

? @@( o1.FindInSection("ruby", 9, 16) )
#--> [ 11 ]

? @@( o1.FindInSectionAsSections("python", 15, :Last) )
#--> [ [ 17, 22 ], [ 25, 30 ] ]

proff()
# Executed in 0.07 second(s)

/*--------------------

pron()

o1 = new stzString("iloveringprogramminglanguage!!")

? @@( o1.FindInSection("ring", 18, 22) )
#--> []

? @@( o1.FindInSection("ring", 3, 12) )
#--> [ 6 ]

? @@( o1.FindXT("ring", :InSection = [ 3, 12] ) )
#--> [ 6 ]

proff()

/*--------------------

pron()

o1 = new stzString("iloveringprogramminglanguage!!")

? @@( o1.FindXT("ring", :InSections = [ [3, 12] ] ) )
#--> [ 6 ]

? @@( o1.FindInSections("ring", [ [3, 12], [18, 20] ] ) )
#--> [ 6 ]

proff()


/*--------------------

pron()

o1 = new stzListOfStrings([ "i", "ring", "language" ])
o1.SortByInDescending('Q(@string).NumberOfChars()')

? @@( o1.Content() )
#--> [ "language", "ring", "i" ]

proff()
# Executed in 0.06 second(s)

/*--------------------

pron()

o1 = new stzString("iloveringprogramminglanguage!!")
? @@( o1.FindManyZZ([ "i", "love", "ring", "programming" ]) )

#--> [ [ 1, 1 ], [ 2, 5 ], [ 6, 9 ], [ 7, 7 ], [ 10, 20 ], [ 18, 18 ] ]

proff()
# Executed in 0.07 second(s)

/*--------------------

pron()

o1 = new stzString("weloveringlanguage!")
o1.AddXT(" ", :AfterThese = Q([ "we", "love", "ring", "language" ]).Reversed())
#--> we love ring language !

proff()
# Executed in 0.03 second(s)

/*------------------

pron()

o1 = new stzString("we loveringlanguage!")
o1.AddXT([ " ", " " ], :Around = "ring")

? o1.Content()
# Executed in 0.04 second(s)

proff()

/*------------------

pron()

o1 = new stzString("weloveringlanguage!")

o1.SpacifySubStrings([ "love", "ring", "language" ])

? o1.Content()
# we love ring language !

proff()
# Executed in 0.06 second(s)

/*--------------------

pron()

o1 = new stzString("iloveringprogramminglanguage")
? o1.TheseSubStringsSpacified([ "php", "ruby" ]) # Nothing happens because these substrings
						 # do not exist in the main string
#--> iloveringprogramminglanguage

proff()
# Executed in 0.02 second(s)

/*--------------------

pron()

o1 = new stzString("iloveringprogramminglanguage")
? o1.TheseSubStringsSpacified([ "php", "ruby", "programming" ]) # Only "programming" is spacified
						 		# because "php" and "ruby" do no
								# exist in the main string
#--> ilovering programming language

proff()
# Executed in 0.05 second(s)

/*-------------------

pron()

o1 = new stzListOfNumbers([ 4, 7, 36, 9, 20 ])
o1.AddToEachW( 1, :Where = '{ Q(This[@i]).IsDividableBy(4) and This[@i] <= 20 }' )

? @@(o1.Content())
#--> [ 5, 21 ]

proff()
# Executed in 0.17 second(s)

/*-------------------

pron()

o1 = new stzListOfNumbers([ 4, 14, 24, 34 ])
o1.SubStructFromEachW( 10, :Where = '{ @number > 20 }' )
? @@(o1.Content())
#--> [ 14, 24 ]

proff()
# Executed in 0.11 second(s)

/*-------------------

pron()

o1 = new stzListOfNumbers([ 5, 15, 25, 35 ])
o1.DivideEachByW( 5, :Where = '{ @number > 20 }' )
? @@(o1.Content())
#--> [ 5, 7 ]

proff()
# Executed in 0.11 second(s)

/*======

pron()

?  MultiplicationsYieldingN(9)
#--> [ [ 1, 9 ], [ 3, 3 ], [ 9, 1 ] ]

?  MultiplicationsYieldingN_WithoutCommutation(9)
#--> [ [ 1, 9 ], [ 3, 3 ] ]

proff()
# Executed in 0.02 second(s)

/*--------------

pron()

o1 = new stzListOfNumbers([ 12, 10, 98, 3, 23, 98, 7 ])

? o1.Min()
#--> 3

? o1.FindMin() + NL
#--> 4

? o1.Max()
#--> 98

? o1.FindMax()
#--> 3

proff()
# Executed in 0.03 second(s)

/*--------------

Pron()

o1 = new stzListOfNumbers(1:8)
o1.AddToEveryNumber(2)
? ListToCode( o1.Content() )
#--> [ 3, 4, 5, 6, 7, 8, 9, 10 ]

proff()
# Executed in 0.03 second(s)

/*--------------

pron()

o1 = new stzListOfNumbers(1:8)
o1.SubStructFromEach(2)
? ListToCode( o1.Content() )
#--> [ -1, 0, 1, 2, 3, 4, 5, 6 ]

proff()
# Executed in 0.03 second(s)

/*---------------

pron()

o1 = new stzListOfNumbers(1:8)

? o1.sum()
#--> 36

? o1.Product()
#--> 40320

? o1.Max()
#--> 8

? o1.Mean()
#--> 4.50

proff()
# Executed in 0.03 second(s)

/*---------------

pron()

o1 = new stzListOfNumbers(1:8)

? o1.ContainsADividableNumberBy(2) + NL
#--> TRUE

? @@( o1.DividableNumbersBy(2) )
#--> [ 2, 4, 6, 8 ]

proff()
# Executed in 0.04 second(s)

/*---------------

pron()

# CLIPPING THE NUMBERS IN THE LIST
# Limits the values of the list by adjusting the numbers outside
# the provided range (nMin, nMax). Each number lesser then nMin
# becomes equal to nMin. And each number greater then nMax becomes
# equal to nMax.

o1 = new stzListOfNumbers(1:8)

o1.Clip(3, 5)
? @@( o1.Content() )
#--> [ 3, 3, 3, 4, 5, 5, 5, 5 ]

proff()
# Executed in 0.03 second(s)

/*--------------

pron()

o1 = new stzListOfNumbers(1:8)
o1.ReplaceSectionWith(3, 5, 2)
#--> [ 1, 2, 2, 2, 2, 6, 7, 8 ]
? @@( o1.Content() )

proff()
# Executed in 0.03 second(s)
