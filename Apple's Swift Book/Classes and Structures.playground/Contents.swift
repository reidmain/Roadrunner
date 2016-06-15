/*
Code generated while going through the 'Classes and Structures' chapter of Apple's Swift book.
*/

struct Resolution
{
	var width = 0
	var height = 0
}
class VideoMode
{
	var resolution = Resolution()
	var interlaced = false
	var frameRate = 0.0
	var name: String?
}

let vga = Resolution(width: 640, height: 480)
vga.width.dynamicType

// This chapter is drilling into my brain that classes are passed by reference and structures and enumeratiosn are based by value.

let mode1 = VideoMode()
let mode2 = VideoMode()
mode1 === mode1
mode2 === mode2
mode1 === mode2

// String, Array and Dictionary are all structures so unlike Objective-C they are copied every time they are assigned to a new variable. Drill this into your brain because it is probably going to come back and bite you in the ass.