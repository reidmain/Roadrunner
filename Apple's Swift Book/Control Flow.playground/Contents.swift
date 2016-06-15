/*
Code generated while going through the 'ControlFlow' chapter of Apple's Swift book.
*/

let base = 3
let power = 10
var answer = 1
for _ in 1...power
{
	answer *= base
}
print("\(base) to the power of \(power) is \(answer)")

// Now let's play Snakes & Ladders
let finalSquare = 25
var board = [Int](count: finalSquare + 1, repeatedValue: 0)
board[03] = +08
board[06] = +11
board[09] = +09
board[10] = +02
board[14] = -10
board[19] = -11
board[22] = -02
board[24] = -08

var square = 0
var diceRoll = 0

while square < finalSquare
{
	diceRoll += 1
	if diceRoll == 7
	{
		diceRoll = 1
	}
	
	square += diceRoll
	
	if square < board.count
	{
		square += board[square]
	}
}
print("Game over!")

square = 0
diceRoll = 0
repeat
{
	square += board[square]
	
	diceRoll += 1
	if diceRoll == 7
	{
		diceRoll = 1
	}
	
	square += diceRoll
} while square < finalSquare
print("Game over!")

let anotherCharacter: Character = "a"
switch anotherCharacter
{
	case "a", "A":
		print("The letter A")
	default:
		print("Not the letter A")
}

let count = 3_000_000_000_000
let countedThings = "stars in the Milky Way"
var naturalCount: String
switch count
{
	case 0:
		naturalCount = "no"
	case 1 ... 3:
		naturalCount = "a few"
	case 4 ... 9:
		naturalCount = "several"
	case 10 ... 99:
		naturalCount = "tens of"
	case 100 ... 999:
		naturalCount = "hundreds of"
	case 1000 ... 999_999:
		naturalCount = "thousands of"
	default:
		naturalCount = "millions and millions of"
}
print("There are \(naturalCount) \(countedThings).")

let somePoint = (1, 1)
switch somePoint
{
	case (0, 0):
		print("(0, 0) is at the origin")
	case (_, 0):
		print("(\(somePoint.0), 0) is on the x-axis")
	case (0, _):
		print("(0, \(somePoint.1)) is on the y-axis")
	case (-2 ... 2, -2 ... 2):
		print("(\(somePoint.0), \(somePoint.1)) is inside the box")
	default:
		print("(\(somePoint.0), \(somePoint.1)) is outside of the box")
}

let anotherPoint = (2, 0)
switch anotherPoint
{
	case (let x, 0):
		print("on the x-axis with an x value of \(x)")
	case (0, let y):
		print("on the y-axis with a y value of \(y)")
	case let (x, y):
		print("somewhere else at (\(x), \(y))")
}

let yetAnotherPoint = (1, -1)
switch yetAnotherPoint
{
	case let (x, y) where x == y:
		print("(\(x), \(y)) is on the line x == y")
	case let (x, y) where x == -y:
		print("(\(x), \(y)) is on the line x == -y")
	case let (x, y):
		print("(\(x), \(y)) is just some arbitrary point")
}

square = 0
diceRoll = 0
gameLoop: while square != finalSquare
{
    diceRoll += 1
	if diceRoll == 7
	{
		diceRoll = 1
	}
	
    switch square + diceRoll
	{
		case finalSquare:
			// diceRoll will move us to the final square, so the game is over
			break gameLoop
		case let newSquare where newSquare > finalSquare:
			// diceRoll will move us beyond the final square, so roll again
			continue gameLoop
		default:
			// this is a valid move, so find out its effect
			square += diceRoll
			square += board[square]
    }
}
print("Game over!")