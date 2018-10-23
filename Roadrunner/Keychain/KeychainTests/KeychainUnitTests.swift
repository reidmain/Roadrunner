import XCTest

@testable import Keychain

class KeychainUnitTests : XCTestCase
{
	// MARK: - Tests

	func test_errorOccursWhileCheckingForExistenceDuringAddingAnItem()
	{
		let mockKeychainService = MockKeychainService(
			loadHandler: { (query, result) in
				return errSecAuthFailed
			},
			addHandler: { (query, result) in
				return errSecUnimplemented
			},
			updateHandler: { (query, result) in
				return errSecUnimplemented
			},
			deleteHandler: { (query) in
				return errSecUnimplemented
			})

		let keychain = Keychain(keychainService: mockKeychainService)
		let service = "💣"
		let key = "key"
		let itemToSave = "test string".data(using: .utf8)!

		let saveResult = keychain.save(
			item: itemToSave,
			service: service,
			key: key,
			accessGroup: nil,
			accessibility: .afterFirstUnlock)
		XCTAssertEqual(
			saveResult,
			errSecAuthFailed,
			"The item should not have been saved to the keychain.")
	}
}

private struct MockKeychainService : KeychainServicing
{
	// MARK: - Type Aliases

	typealias LoadHandler = (_ query: CFDictionary, _ result: UnsafeMutablePointer<CFTypeRef?>?) -> OSStatus
	typealias AddHandler = (_ attributes: CFDictionary, _ result: UnsafeMutablePointer<CFTypeRef?>?) -> OSStatus
	typealias UpdateHandler = (_ query: CFDictionary, _ attributesToUpdate: CFDictionary) -> OSStatus
	typealias DeleteHandler = (_ query: CFDictionary) -> OSStatus

	// MARK: - Properties

	private let loadHandler: LoadHandler
	private let addHandler: AddHandler
	private let updateHandler: UpdateHandler
	private let deleteHandler: DeleteHandler

	// MARK: - Initializers

	public init(
		loadHandler: @escaping LoadHandler,
		addHandler: @escaping AddHandler,
		updateHandler: @escaping UpdateHandler,
		deleteHandler: @escaping DeleteHandler)
	{
		self.loadHandler = loadHandler
		self.addHandler = addHandler
		self.updateHandler = updateHandler
		self.deleteHandler = deleteHandler
	}

	// MARK: - KeychainServicing Methods

	func SecItemCopyMatching(_ query: CFDictionary, _ result: UnsafeMutablePointer<CFTypeRef?>?) -> OSStatus
	{
		return loadHandler(query, result)
	}

	func SecItemAdd(_ attributes: CFDictionary, _ result: UnsafeMutablePointer<CFTypeRef?>?) -> OSStatus
	{
		return addHandler(attributes, result)
	}

	func SecItemUpdate(_ query: CFDictionary, _ attributesToUpdate: CFDictionary) -> OSStatus
	{
		return updateHandler(query, attributesToUpdate)
	}

	func SecItemDelete(_ query: CFDictionary) -> OSStatus
	{
		return deleteHandler(query)
	}
}
