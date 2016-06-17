/*
Code generated while going through the 'Generics' chapter of Apple's Swift book.
*/

func swapTwoValues<T>(inout a: T, inout _ b: T)
{
	let temporaryA = a
	a = b
	b = temporaryA
}

var someInt = 3
var anotherInt = 107
swapTwoValues(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")

protocol Container
{
    associatedtype ItemType
	
	mutating func append(item: ItemType)
	var count: Int { get }
	subscript(i: Int) -> ItemType { get }
}

struct Stack<Element> : Container
{
	var items = [Element]()
	
	mutating func push(item: Element)
	{
		items.append(item)
	}
	
	mutating func pop() -> Element
	{
		return items.removeLast()
	}
	
	 // conformance to the Container protocol
	mutating func append(item: Element)
	{
		self.push(item)
	}
	
	var count: Int
	{
		return items.count
	}
	
	subscript(i: Int) -> Element
	{
		return items[i]
	}
}

var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")
let fromTheTop = stackOfStrings.pop()

extension Stack
{
	var topItem: Element?
	{
		return items.isEmpty ? nil : items[items.count - 1]
	}
}

if let topItem = stackOfStrings.topItem
{
	print("The top item on the stack is \(topItem).")
}

func findIndex<T: Equatable>(array: [T], _ valueToFind: T) -> Int?
{
	for (index, value) in array.enumerate()
	{
		if value == valueToFind
		{
			return index
		}
	}
	
	return nil
}

let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
if let foundIndex = findIndex(strings, "llama")
{
	print("The index of llama is \(foundIndex)")
}

let doubleIndex = findIndex([3.14159, 0.1, 0.25], 9.3)
let stringIndex = findIndex(["Mike", "Malcolm", "Andrea"], "Andrea")

func allItemsMatch<C1: Container, C2: Container where C1.ItemType == C2.ItemType, C1.ItemType: Equatable>
	(someContainer: C1, _ anotherContainer: C2) -> Bool
{    
	// check that both containers contain the same number of items
	if someContainer.count != anotherContainer.count
	{
		return false
	}
	
	// check each pair of items to see if they are equivalent
	for i in 0..<someContainer.count
	{
		if someContainer[i] != anotherContainer[i]
		{
			return false
		}
	}
	
	// all items match, so return true
	return true
}

extension Array: Container {}

stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")

var arrayOfStrings = ["uno", "dos", "tres"]

if allItemsMatch(stackOfStrings, arrayOfStrings)
{
	print("All items match.")
}
else
{
	print("Not all items match.")
}