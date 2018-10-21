import XCTest

@testable import Keychain

class KeychainTests : XCTestCase
{
	// MARK: - Tests

	func test_lookingForAnItemThatDoesNotExist()
	{
		let keychain = Keychain()
		let service = "com.1414degrees.keychain"
		let key = "key"

		let loadResult = keychain.loadData(
			service: service,
			key: key,
			accessGroup: nil)
		XCTAssertEqual(
			loadResult,
			errSecItemNotFound,
			"There should be no entry in the keychain for the given service, key pair.")
	}

	func test_addingNewItem()
	{
		let keychain = Keychain()
		let service = "com.1414degrees.keychain"
		let key = "key"
		let itemToSave = "test string".data(using: .utf8)!

		let saveResult = keychain.save(
			item: itemToSave,
			service: service,
			key: key,
			accessGroup: nil,
			accessibility: .whenUnlocked)
		XCTAssertNil(
			saveResult,
			"The item should have been successfully saved to the keychain.")

		// TODO: Load the item from the keychain and make sure it is the same thing.

		let deleteResult = keychain.delete(
			service: service,
			key: key,
			accessGroup: nil)
		XCTAssertEqual(
			deleteResult,
			errSecSuccess,
			"The item should have been successfully deleted from the keychain to prevent state from bleeding between tests.")
	}

	func test_updatingExistingItem()
	{
		let keychain = Keychain()
		let service = "com.1414degrees.keychain"
		let key = "key"
		let oldItem = "old item".data(using: .utf8)!
		let newItem = "new item".data(using: .utf8)!

		let oldSaveResult = keychain.save(
			item: oldItem,
			service: service,
			key: key,
			accessGroup: nil,
			accessibility: .whenUnlocked)
		XCTAssertNil(
			oldSaveResult,
			"The item should have been successfully saved to the keychain.")

		let newSaveResult = keychain.save(
			item: newItem,
			service: service,
			key: key,
			accessGroup: nil,
			accessibility: .whenUnlocked)
		XCTAssertNil(
			newSaveResult,
			"The item should have been successfully saved to the keychain.")

		// TODO: Load the item from the keychain and make sure it is the correct one.

		let deleteResult = keychain.delete(
			service: service,
			key: key,
			accessGroup: nil)
		XCTAssertEqual(
			deleteResult,
			errSecSuccess,
			"The item should have been successfully deleted from the keychain to prevent state from bleeding between tests.")
	}

	// TODO: Implement this test.
	func disabled_test_errorOccursWhileAddingItem()
	{
	}

	// TODO: Implement this test.
	func disabled_test_errorOccursWhileUpdatingItem()
	{
	}

	// TODO: Implement this test.
	func disabled_test_errorOccursWhileCheckingForExistenceDuringAddingAnItem()
	{
	}
}
