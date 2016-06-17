import XCTest

@testable import Keychain

class KeychainTests: XCTestCase
{
    func testSaving()
	{
		let key = "key";
		let service = "KeychainTests";
		let itemInKeychain = "Reid";
		
		var item: String? = Keychain.retrieve(key, service: service)
		
		XCTAssertNil(item, "No item should exist in the keychain yet.");
//		XCTAssertNotNil(error, "An error should occur because there is no item in the keychain.");
//		XCTAssertEqualObjects(error.domain, FDKeychainErrorDomain);
//		XCTAssertEqual(error.code, errSecItemNotFound);
		
		let saveSuccessful = Keychain.save(itemInKeychain, key: key, service: service)
		
		XCTAssertTrue(saveSuccessful, "The item should have been successfully saved to the keychain.");
//		XCTAssertNil(error, "No error should occur while saving the item to the keychain.");
		
		item = Keychain.retrieve(key, service: service)
		
		XCTAssertNotNil(item, "An item should exist in the keychain.");
		XCTAssertEqual(item, itemInKeychain);
//		XCTAssertNil(error, @"No error should occur because there is a valid item in the keychain.");
		
		let deleteSuccessful = Keychain.delete(key, service: service)
		
		XCTAssertTrue(deleteSuccessful, "The item should have been successfully deleted from the keychain.");
//		XCTAssertNil(error, @"No error should occur while deleting the item to the keychain.");
    }
}