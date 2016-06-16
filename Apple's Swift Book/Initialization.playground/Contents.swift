/*
Code generated while going through the 'Initialization' chapter of Apple's Swift book.
*/

struct Celsius
{
	var temperatureInCelsius: Double
	
	init(fromFahrenheit fahrenheit: Double)
	{
		temperatureInCelsius = (fahrenheit - 32.0) / 1.8
	}
	
	init(fromKelvin kelvin: Double)
	{
		temperatureInCelsius = kelvin - 273.15
	}
	
	init(_ celsius: Double) // Generally I would be against using '_' but actually in scenarios where the initializer only takes in a single parameter and the name of the class heavily implies what that parameter would be I think it actually works better.
	{
		temperatureInCelsius = celsius
	}
}
let bodyTemperature = Celsius(37.0)

struct Size
{
    var width = 0.0
	var height = 0.0
}
let twoByTwo = Size(width: 2.0, height: 2.0) // Implicit initializer.

struct Point
{
    var x = 0.0
	var y = 0.0
}

struct Rect
{
    var origin = Point()
    var size = Size()
	
    init()
	{
	}
	
    init(origin: Point, size: Size)
	{
        self.origin = origin
        self.size = size
    }
	
    init(center: Point, size: Size)
	{
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

let basicRect = Rect()
let originRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))
let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))

class Vehicle
{
	var numberOfWheels = 0
	var description: String
	{
		get
		{
			return "\(numberOfWheels) wheel(s)"
		}
	}
}

let vehicle = Vehicle()
print("Vehicle: \(vehicle.description)")

class Bicycle : Vehicle
{
	override init()
	{
		super.init()
		numberOfWheels = 2
	}
}

let bicycle = Bicycle()
print("Bicycle: \(bicycle.description)")

class Food
{
	var name: String
	
	init(name: String)
	{
		self.name = name
	}
	
	convenience init()
	{
		self.init(name: "[Unnamed]")
	}
}

let namedMeat = Food(name: "Bacon")
let mysteryMeat = Food()

class RecipeIngredient : Food
{
	var quantity: Int
	
	init(name: String, quantity: Int)
	{
		self.quantity = quantity
		
		super.init(name: name)
	}
	
	override convenience init(name: String)
	{
		self.init(name: name, quantity: 1)
	}
}

let oneMysteryItem = RecipeIngredient()
let oneBacon = RecipeIngredient(name: "Bacon")
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)

class ShoppingListItem : RecipeIngredient
{
	var purchased = false
	var description: String
	{
		get
		{
			var output = "\(quantity) x \(name)"
			output += purchased  ? " ✔" : " ✘"
			return output
		}
	}
}

var breakfastList = [
	ShoppingListItem(),
	ShoppingListItem(name: "Bacon"),
	ShoppingListItem(name: "Eggs", quantity: 6),
]
breakfastList[0].name = "Orange Juice"
breakfastList[0].purchased = true
for item in breakfastList
{
	print(item.description)
}

struct Chessboard
{
	let boardColors: [Bool] = {
		var temporaryBoard = [Bool]()
		var isBlack = false
		for i in 1...8
		{
			for j in 1...8
			{
				temporaryBoard.append(isBlack)
				isBlack = !isBlack
			}
			isBlack = !isBlack
		}
		return temporaryBoard
	}()
	
	func squareIsBlackAtRow(row: Int, column: Int) -> Bool
	{
		return boardColors[(row * 8) + column]
	}
}

let board = Chessboard()
print(board.squareIsBlackAtRow(0, column: 1))
print(board.squareIsBlackAtRow(7, column: 7))