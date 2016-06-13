/*
Code generated while going through 'The Basics' chapter of Apple's Swift book.
*/

// "Primative" Types
let integer: Int = 666
let double: Double = 666.6
let float: Float = 666.6
let bool: Bool = true
let string:String = "Reid" 

// Collection Types
let array = Array<String>()
let dictionary = Dictionary<String, Int>()

// Advanced Types
let tuple: (Int, Double, Float) = (666, 666.6, 666.6)
let optionalString = String?()
let explicitlyOptionalString = Optional<String>()

// MARK: Type Annotations

let inferredDouble = 666.666
inferredDouble.dynamicType
let annotatedDouble: Double = 666.666

// MARK: Naming Constants and Variables

import Darwin

let π = M_PI
let 👍🏻😎 = "Deal with my thumbs up Elsie"
let 😑 = "Elsie is not impressed"

let `repeat` = "This should be illegal except the backticks save me. However I really shouldn't do this."
let repeatInString = "I am really just doing stupid shit now\n\(`repeat`)"

// MARK: Comments

// Obviously this is a single line comment.

/*
These allow you to do multi line comments
*/

/*
You're also allowed to next multi line comments.
/* What the fuck is going on here? */
What an age we live in.
*/

// MARK: Integers

let int16: Int16 = 666
int16.dynamicType
let uint16: UInt16 = 666
uint16.dynamicType

let uint8min = UInt8.min
let uint8max = UInt8.max

let nativeInt: Int = 666
nativeInt.dynamicType

let nativeUInt: UInt = 666
nativeUInt.dynamicType

// MARK: Floating-Point

// Float represents 32-bit floating point numbers and Double represents 64-bit

// Type Inference

let decimalInteger = 17
decimalInteger.dynamicType
let binaryInteger = 0b10001 // 17 in binary notation
binaryInteger.dynamicType
let octalInteger = 0o21 // 17 in octal notation
octalInteger.dynamicType
let hexadecimalInteger = 0x11 // 17 in hexadecimal notation
hexadecimalInteger.dynamicType

let decimalDouble = 12.1875
decimalDouble.dynamicType
let exponentDouble = 1.21875e1 // 1.21875 * 10^1
exponentDouble.dynamicType
let hexadecimalDouble = 0xC.3p0 // 12.1875 * 2^0
hexadecimalDouble.dynamicType

let paddedDouble = 000123.456
let oneMillion = 1_000_000
let justOverOneMillion = 1_000_000.000_000_1

// MARK: Type Aliases

typealias AudioSample = UInt16

// MARK: Tuples

let http404Error = (404, "Not Found")

let (statusCode, statusMessage) = http404Error
print("The status code is \(statusCode)")
print("The status message is \(statusMessage)")

let (justTheStatusCode, _) = http404Error
print("The status code is \(justTheStatusCode)")

print("The status code is \(http404Error.0)")
print("The status message is \(http404Error.1)")

let http200Status = (statusCode: 200, description: "OK")
print("The status code is \(http200Status.statusCode)")
print("The status message is \(http200Status.description)")

// MARK: Optionals

// The book says use the toInt method on a String variable but it looks like that has been removed and now you should use the proper initializer which can return an Optional.

let myNameAsInt = Int("Reid")
myNameAsInt.dynamicType
let theDevilAsInt = Int("666")
theDevilAsInt.dynamicType

// This is called "Optional Binding"
let possibleNumber = "123"
if let actualNumber = Int(possibleNumber)
{
	print("\(possibleNumber) has an integer value of \(actualNumber)")
}
else
{
	print("\(possibleNumber) could not be converted to an integer")
}