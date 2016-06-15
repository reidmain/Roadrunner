/*
Code generated while going through the 'Functions' chapter of Apple's Swift book.
*/

let names = [ "Chris", "Alex", "Ewa", "Barry", "Daniella" ]

func backwards(s1: String, s2: String) -> Bool
{
	return s1 > s2
}

var reversed = names.sort(backwards)

reversed = names.sort({ (s1: String, s2: String) -> Bool in
	return s1 > s2
})

reversed = names.sort( { (s1: String, s2: String) -> Bool in return s1 > s2 } )

reversed = names.sort( { s1, s2 in return s1 > s2 } )

reversed = names.sort( { s1, s2 in s1 > s2 } )

reversed = names.sort( { $0 > $1 } )

reversed = names.sort() { $0 > $1 }

reversed = names.sort { $0 > $1 }

let digitNames = [
	0: "Zero",
	1: "One",
	2: "Two",
	3: "Three",
	4: "Four",
	5: "Five",
	6: "Six",
	7: "Seven",
	8: "Eight",
	9: "Nine",
]
let numbers = [ 16, 58, 510 ]

let strings = numbers.map { (number) -> String in
	var number = number
	var output = ""
	
	while number > 0
	{
		output = digitNames[number % 10]! + output
		number /= 10
	}
	
	return output
}

/*
Apple says "As an optimization, Swift may instead capture and store a copy of a value if that value is not mutated by a closure, and if the value is not mutated after the closure is created."

In theory I could have a closure that captures a variable and doesn't modify it. But would want to be kept abrest of any changes in that variable outside of the scope so that it would always be representative of the latest. I wonder if o
*/

// Marking a closure with @noescape lets you refer to self implicitly within the closure.