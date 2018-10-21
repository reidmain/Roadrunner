import XCTest

@testable import Keychain

class KeychainAccessibilityTests : XCTestCase
{
	// MARK: - Tests

	func test_rawValuesAreCorrectlySet()
	{
		XCTAssertEqual(
			KeychainAccessibility.afterFirstUnlock.rawValue,
			kSecAttrAccessibleAfterFirstUnlock)

		XCTAssertEqual(
			KeychainAccessibility.whenUnlocked.rawValue,
			kSecAttrAccessibleWhenUnlocked)
	}
}
