import XCTest

@testable import Keychain

class KeychainTests: XCTestCase
{
	func testSaving_withAdd()
	{
		let key = "key";
		let service = "KeychainTests";
		
		do
		{
			let itemInKeychain: String = try Keychain.load(key, service: service)
			XCTAssertNil(itemInKeychain, "No item should exist in the keychain at the start of the test.");
		}
		catch Keychain.KeychainError.resultCode(let resultCode)
		{
			XCTAssertEqual(resultCode, errSecItemNotFound, "An item not found error should be thrown because an item should not exist in the keychain at the start of the test.")
		}
		catch let error
		{
			XCTAssertNil(error)
		}
		
		do
		{
			let itemToSave: NSString = "Reid";
			try Keychain.save(itemToSave, key: key, service: service)
			
			let itemInKeychain: NSString = try Keychain.load(key, service: service)
			XCTAssertEqual(itemToSave, itemInKeychain);
			
			try Keychain.delete(key, service: service)
		}
		catch let error
		{
			XCTAssertNil(error)
		}
	}
}
