/*
Code generated while going through the 'Collection Types' chapter of Apple's Swift book.
*/

Array<Int>() == [Int]()

var shoppingList: [String] = [ "Eggs", "Milk" ]
shoppingList.append("Flour")
//shoppingList += "Baking Powder" // Looks like this was removed in Swift 2. Seems to have been a general move to clear up ambiguous uses of the + operator.
shoppingList += [ "Chocolate Spread", "Cheese", "Butter" ]
var firstItem = shoppingList[0]
shoppingList[0] = "Six eggs"
shoppingList[4...5] = [ "Bananas", "Apples" ] // Really cool!
shoppingList.insert("Maple Syrup", atIndex: 0)

for item in shoppingList
{
	print(item)
}

for (item, index) in shoppingList.enumerate()
{
	print(item, index)
}

[Int](count: 3, repeatedValue: 0) == Array<Int>(count: 3, repeatedValue: 0)

// Keys of a dictionary must adhere to the Hashable protocol

var airports = ["TYO": "Tokyo", "DUB": "Dublin"]
airports["LHR"] = "London"
airports["LHR"] = "London Heathrow"

if let oldValue = airports.updateValue("Dublin International", forKey: "DUB") // Very cool method.
{
	print("The old value for DUB was \(oldValue).")
}

airports["APL"] = "Apple International"
airports["APL"] = nil

for (airportCode, airportName) in airports
{
	print("\(airportCode): \(airportName)")
}

// Order of keys and values of a dictionary is still not guaranteed.

let alphabet = [ "A", "B", "C" ]
//alphabet[0] = "B" // Apple said this was possible but apparently it isn't which is obviously good.