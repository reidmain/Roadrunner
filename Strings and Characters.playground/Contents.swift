/*
Code generated while going through the 'Strings and Characters' chapter of Apple's Swift book.
*/

"\0"
"\\"
"\t"
"\n"
"\r"
"\""
"\'"
"\u{21}"
"\u{2121}"
"\u{21212}"
"\u{0024}"
"\u{2665}"
"\u{0001F496}"

"" == String()

"".isEmpty
"     ".isEmpty
"\t".isEmpty

// Strings Are Value Types. I'm writing this down in the hopes that I don't forget this at some crucial point in the future.
// "Behind the scenes, Swift’s compiler optimizes string usage so that actual copying takes place only when absolutely necessary. This means you always get great performance when working with strings as value types" I would love to know the details of how exactly it knows when it should copy and when it does not have to.

// Strings can be enumerated through easily and each character in the string is appropriately a Character object. And of course as I am typing this I am now just realizing that String does not conform to the SequenceType protocol. Fucking hell Apple book. Throw me a freakin' bone here. I'm the boss. Need the info.
for character in "Dog!🐶".characters // Looks like you just access the characters property now to get back a CharacterView struct. Not exactly sure how performant this is.
{
	print(character)
}

let yenSignExplicit: Character = "¥"
yenSignExplicit.dynamicType
let yenSignImplicit = "¥"
yenSignImplicit.dynamicType

let unusualMenagerie = "Koala 🐨, Snail 🐌, Penguin 🐧, Dromedary 🐪"
print("unusualMenagerie has \(unusualMenagerie.characters.count) characters") // Apple removed the countElements function in Swift 2 and the count function doesn't appear to work with String objects.

/*
Apple lies. Don't believe them when they say the + operator works on Character objects.

let string1 = "hello"
let string2 = " there"
let character1: Character = "!"
let character2: Character = "?"

let stringPlusCharacter = string1 + character1        // equals "hello!"
let stringPlusString = string1 + string2              // equals "hello there"
let characterPlusString = character1 + string1        // equals "!hello"
let characterPlusCharacter = character1 + character2  // equals "!?
*/

// String Interpolation

let multiplier = 3
let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"

// However the expressions that can be written inside the parenthesis are limited which leads me to ask why use string interpolation at all? Why not just concatonate everything with the + operator? Maybe there is some performance hit to creating and concatonating all those strings versus interpolating a single one? Oh it is because if the expressions are not strings then you have to explicit create strings from them before you can concatonate them. So yeah interpolation is much cleaner.

let otherMessage = String (multiplier) + " times 2.5 is " + String((Double(multiplier) * 2.5)) 
message == otherMessage

// Two strings are equal if they contain the exact same characters in the same order. No bullshit pointer comparison here.
let quotation = "We're a lot alike, you and I."
let sameQuotation = "We're a lot alike, you and I."
if quotation == sameQuotation {
	print("These two strings are considered equal")
}

let romeoAndJuliet = [
	"Act 1 Scene 1: Verona, A public place",
	"Act 1 Scene 2: Capulet's mansion",
	"Act 1 Scene 3: A room in Capulet's mansion",
	"Act 1 Scene 4: A street outside Capulet's mansion",
	"Act 1 Scene 5: The Great Hall in Capulet's mansion",
	"Act 2 Scene 1: Outside Capulet's mansion",
	"Act 2 Scene 2: Capulet's orchard",
	"Act 2 Scene 3: Outside Friar Lawrence's cell",
	"Act 2 Scene 4: A street in Verona",
	"Act 2 Scene 5: Capulet's mansion",
	"Act 2 Scene 6: Friar Lawrence's cell"
]

var act1SceneCount = 0
for scene in romeoAndJuliet
{
	if scene.hasPrefix("Act 1 ")
	{
		act1SceneCount += 1
	}
}
print("There are \(act1SceneCount) scenes in Act 1")

var mansionCount = 0
var cellCount = 0
for scene in romeoAndJuliet
{
	if scene.hasSuffix("Capulet's mansion")
	{
		mansionCount += 1
	}
	else if scene.hasSuffix("Friar Lawrence's cell")
	{
		cellCount += 1
	}
}
print("\(mansionCount) mansion scenes; \(cellCount) cell scenes")

let dogString = "Dog!🐶"
let dogStringAlt = "Dog!\u{1F436}"
dogString == dogStringAlt

let utf8Dog = dogString.utf8
utf8Dog.dynamicType

print("UTF 8 Dog")
for codeUnit in utf8Dog
{
	codeUnit.dynamicType
	print("\(codeUnit)")
}

let utf16Dog = dogString.utf16
utf16Dog.dynamicType

print("UTF 16 Dog")
for codeUnit in utf16Dog
{
	codeUnit.dynamicType
	print("\(codeUnit)")
}