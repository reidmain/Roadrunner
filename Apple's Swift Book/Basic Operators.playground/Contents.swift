/*
Code generated while going through the 'Basic Operators' chapter of Apple's Swift book.
*/

true && true
true && false
false && false

true || true
true || false
false || false

var increment = 0
++increment // This is being deprecated in Swift 3 which is great thank God. Remove ambiguity.
increment += 1

5 % 3
10.5 % 3 // Remainder operator works with floating point numbers.
10 % 3.3

let bah = (increment = 1) // Strange that this doesn't throw a compiler error. I would have figured that nothing would have been returned from the variable being assigned.

// Unary Operators
var i = 0
--i
++i
i--
i++

// Binary Operators
2 + 3
5 * 3
5 / 3
5.5 / 3

// Ternary Operators
i == 2 ? "True" : "False"

// String concatonation, yay!
"hello, " + "world"

let dog: Character = "🐶"
let cow: Character = "🐮"
// let dogCow = dog + cow // God damn it Apple book you lied to me. + can't be applied to Character objects anymore?

// Range Operators

let closedRange = 1 ... 5
closedRange.dynamicType

let halfRange = 1 ..< 6
halfRange.dynamicType

let alphabet = "A" ... "Z"
alphabet.dynamicType