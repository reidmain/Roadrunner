/*
Code generated while going through the 'Methods' chapter of Apple's Swift book.
*/

class Counter
{
	var count = 0
	
	func increment()
	{
		count += 1
	}
	
	func incrementBy(amount amount: Int)
	{
		count += amount
	}
	
	func reset()
	{
		count = 0
	}
}

let a = Counter()
a.increment()
a.incrementBy(amount: 10)
a.count
a.reset()
a.incrementBy(amount: 5)
a.count

struct Point
{
	var x = 0.0
	var y = 0.0
	
	mutating func moveByX(deltaX: Double, y deltaY: Double)
	{
		x += deltaX
		y += deltaY
	}
}

var somePoint = Point(x: 1.0, y: 1.0)
somePoint.moveByX(2.0, y: 3.0)
print("The point is now at (\(somePoint.x), \(somePoint.y))")

enum TriStateSwitch
{
	case Off
	case Low
	case High
	
	mutating func next()
	{
		switch self
		{
			case Off:
				self = Low
			case Low:
				self = High
			case High:
				self = Off
		}
	}
}

var ovenLight = TriStateSwitch.Low
ovenLight.next()
ovenLight.next()