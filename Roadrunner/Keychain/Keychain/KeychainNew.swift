import Foundation
import Security

public enum KeychainAccessibility
{
	case afterFirstUnlock
	case whenUnlocked

	internal var rawValue: CFString
	{
		switch self
		{
			case .afterFirstUnlock:
				return kSecAttrAccessibleAfterFirstUnlock

			case .whenUnlocked:
				return kSecAttrAccessibleWhenUnlocked
		}
	}
}

internal class BaseKeychainQuery
{
	// MARK: - Public Properties

	private let itemClass = kSecClassGenericPassword
	public let service: String
	public let accessGroup: String?

	public var queryDictionary: [AnyHashable: Any]
	{
		var queryDictionary: [AnyHashable: Any] =
		[
			kSecClass: itemClass,
			kSecAttrService: service
		]

		#if TARGET_IPHONE_SIMULATOR
		// Note: If this code is running in the Simulator the access group cannot be set. Apps running in the Simulator are not signed so there is no access group for them to check. Apps running in the Simulator treat all keychain items as being part of the same access group. If you need to test apps that use access groups you will need to install the apps on a device.
		#else
		if let accessGroup = accessGroup
		{
			queryDictionary[kSecAttrAccessGroup] = accessGroup
		}
		#endif

		return queryDictionary
	}

	// MARK: - Initializers

	public init(
		service: String,
		accessGroup: String?)
	{
		self.service = service
		self.accessGroup = accessGroup
	}
}

internal final class KeychainLoadQuery : BaseKeychainQuery
{
	// MARK: - Public Properties

	public let key: String

	override public var queryDictionary: [AnyHashable: Any]
	{
		var queryDictionary = super.queryDictionary
		queryDictionary[kSecAttrAccount] = key

		return queryDictionary
	}

	// MARK: - Initializers

	public init(
		service: String,
		key: String,
		accessGroup: String?)
	{
		self.key = key

		super.init(
			service: service,
			accessGroup: accessGroup)
	}
}

internal final class KeychainAddQuery : BaseKeychainQuery
{
	// MARK: - Public Properties

	public let item: Data
	public let key: String
	public let accessibility: KeychainAccessibility

	override public var queryDictionary: [AnyHashable: Any]
	{
		var queryDictionary = super.queryDictionary

		queryDictionary[kSecValueData] = item
		queryDictionary[kSecAttrAccount] = key
		queryDictionary[kSecAttrAccessible] = accessibility.rawValue

		return queryDictionary
	}

	// MARK: - Initializers

	public init(
		item: Data,
		service: String,
		key: String,
		accessGroup: String?,
		accessibility: KeychainAccessibility)
	{
		self.item = item
		self.key = key
		self.accessibility = accessibility

		super.init(
			service: service,
			accessGroup: accessGroup)
	}
}

internal final class KeychainUpdateQuery : BaseKeychainQuery
{
	// MARK: - Public Properties

	public let item: Data
	public let key: String
	public let accessibility: KeychainAccessibility

	override public var queryDictionary: [AnyHashable: Any]
	{
		var queryDictionary = super.queryDictionary
		queryDictionary[kSecAttrAccount] = key

		return queryDictionary
	}

	public var attributesToUpdate: [AnyHashable: Any]
	{
		let attributesToUpdate: [AnyHashable: Any] =
		[
			kSecValueData: item,
			kSecAttrAccessible: accessibility.rawValue
		]

		return attributesToUpdate
	}

	// MARK: - Initializers

	public init(
		item: Data,
		service: String,
		key: String,
		accessGroup: String?,
		accessibility: KeychainAccessibility)
	{
		self.item = item
		self.key = key
		self.accessibility = accessibility

		super.init(
			service: service,
			accessGroup: accessGroup)
	}
}

internal final class KeychainDeleteQuery : BaseKeychainQuery
{
	// MARK: - Public Properties

	public let key: String

	override public var queryDictionary: [AnyHashable: Any]
	{
		var queryDictionary = super.queryDictionary
		queryDictionary[kSecAttrAccount] = key

		return queryDictionary
	}

	// MARK: - Initializers

	public init(
		service: String,
		key: String,
		accessGroup: String?)
	{
		self.key = key

		super.init(
			service: service,
			accessGroup: accessGroup)
	}
}

public struct Keychain
{
	// MARK: - Properties

	private let keychainService: KeychainServicing

	// MARK: - Initializers

	public init()
	{
		self.init(keychainService: KeychainService())
	}

	internal init(keychainService: KeychainServicing)
	{
		self.keychainService = keychainService
	}

	// MARK: - Public Methods

	public func save(
		item: Data,
		service: String,
		key: String,
		accessGroup: String?,
		accessibility: KeychainAccessibility)
			-> OSStatus?
	{
		let loadResultCode = loadData(
			service: service,
			key: key,
			accessGroup: accessGroup)

		// If the item does not exist then we are sure it can be safely added to the keychain.
		if loadResultCode == errSecItemNotFound
		{
			let addQuery = KeychainAddQuery(
				item: item,
				service: service,
				key: key,
				accessGroup: accessGroup,
				accessibility: accessibility)

			let queryDictionary = addQuery.queryDictionary as CFDictionary
			let addResultCode = keychainService.SecItemAdd(queryDictionary, nil)
			return addResultCode
		}
		// If the item already exists in the keychain we must update it instead of adding.
		else if loadResultCode == errSecSuccess
		{
			let updateQuery = KeychainUpdateQuery(
				item: item,
				service: service,
				key: key,
				accessGroup: accessGroup,
				accessibility: accessibility)

			let queryDictionary = updateQuery.queryDictionary as CFDictionary
			let attributesToUpdate = updateQuery.attributesToUpdate as CFDictionary
			let updateResultCode = keychainService.SecItemUpdate(queryDictionary, attributesToUpdate)
			return updateResultCode
		}

		// Otherwise a genuine error occurred and we should bubble it up.
		return loadResultCode
	}

	public func delete(
		service: String,
		key: String,
		accessGroup: String?)
			-> OSStatus
	{
		let deleteQuery = KeychainDeleteQuery(
			service: service,
			key: key,
			accessGroup: accessGroup)

		let queryDictionary = deleteQuery.queryDictionary as CFDictionary
		let resultCode = keychainService.SecItemDelete(queryDictionary)
		return resultCode
	}

	// MARK: - Internal Methods

	internal func loadData(
		service: String,
		key: String,
		accessGroup: String?)
			-> OSStatus
	{
		let loadQuery = KeychainLoadQuery(
			service: service,
			key: key,
			accessGroup: accessGroup)

		let queryDictionary = loadQuery.queryDictionary as CFDictionary
		var result: AnyObject?
		let resultCode = keychainService.SecItemCopyMatching(queryDictionary, &result)

		return resultCode
	}
}
