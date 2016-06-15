/*
Code generated while going through the 'Functions' chapter of Apple's Swift book.
*/

func noReturn()
{
	print("Wassup")
}

let a: Void = noReturn()
a.dynamicType

func count(string: String) -> (vowels: Int, consonants: Int, others: Int)
{
	var vowels = 0
	var consonants = 0
	var others = 0
	
	for character in string.characters
	{
		switch String(character).lowercaseString
		{
			case "a", "e", "i", "o", "u":
				vowels += 1
			case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
			"n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
				consonants += 1
			default:
				others += 1
		}
	}
	
	return (vowels, consonants, others)
}
count("Reid")

let total = count("some arbitrary string!")
print("\(total.vowels) vowels and \(total.consonants) consonants")

func someFunction(externalParameterName localParameterName: Int)
{
	print(localParameterName)
}
someFunction(externalParameterName: 5)

/*
Looks like in Swift 2 Apple got rid of the # for shorthand external parameter names. Apparently every parameter except the first now just defaults to the same external as for internal and the first parameter you would have to explicit put the same external name as the internal one. Thankfully in Swift 3 they are even doing away with that exception and every parameter will just implicit have the same external name as the internal one.

func containsCharacter(#string: String, #characterToFind: Character) -> Bool
{
	for character in string.characters
	{
		if character == characterToFind
		{
			return true
		}
	}
	return false
}
*/

func arithmeticMean(numbers numbers: Double..., trailingNumber: Double) -> Double
{
	var total: Double = 0
	
	for number in numbers
	{
		total += number
	}
	
	return total / Double(numbers.count)
}
arithmeticMean(numbers: 1, 2, 3, 4, 5, trailingNumber: 5)
arithmeticMean(numbers: 3, 8, 19, trailingNumber: 5)
// The Apple book says that variadic parameters must come last but apparently Swift 2 changed that. Functions can still have at most one variadic parameter.

func replace(var string: String, range: Range<Int>, character: Character) -> String
{
	let substring = String(count: range.count, repeatedValue: character)
	string.replaceRange(string.startIndex.advancedBy(range.startIndex) ... string.startIndex.advancedBy(range.endIndex), with: substring)
	return string
}
replace("Reid Rules", range: 1 ... 6, character: "!")

func swapTwoInts(inout a: Int, inout b: Int)
{
	let temporaryA = a
	a = b
	b = temporaryA
}

var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, b: &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")

func growString(inout string string: String, character: Character)
{
	string.append(character)
}

var name = "Reid"
growString(string: &name, character: "!")

func addUnit(name: String, allegiance: String = "Alliance", race: String = "Dwarf", age: Int, warcry: (name: String) -> Void) -> (String, String, String, Int)
{
	warcry(name: name)
	return (name, allegiance, race, age)
}
addUnit("Elsie", allegiance: "Alliance", race: "Human", age: 25, warcry: { name in print("\(name):\tARRR!") })
addUnit("Reid", allegiance: "Horde", age: 30) { name in print("\(name):\tLOK'TAR OGAR!") }
addUnit("Joe", race: "Elf", age: 600) { _ in print("*Nothing*") }

func stepForward(input: Int) -> Int
{
	return input + 1
}

func stepBackward(input: Int) -> Int
{
	return input - 1
}

typealias StepFunction = (Int) -> (Int)
func chooseStepFunction(backwards: Bool) -> StepFunction
{
	return backwards ? stepBackward : stepForward
}

var currentValue = -10
while currentValue != 0
{
	let moveNearerToZero = chooseStepFunction(currentValue > 0)
	currentValue = moveNearerToZero(currentValue)
}