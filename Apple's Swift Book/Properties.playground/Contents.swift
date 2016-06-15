/*
Code generated while going through the 'Classes and Structures' chapter of Apple's Swift book.
*/

class TestClass
{
	var someProperty = 0
}

let a = TestClass()
a.someProperty = 666 // I can still modify this property even thought the variable is constant because it is a class.

struct TestStruct
{
	var someProperty = 0
}

let b = TestStruct()
//b.someProperty = 666 // This don't work.

class StepCounter
{
	var totalSteps: Int = 0
		{
		willSet(newTotalSteps)
		{
			print("About to set totalSteps to \(newTotalSteps)")
		}
		
		didSet
		{
			print("Checking if steps should be added")
			if totalSteps > oldValue
			{
				print("Added \(totalSteps - oldValue) steps")
			}
		}
	}
}
let stepCounter = StepCounter()
stepCounter.totalSteps = 200
stepCounter.totalSteps = 360
stepCounter.totalSteps = 896
stepCounter.totalSteps = 896

func randomThing(inout steps: Int)
{
	print("Doing some random things with these steps.")
	steps =  6666
}
print("About to do some random things.")
randomThing(&stepCounter.totalSteps)

struct SomeStructure
{
	static var storedTypeProperty = "Some value."
	static var computedTypeProperty: Int
	{
		return 1
	}
}
enum SomeEnumeration
{
	static var storedTypeProperty = "Some value."
	static var computedTypeProperty: Int
	{
		return 6
	}
}
class SomeClass
{
	static var storedTypeProperty = "Some value."
	static var computedTypeProperty: Int
	{
		set
		{
			print(newValue)
		}
		get
		{
			return 27
		}
	}
	
	class var overrideableComputedTypeProperty: Int // Note that for a class you don't have to use 'static' instead you can use 'class' so that it can be overridden.
	{
		return 107
	}
}
SomeClass.computedTypeProperty = 666

struct AudioChannel
{
	static let thresholdLevel = 10
	static var maxInputLevelForAllChannels = 0
	var currentLevel: Int = 0
	{
		didSet
		{
			if currentLevel > AudioChannel.thresholdLevel
			{
				// cap the new audio level to the threshold level
				currentLevel = AudioChannel.thresholdLevel // Note that didSet is not called again.
			}
			if currentLevel > AudioChannel.maxInputLevelForAllChannels
			{
				// store this as the new overall maximum input level
				AudioChannel.maxInputLevelForAllChannels = currentLevel
			}
		}
	}
}

var leftChannel = AudioChannel()
var rightChannel = AudioChannel()
leftChannel.currentLevel = 7
AudioChannel.maxInputLevelForAllChannels
rightChannel.currentLevel = 11
AudioChannel.maxInputLevelForAllChannels