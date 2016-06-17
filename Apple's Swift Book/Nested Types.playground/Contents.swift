/*
Code generated while going through the 'Nested Types' chapter of Apple's Swift book.
*/

struct BlackjackCard
{    
	enum Suit : Character
	{
		case Spades = "♠"
		case Hearts = "♡"
		case Diamonds = "♢"
		case Clubs = "♣"
	}
	
	enum Rank : Int
	{
		case Two = 2, Three, Four, Five, Six, Seven, Eight, Nine, Ten
		case Jack, Queen, King, Ace
		
		struct Values
		{
			let first: Int, second: Int?
		}
		
		var values: Values
		{
			switch self
			{
				case .Ace:
					return Values(first: 1, second: 11)
				case .Jack, .Queen, .King:
					return Values(first: 10, second: nil)
				default:
					return Values(first: self.rawValue, second: nil)
			}
		}
	}
	
	let rank: Rank
	let suit: Suit
	var description: String
	{
		var output = "suit is \(suit.rawValue),"
		output += " value is \(rank.values.first)"
		
		if let second = rank.values.second {
			output += " or \(second)"
		}
		return output
	}
}

let theAceOfSpades = BlackjackCard(rank: .Ace, suit: .Spades)
print("theAceOfSpades: \(theAceOfSpades.description)")

let heartsSymbol = BlackjackCard.Suit.Hearts.rawValue