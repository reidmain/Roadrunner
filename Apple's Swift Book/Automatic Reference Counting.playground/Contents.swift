/*
Code generated while going through the 'Automatic Reference Counting' chapter of Apple's Swift book.
*/

class Person
{
	let name: String
	var apartment: Apartment?
	
	init(name: String)
	{
		self.name = name
		print("\(name) is being initialized")
	}
	
	deinit
	{
		print("\(name) is being deinitialized")
	}
}

class Apartment
{
	let unit: String
	weak var tenant: Person?
	
	init(unit: String)
	{
		self.unit = unit
	}
	
	deinit
	{
		print("Apartment \(unit) is being deinitialized")
	}
}

var reference1: Person?
var reference2: Person?
var reference3: Person?

reference1 = Person(name: "Reid")
reference2 = reference1
reference3 = reference1
reference1 = nil
reference2 = nil
reference3 = nil

var john: Person?
var unit4A: Apartment?

john = Person(name: "John Appleseed")
unit4A = Apartment(unit: "4A")
john?.apartment = unit4A
unit4A?.tenant = john

john = nil
unit4A = nil

class HTMLElement
{
	let name: String
	let text: String?
	
	lazy var asHTML: () -> String = {
		[unowned self] in
		if let text = self.text {
			return "<\(self.name)>\(text)</\(self.name)>"
		} else {
			return "<\(self.name) />"
		}
	}
	
	init(name: String, text: String? = nil)
	{
		self.name = name
		self.text = text
	}
	
	deinit
	{
		print("\(name) is being deinitialized")
	}
}

let heading = HTMLElement(name: "h1")
let defaultText = "some default text"
heading.asHTML = {
	return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
}
print(heading.asHTML())

var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(paragraph!.asHTML())
paragraph = nil