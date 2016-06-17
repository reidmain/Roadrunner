/*
Code generated while going through the 'Optional Chaining' chapter of Apple's Swift book.
*/

class Person
{
	var residence: Residence?
}

class Residence
{
	var address: Address?
	var rooms = [Room]()
	var numberOfRooms: Int
	{
		return rooms.count
	}
	
	subscript(i: Int) -> Room
	{
		get
		{
			return rooms[i]
		}
		set
		{
			rooms[i] = newValue
		}
	}
	
	func printNumberOfRooms()
	{
		print("The number of rooms is \(numberOfRooms)")
	}
}

class Room
{
	let name: String
	
	init(name: String)
	{
		self.name = name
	}
}

class Address
{
	var buildingName: String?
	var buildingNumber: String?
	var street: String?
	
	func buildingIdentifier() -> String?
	{
		if buildingName != nil
		{
			return buildingName
		}
		else if buildingNumber != nil && street != nil
		{
			return "\(buildingNumber) \(street)"
		}
		else
		{
			return nil
		}
	}
}

func createAddress() -> Address
{
	print("Function was called.")
	
	let someAddress = Address()
	someAddress.buildingNumber = "29"
	someAddress.street = "Acacia Road"
	
	return someAddress
}

let john = Person()
if let roomCount = john.residence?.numberOfRooms
{
	print("John's residence has \(roomCount) room(s).")
}
else
{
	print("Unable to retrieve the number of rooms.")
}

let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
john.residence?.address = someAddress
john.residence?.address = createAddress()

if john.residence?.printNumberOfRooms() != nil
{
	print("It was possible to print the number of rooms.")
}
else
{
	print("It was not possible to print the number of rooms.")
}

if let firstRoomName = john.residence?[0].name
{
	print("The first room name is \(firstRoomName).")
}
else
{
	print("Unable to retrieve the first room name.")
}

john.residence?[0] = Room(name: "Bathroom")

let johnsHouse = Residence()
johnsHouse.rooms.append(Room(name: "Living Room"))
johnsHouse.rooms.append(Room(name: "Kitchen"))
john.residence = johnsHouse

if let firstRoomName = john.residence?[0].name
{
	print("The first room name is \(firstRoomName).")
}
else
{
	print("Unable to retrieve the first room name.")
}

let johnsAddress = Address()
johnsAddress.buildingName = "The Larches"
johnsAddress.street = "Laurel Street"
john.residence?.address = johnsAddress
 
if let johnsStreet = john.residence?.address?.street
{
	print("John's street name is \(johnsStreet).")
}
else
{
	print("Unable to retrieve the address.")
}

if let buildingIdentifier = john.residence?.address?.buildingIdentifier()
{
	print("John's building identifier is \(buildingIdentifier).")
}

if let beginsWithThe = john.residence?.address?.buildingIdentifier()?.hasPrefix("The")
{
	if beginsWithThe
	{
		print("John's building identifier begins with \"The\".")
	}
	else
	{
		print("John's building identifier does not begin with \"The\".")
	}
}