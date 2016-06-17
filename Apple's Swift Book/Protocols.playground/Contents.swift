/*
Code generated while going through the 'Protocols' chapter of Apple's Swift book.
*/

protocol RandomNumberGenerator
{
	func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator
{
	var lastRandom = 42.0
	let m = 139968.0
	let a = 3877.0
	let c = 29573.0
	
	func random() -> Double
	{
		lastRandom = ((lastRandom * a + c) % m)
		return lastRandom / m
	}
}

import Foundation

class ArcRandomNumberGenerator : RandomNumberGenerator
{
	func random() -> Double
	{
		let roll = arc4random_uniform(100)
		
		return Double(roll) / 100
	}
}

class Dice
{
	let sides: Int
	let generator: RandomNumberGenerator
	
	init(sides: Int, generator: RandomNumberGenerator)
	{
		self.sides = sides
		self.generator = generator
	}
	
	func roll() -> Int
	{
		return Int(generator.random() * Double(sides)) + 1
	}
}

protocol DiceGame
{
	var dice: Dice { get }
	
	func play()
}
protocol DiceGameDelegate
{
	func gameDidStart(game: DiceGame)
	func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
	func gameDidEnd(game: DiceGame)
}

class SnakesAndLadders : DiceGame
{
	let finalSquare = 25
	let dice = Dice(sides: 6, generator: ArcRandomNumberGenerator())
	var square = 0
	var board: [Int]
	
	init()
	{
		board = [Int](count: finalSquare + 1, repeatedValue: 0)
		board[03] = +08
		board[06] = +11
		board[09] = +09
		board[10] = +02
		board[14] = -10
		board[19] = -11
		board[22] = -02
		board[24] = -08
	}
	
	var delegate: DiceGameDelegate?
	
	func play()
	{
		square = 0
		
		delegate?.gameDidStart(self)
		
		gameLoop: while square != finalSquare
		{
			let diceRoll = dice.roll()
			
			delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
			
			switch square + diceRoll
			{
				case finalSquare:
					break gameLoop
				case let newSquare where newSquare > finalSquare:
					continue gameLoop
				default:
					square += diceRoll
					square += board[square]
			}
		}
		
		delegate?.gameDidEnd(self)
	}
}

class DiceGameTracker : DiceGameDelegate
{
	var numberOfTurns = 0
	
	func gameDidStart(game: DiceGame)
	{
		numberOfTurns = 0
		
		if game is SnakesAndLadders
		{
			print("Started a new game of Snakes and Ladders.")
		}
		
		print("The game is usign a \(game.dice.sides) sided die.")
	}
	
	func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
	{
		numberOfTurns += 1
		print("Rolled a \(diceRoll)")
	}
	
	func gameDidEnd(game: DiceGame)
	{
		print("The game lasted for \(numberOfTurns) turns.")
	}
}

let tracker = DiceGameTracker()
let game = SnakesAndLadders()
game.delegate = tracker
game.play()

protocol TextRepresentable
{
    var textualDescription: String { get }
}

protocol PrettyTextRepresentable : TextRepresentable
{
	var prettyTextualDescription: String { get }
}

extension Dice : TextRepresentable
{
	var textualDescription: String
	{
		get
		{
			return "A \(sides)-sided die."
		}
	}
}

let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
print(d12.textualDescription)

extension SnakesAndLadders : TextRepresentable
{
	var textualDescription: String
	{
		return "A game of Snakes and Ladders with \(finalSquare) squares."
	}
}
print(game.textualDescription)

struct Hamster
{
	var name: String
	var textualDescription: String
	{
		get
		{
			return "A hamster named \(name)."
		}
	}
}

extension Hamster : TextRepresentable {}

let simonTheHamster = Hamster(name: "Simon")
let somethingTextRepresentable: TextRepresentable = simonTheHamster
print(somethingTextRepresentable.textualDescription)

extension SnakesAndLadders : PrettyTextRepresentable
{
	var prettyTextualDescription: String
	{
		get
		{
			var output = textualDescription + ":\n"
			
			for index in 1 ... finalSquare
			{
				switch board[index]
				{
					case let ladder where ladder > 0:
						output += "▲ "
					case let snake  where snake < 0:
						output += "▼ "
					default:
						output += "○ "
				}
			}
			
			return output
		}
	}
}

print(game.prettyTextualDescription)

protocol Named
{
	var name: String { get }
}

protocol Aged
{
	var age: Int { get }
}

struct Person: Named, Aged
{
	var name: String
	var age: Int
}

func wishHappyBirthday(celebrator: protocol<Named, Aged>)
{
	print("Happy birthday \(celebrator.name) - you're \(celebrator.age)!")
}
let birthdayPerson = Person(name: "Malcolm", age: 21)
wishHappyBirthday(birthdayPerson)

extension RandomNumberGenerator
{
	func randomBool() -> Bool
	{
		return random() > 0.5
	}
}

extension PrettyTextRepresentable
{
	var prettyTextualDescription: String
	{
		return textualDescription
	}
}
