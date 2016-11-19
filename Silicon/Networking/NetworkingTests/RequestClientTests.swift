import XCTest
@testable import Networking

class RequestClientTests: XCTestCase
{
    func testLoad_withHTTPGetRequest()
	{
		let requestClient = RequestClient(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
		
		let request = NSURLRequest(URL: NSURL(string: "https://api.twitch.tv/kraken")!)
		
		let expectation = self.expectationWithDescription("Received response")
		
		requestClient.load(request) { (response) in
			XCTAssertNotNil(response)
			
			expectation.fulfill()
		}
		
		self.waitForExpectationsWithTimeout(1, handler: nil)
    }
	
	func testLoad_withHTTPStreamRequest()
	{
		let requestClient = RequestClient(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
		
		let request = NSURLRequest(URL: NSURL(string: "http://localhost:4567")!)
		
		let expectation = self.expectationWithDescription("Received response")
		
		requestClient.load(request) { (response) in
			XCTAssertNotNil(response)
			
			expectation.fulfill()
		}
		
		self.waitForExpectationsWithTimeout(60, handler: nil)
    }
	
	func testThreadSafety
	{
		dispatch_apply(1000, dispatch_queue_t!, <#T##block: (Int) -> Void##(Int) -> Void#>)	}
}
