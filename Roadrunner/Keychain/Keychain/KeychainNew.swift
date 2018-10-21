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

internal struct KeychainLoadQuery
{
	// MARK: - Public Properties

	public let service: String
	public let key: String
	public let accessGroup: String?

	public var queryDictionary: [AnyHashable: Any]
	{
		var queryDictionary: [AnyHashable: Any] =
		[
			kSecClass: kSecClassGenericPassword,
			kSecAttrAccount: key,
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
}

internal struct KeychainAddQuery
{
	// MARK: - Public Properties

	public let item: Data
	public let service: String
	public let key: String
	public let accessGroup: String?
	public let accessibility: KeychainAccessibility

	public var queryDictionary: [AnyHashable: Any]
	{
		var queryDictionary: [AnyHashable: Any] =
		[
			kSecClass: kSecClassGenericPassword,
			kSecAttrAccount: key,
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

		queryDictionary[kSecValueData] = item
		queryDictionary[kSecAttrAccessible] = accessibility.rawValue

		return queryDictionary
	}
}

internal struct KeychainUpdateQuery
{
	// MARK: - Public Properties

	public let item: Data
	public let service: String
	public let key: String
	public let accessGroup: String?
	public let accessibility: KeychainAccessibility

	public var queryDictionary: [AnyHashable: Any]
	{
		var queryDictionary: [AnyHashable: Any] =
		[
			kSecClass: kSecClassGenericPassword,
			kSecAttrAccount: key,
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

	public var attributesToUpdate: [AnyHashable: Any]
	{
		let attributesToUpdate: [AnyHashable: Any] =
		[
			kSecValueData: item,
			kSecAttrAccessible: accessibility.rawValue
		]

		return attributesToUpdate
	}
}

internal struct KeychainDeleteQuery
{
	// MARK: - Public Properties

	public let service: String
	public let key: String
	public let accessGroup: String?

	public var queryDictionary: [AnyHashable: Any]
	{
		var queryDictionary: [AnyHashable: Any] =
		[
			kSecClass: kSecClassGenericPassword,
			kSecAttrAccount: key,
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
}

public struct Keychain
{
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
			let addResultCode = SecItemAdd(queryDictionary, nil)
			if addResultCode == errSecSuccess
			{
				return nil
			}
			else
			{
				return addResultCode
			}
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
			let updateResultCode = SecItemUpdate(queryDictionary, attributesToUpdate)
			if updateResultCode == errSecSuccess
			{
				return nil
			}
			else
			{
				return updateResultCode
			}
		}
		// Otherwise a genuine error occurred and we should bubble it up.
		else
		{
			return loadResultCode
		}
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
		let resultCode = SecItemDelete(queryDictionary)
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
		let resultCode = SecItemCopyMatching(queryDictionary, &result)

		return resultCode
	}
}
