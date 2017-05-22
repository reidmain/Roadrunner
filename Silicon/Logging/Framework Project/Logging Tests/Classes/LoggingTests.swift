import XCTest

@testable import Logging

class LoggingTests : XCTestCase
{
	override func setUp()
	{
		super.setUp()
	}
	
	override func tearDown()
	{
		super.tearDown()
	}
	
	func testExample()
	{
		Logger().hello()
	}
	
	func testPerformanceExample()
	{
		self.measure
		{
			Logger().hello()
		}
	}
}
