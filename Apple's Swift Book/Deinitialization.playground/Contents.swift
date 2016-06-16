/*
Code generated while going through the 'Deinitialization' chapter of Apple's Swift book.
*/

class Bank
{
    static var coinsInBank = 10_000
	
    static func vendCoins(numberOfCoinsRequested: Int) -> Int
	{
        let numberOfCoinsToVend = min(numberOfCoinsRequested, coinsInBank)
        coinsInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }
	
    static func receiveCoins(coins: Int)
	{
        coinsInBank += coins
    }
}

class Player
{
    var coinsInPurse: Int
	
    init(coins: Int)
	{
        coinsInPurse = Bank.vendCoins(coins)
    }
	
    func winCoins(coins: Int)
	{
        coinsInPurse += Bank.vendCoins(coins)
    }
	
    deinit
	{
        Bank.receiveCoins(coinsInPurse)
    }
}

var playerOne: Player? = Player(coins: 100)
print("A new player has joined the game with \(playerOne?.coinsInPurse) coins")
print("There are now \(Bank.coinsInBank) coins left in the bank")
playerOne?.winCoins(2_000)
print("PlayerOne won 2000 coins & now has \(playerOne!.coinsInPurse) coins")
print("The bank now only has \(Bank.coinsInBank) coins left")
playerOne = nil
print("PlayerOne has left the game")
print("The bank now has \(Bank.coinsInBank) coins")