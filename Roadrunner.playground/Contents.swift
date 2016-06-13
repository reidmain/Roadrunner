/*
A Playground that will be used as a general scratchpad while working through Apple's iBook on Swift 2.2
Other more specific Playgrounds will probably be created to test out specific features of Swift and this one will be the most generic one to be used when I don't know where something should go.   
*/

// Thank god no println or @ symbols.
print("Hello, world!")
// Interesting that the first parameter is not named and is variadic. I guess it assumes everything up until a named variable is part of the variadic array. Pretty neat.
print("Hello, world!", "This is me printing multiple items.", "This is a very nice built in function.", separator: "\n", terminator: "Goodbye")

// MARK: Variables and Strings

var implicitInteger = 42
implicitInteger = 50
// Not allowed because the compiler infers `implicitInteger` is an integer and we are trying to set it to be a Double.
//implicitInteger = 666.666

let myConstant = 42
// Not allowed because keyword `let` means it is a constant. Throws a compile time error if you attempt to modify it. Immutability FTW!
//myConstant = 50

var explicitDouble: Double = 42
explicitDouble = 666.666

var explicitFloat: Float = 4
explicitFloat = 1 / 3

let labelText = "The width is "
let width = 94
let letWidthLabel = labelText + String(width) // Interesting. A generic `String` function to convert something to a String. Oh nevermind that is actually calling the constructor for the `String` class, or struct as it is.

let numOfApples = 3
let numOfOranges = 5
let appleSummary = "I have \(numOfApples) apples."
// This is definitely one of the things I love most about Ruby. String concatenation was always a bit of a pain in the ass in Objective-C.
let fruitSummary = "I have \(numOfApples + numOfOranges) pieces of fruit."

let name = "Elsie"
let welcomeText = "Hello \(name). It is good to see you again."

let x: Float = 1 / 3
let y: Float = 666.67
let summary = "What is the product of \(x) and \(y)? Why it would be \(x * y) of course!"

// MARK: Arrays and Dictionaries

var shoppingList = [ "catfish", "water", "tulips", "blue paint" ] // Always leave a leading a trailing space when creating an array. Easier to read IMO.
shoppingList[1] = "bottle of water"
shoppingList

var occupations = [
	"Malcolm" : "Captain", // I am not a fan of having the `:` be right up against the key. Harder to read IMO.
	"Kaylee" : "Mechanic",
]
occupations["Jayne"] = "Public Relations"
occupations

//let emptyArray = Array<String>() // The Swift book says use String[] but it was giving an error saying that `Instance member 'subscript' cannot be used on type 'String'`.
let emptyArray = [String]()
emptyArray.dynamicType
let emptyDictionary = Dictionary<String, Float>()
emptyDictionary.dynamicType

shoppingList = []
occupations = [:]

// MARK: Conditionals

let individualScores = [ 75, 43, 103, 87, 12 ]
individualScores.dynamicType
var teamScore = 0
for score in individualScores
{
	if score > 50
	{
		teamScore += 3
	}
	else
	{
		teamScore += 1
	}
}
teamScore

var optionalString: String? = "Hello"
optionalString == nil
optionalString = nil
optionalString == nil

var optionalName: String? = "John Appleseed"
optionalName = nil
var greeting = "Hello!\n"
if let name = optionalName
{
	greeting = "Hello, \(name)"
}
else
{
	greeting = "Hello, Man with No Name."
}

var vegetable = "red pepper"
vegetable = "celery"
vegetable = "cucumber"
vegetable = "watercress"
vegetable = "carrots"
switch vegetable
{
	case "celery":
		let vegetableComment = "Add some raisins and make ants on a log."
	case "cucumber", "watercress": // Multiple cases at a time for Strings. What an age we live in.
		let vegetableComment = "That would make a good tea sandwich."
	case let x where x.hasSuffix("pepper"):
		let vegetableComment = "Is it a spicy \(x)?"
	default:
		let vegetableComment = "Everything tastes good in soup."	
}

let interestingNumbers = [
	"Prime" : [ 2, 3, 5, 7, 11, 13 ],
	"Fibonacci" : [ 1, 1, 2, 3, 5, 8 ],
	"Square" : [ 1, 4, 9, 16, 25 ],
]
var kindOfLargest: String = "Unknown"
var largest = 0
for (kind, numbers) in interestingNumbers
{
	for number in numbers
	{
		if number > largest
		{
			kindOfLargest = kind
			largest = number
		}
	}
}
kindOfLargest
largest

var n = 2
while n < 100
{
	n = n * 2
}
n

var m = 2
repeat // Swift book says to use `do` but it looks like that has been deprecated.
{
	m = m * 2
} while m < 100
m

var firstForLoop = 0
for i in 0 ... 3 // Swift book says use two periods but apparently it is now three.
{
	firstForLoop += i
}
firstForLoop

var secondForLoop = 0
//for var i = 0; i < 3; ++i // Getting a warning that this will be deprecated in a future version of Swift.
for i in 0 ..< 3
{
	secondForLoop += 1
}
secondForLoop

// MARK: Functions and Closures

func greet(name: String, day: String, lunchSpecial: String? = nil) -> String
{
	var greeting = "Hello \(name), today is \(day)."
	
//	if lunchSpecial != nil
//	{
//		greeting += " Today's lunch special is \(lunchSpecial!)."
//	}
	if let explicitLunchSpecial = lunchSpecial
	{
		greeting += " Today's lunch special is \(explicitLunchSpecial)."
	}
	
	return greeting
}

greet("Bob", day: "Tuesday") // The Swift book said you could omit `day:` but thankfully they have updated Swift to force having parameter names. Still not a fan that I can't add `name:` to the first parameter. Gotta put it in the method name which just leads to annoying things if you wanted to modify that parameter in the future. I'm looking forward to functions where it does not matter what order the parameters are in since they should all be named.
greet("Elsie", day: "Wednesay", lunchSpecial: "Hamburgers")

func getGasPrices() -> (Double, Double, Double)
{
	return (3.59, 3.69, 3.79)
}
getGasPrices()

func sumOf(numbers: [Int]) -> Int
{
	var sum = 0
	
	for number in numbers
	{
		sum += number
	}
	
	return sum
}

func sumOf(numbers: Int...) -> Int
{
	return sumOf(numbers)
}

sumOf()
sumOf(42, 597, 12)

func averageOf(numbers: Int...) -> Int
{
	let average = sumOf(numbers) / numbers.count
	
	return average
}
averageOf(1, 2, 3)
averageOf(3, 5, 7)

func returnFiften() -> Int
{
	var y = 10
	
	func add()
	{
		y += 5
	}
	
	add()
	
	return y
}
returnFiften() // This has got to be the stupidest example ever.

func makeIncrementer() -> (Int ->  Int) {
	func addOne(number: Int) -> Int
	{
		return 1 + number
	}
	return addOne
}
var increment = makeIncrementer()
increment.dynamicType
increment(7)

func hasAnyMatches(list: [Int], condition: Int -> Bool) -> Bool
{
	for item in list
	{
		if condition(item)
		{
			return true
		}
	}
	
	return false
}

func lessThanTen(number: Int) -> Bool
{
	return number < 10
}
var numbers = [ 20, 19, 17, 12 ]
hasAnyMatches(numbers, condition: lessThanTen)

numbers.map({
	(number: Int) -> Int in
	var result = 0
	if number % 2 == 0
	{
		result = 3 * number
	}
	return result
})

// A alternative way to write the previous closure. Honestly both look butt ugly and hard to read to my eyes.
numbers.map({
	number in
	var result = 0
	if number % 2 == 0
	{
		result = 3 * number
	}
	result
})

let bah = numbers.map({ number in 3 * number})
bah.dynamicType

// Two equivalent ways to write the same closure.
[ 1, 5, 3, 12, 2 ].sort({ $0 > $1 })
[ 1, 5, 3, 12, 2 ].sort() { $0 > $1 }

// MARK: Objects and Classes

class Shape
{
	var numberOfSlides = 0
	
	func simpleDescription() -> String
	{
		return "A shape with \(numberOfSlides) slides."
	}
}

var shape = Shape()
shape.numberOfSlides = 7
var shapeDescription = shape.simpleDescription()

class NamedShape
{
	var numberOfSlides = 0
	var name: String
	
	init(name: String)
	{
		self.name = name
	}
	
	func simpleDescription() -> String
	{
		return "A shape with \(numberOfSlides) slides."
	}
}

class Square : NamedShape
{
	var sideLength: Double
	
	init(sideLength: Double, name: String)
	{
		self.sideLength = sideLength
		
		super.init(name: name)
		
		self.numberOfSlides = 4
	}
	
	func area() -> Double
	{
		return self.sideLength * self.sideLength
	}
	
	override func simpleDescription() -> String
	{
		return "A square with sides of length \(self.sideLength)."
	}
}

let test = Square(sideLength: 5.2, name: "my test square")
test.area()
test.simpleDescription()

import Darwin

class Circle : NamedShape
{
	var radius: Double
	
	init(radius: Double, name: String)
	{
		self.radius = radius
		
		super.init(name: name)
		
		self.numberOfSlides = 0
	}
	
	func area() -> Double
	{
		let π = M_PI
		return π * pow(self.radius, 2)
	}
	
	override func simpleDescription() -> String
	{
		return "A circle with a radius of \(self.radius)."
	}
}
let testCircle = Circle(radius: 5, name: "test circle")
testCircle.area()
test.simpleDescription()

class EquilateralTriangle : NamedShape
{
	var sideLength: Double = 0.0
	
	init(sideLength: Double, name: String)
	{
		self.sideLength = sideLength
		
		super.init(name: name)
		
		self.numberOfSlides = 3
	}
	
	var perimeter: Double
	{
		get
		{
			return 3.0 * sideLength
		}
		
		set
		{
			self.sideLength = newValue / 3.0
		}
	}
	
	override func simpleDescription() -> String
	{
		return "An equilateral triangel with side of length \(self.sideLength)."
	}
}
var triangle = EquilateralTriangle(sideLength: 3.1, name: "a triangle")
triangle.perimeter
triangle.perimeter = 9.9
triangle.sideLength

class TriangleAndSquare
{
	var triangle: EquilateralTriangle
	{
		willSet
		{
			self.square.sideLength = newValue.sideLength
		}
	}
	
	var square: Square
	{
		willSet
		{
			self.triangle.sideLength = newValue.sideLength
		}
	}
	
	init(size: Double, name: String)
	{
		self.square = Square(sideLength: size, name: name)
		self.triangle = EquilateralTriangle(sideLength: size, name: name)
	}
}
var triangleAndSquare = TriangleAndSquare(size: 10, name: "another test shape")
triangleAndSquare.square.sideLength
triangleAndSquare.triangle.sideLength
triangleAndSquare.square = Square(sideLength: 50, name: "larger square")
triangleAndSquare.triangle.sideLength

class Counter
{
	var count: Int = 0
	
	func incrementBy(amount: Int, numberOfTimes times: Int)
	{
		count += amount * times
	}
}
var counter = Counter()
counter.incrementBy(2, numberOfTimes: 7)

let optionalSquare: Square? = Square(sideLength: 2.5, name: "optional square") // Square? is the same as Optional<Square>
let sideLength = optionalSquare?.sideLength
sideLength.dynamicType

// MARK: Enumerations and Structures

enum Rank : Int
{
	case Ace = 1
	case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten
	case Jack, Queen, King
	
	func simpleDescription() -> String
	{
		switch self
		{
			case .Ace:
				return "ace"
			case .Jack:
				return "jack"
			case .Queen:
				return "queen"
			case .King:
				return "king"
			default:
				return String(self.rawValue) // The toRaw() method was replaced with rawValue.
		}
	}
	
	func simpleCompare(rank: Rank) -> Bool
	{
		return self.rawValue == rank.rawValue
	}
}
let ace = Rank.Ace
let aceRawValue = ace.rawValue

let jack = Rank.Jack
let jackRawValue = jack.rawValue

ace.simpleCompare(jack)
ace.simpleCompare(ace)

if let convertedRank = Rank(rawValue: 3) // fromRaw method has been replaced with a failable initializer.
{
	let threeDescription = convertedRank.simpleDescription()
}

enum Suit
{
	case Spades, Hearts, Diamonds, Clubs
	
	func simpleDescription() -> String
	{
		switch self
		{
			case .Spades:
				return "spades"
			case .Hearts:
				return "hearts"
			case .Diamonds:
				return "diamonds"
			case .Clubs:
				return "clubs"
		}
	}
	
	func color() -> String
	{
		switch self
		{
			case .Spades, .Clubs:
				return "black"
			case .Hearts, .Diamonds:
				return "red"
		}
	}
}
let hearts = Suit.Hearts
let heartsDescription = hearts.simpleDescription()
let heartsColor = hearts.color()

Suit.Clubs.color()

struct Card
{
	var rank: Rank
	var suit: Suit
	
	func simpleDescription() -> String
	{
		return "The \(rank.simpleDescription()) of \(suit.simpleDescription())"
	}
}

let threeOfSpades = Card(rank: .Three, suit: .Spades) // Interesting that this constructor is automatically created.
let threeOfSpadesDescription = threeOfSpades.simpleDescription()

enum ServerResponse
{
	case Result(String, String)
	case Error(String)
}

let success = ServerResponse.Result("6:00 am", "8:09 pm")
let failure = ServerResponse.Error("Out of cheese")

switch success
{
	case let .Result(sunrise, sunset):
		let serverResponse = "Sunrise is at \(sunrise) and sunset is at \(sunset)."
	case let .Error(error):
		let serverResposne = "Failure... \(error)"
}

// MARK: Protocols and Extensions

protocol ExampleProtocol
{
	var simpleDescription: String { get }
	mutating func adjust()
}

class SimpleClass : ExampleProtocol
{
	var simpleDescription: String = "A very simple class."
	var anotherProperty: Int = 69105
	
	func adjust()
	{
		simpleDescription += " Now 100% adjusted."
	}
}
var a = SimpleClass()
a.adjust()
var aDescription = a.simpleDescription
a.adjust()
aDescription = a.simpleDescription

struct SimpleStructure : ExampleProtocol
{
	var simpleDescription: String = "A simple structure"
	
	mutating func adjust()
	{
		simpleDescription += " (adjusted)"
	}
}
var b = SimpleStructure()
b.adjust()
var bDescription = b.simpleDescription
b.adjust()
bDescription = b.simpleDescription

enum SimpleEnumeration : String, ExampleProtocol
{
	case Default = "Default", Adjusted = "Adjusted"
	
	var simpleDescription: String
	{
		get
		{
			return self.rawValue
		}
	}
	
	mutating func adjust()
	{
		self = .Adjusted
	}
}
var c = SimpleEnumeration.Default
c.simpleDescription
c.adjust()
let cDescription = c.simpleDescription

extension Int: ExampleProtocol
{
	var simpleDescription: String
	{
		return "The number \(self)"
	}
	
	mutating func adjust()
	{
		self += 42
	}
}
7.simpleDescription
var adjustableNumber = 7
adjustableNumber.adjust()
adjustableNumber.adjust()

extension Double
{
	var absoluteValue: Double
	{
		get
		{
			return fabs(self)
		}
	}
}
(-666.67).absoluteValue

let protocolValue: ExampleProtocol = a
protocolValue.simpleDescription

// How do you define a variable that is an explicit class and adheres to a protocol? Would you ever actually need to do that?

// MARK: Generics

func repeatItems<ItemType>(item: ItemType, times: Int) -> [ItemType]
{
	var result = [ItemType]()
	
	for _ in 0 ... times
	{
		result.append(item)
	}
	
	return result
}
repeatItems("knock", times: 4)

// Reimplement the Swift standard library's optional type
enum OptionalValue<T>
{
	case None
	case Some(T)
}

var possibleInteger: OptionalValue<Int> = .None
possibleInteger = .Some(100)

//import Foundation

func anyCommonElements <T, U where T: SequenceType, U: SequenceType, T.Generator.Element: Equatable, T.Generator.Element == U.Generator.Element> (lhs: T, rhs: U) -> [T.Generator.Element]
{
	var commonElements = Array<T.Generator.Element>()
	
	for lhsItem in lhs
	{
		for rhsItem in rhs
		{
			if lhsItem == rhsItem
			{
				commonElements.append(lhsItem)
			}
		}
	}
	
	return commonElements
}
anyCommonElements([ 1, 2, 3, 4, 5, 6, 666 ], rhs: [ 3, 666, 1 ])