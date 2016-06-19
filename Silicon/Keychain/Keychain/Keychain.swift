import Foundation
import Security

/**
Keychain is a structure that provides the ability to save, load and delete items from the keychain with a single method call.

Keychain is not designed to be instantiated because it does not maintain any state. Every method is static and acts directly on the keychain when it is called. There is no need to persist any state and minimize accessing the keychain because speed is very rarely a factor and, with the addition of things like the iCloud keychain, ensuring that your data is never stale can be a pain.

All items that are saved using the Keychain structure must adhere to the NSCoding protocol because they are serialized before they are saved to the keychain. This allows the storage of arbitrary objects in the keychain and removes the need for developers to handle the serialize/deserialize process themselves.

Keychain is not thread-safe. The save method is the only method where this is a factor because there is a two-step process of saving an item to the keychain. The keychain must be queried first to know if an add or a update operation should be performed. Obviously if two different threads attempt to modify the keychain inbetween this check and operation it could result in an error being thrown.
*/
public struct Keychain
{
	// MARK: - Enumerations
	
	// MARK: Accessibility
	
	public enum Accessibility : RawRepresentable
	{
		case AfterFirstUnlock
		case WhenUnlocked
		
		public init?(rawValue: CFString)
		{
			let rawValueAsString = String(rawValue)
			switch (rawValueAsString)
			{
				case String(kSecAttrAccessibleWhenUnlocked):
					self = .AfterFirstUnlock
				
				case String(kSecAttrAccessibleAfterFirstUnlock):
					self = .WhenUnlocked
				
				default:
					self = .AfterFirstUnlock
			}
		}
		
		public var rawValue: CFString
		{
			switch self
			{
				case .AfterFirstUnlock:
					return kSecAttrAccessibleAfterFirstUnlock
				
				case .WhenUnlocked:
					return kSecAttrAccessibleWhenUnlocked
			}
		}
	}
	
	// MARK: Error
	
	public enum Error : ErrorType
	{
		case ResultCode(resultCode: OSStatus)
		case IncorrectType
		case ItemNotFound
		case NothingToDelete
		case Internal
		
		// I need to figure out where to encapsulate this information. There needs to be a way to get this for .ResultCode errors because something they are so crytpic and hard to figure out.
//		func message() -> String
//		{
//			switch (resultCode)
//			{
//				case errSecDuplicateItem:
//					self.message = "Item with key '\(key)' for service '\(service)' already exists in the keychain."
//				
//				case errSecItemNotFound:
//					self.message = "Item with key '\(key)' for service '\(service)' could not be found in the keychain."
//				
//				case errSecInteractionNotAllowed:
//					self.message = "Interaction with key '\(key)' for service '\(service)' was not allowed. It is possible that the item is only accessible when the device is unlocked and this query is happening when the app is in the background. Double-check your item permissions."
//
//				default:
//					self.message = "This is a undefined error. Check SecBase.h or Apple's iOS Developer Library for more information on this Keychain Services error code.";
//			}
//		}
	}
	
	// MARK: - Public Methods
	
	/**
	Serializes the item and saves it to the keychain under the specified key, service, access group and accessibility level.
	
	Can be used to both add items to the keychain and update existing items.
	
	- parameters:
		- item: The item to be saved to the keychain. The item must adhere to the NSCoding protocol because it will be serialized before it is stored in the keychain.
		- key: The key that the item will be associated with.
		- service: The service that the item will be associated with. A good example of this parameter is the name of the application using the keychain.
		- accessGroup: The access group that the item will be saved to in the keychain. If this parameter is nil the first access group in the application entitlements file is used by default.
		- accessibility: The accessibility level of the item. Defaults to .AfterFirstUnlock. If the item already exists in the keychain its accessibility will be updated as well.

	- throws: .ResultCode if an error occurs while deleting from the keychain.
		Could throw an inner error if something goes wrong while checking the existance of an item in the keychain before saving. I am thinking that I should capture this scenario and raise a unique error case.
	*/
	public static func save(item: NSCoding, 
		key: String, 
		service: String, 
		accessGroup: String? = nil, 
		accessibility: Accessibility = .AfterFirstUnlock) 
			throws
	{
		do
		{
			try Keychain.loadData(key, service: service, accessGroup: accessGroup)
			
			let valueData = NSKeyedArchiver.archivedDataWithRootObject(item)
			
			let queryDictionary = self.baseQueryDictionary(key, service: service, accessGroup: accessGroup)
			
			var attributesToUpdate = Dictionary<String, AnyObject>()
			attributesToUpdate[kSecValueData as String] = valueData
			attributesToUpdate[kSecAttrAccessible as String] = accessibility.rawValue
			
			let resultCode = SecItemUpdate(queryDictionary, attributesToUpdate)
			if resultCode != errSecSuccess
			{
				let error = Error.ResultCode(resultCode: resultCode)
				throw error
			}
		}
		catch Error.ResultCode(resultCode: errSecItemNotFound)
		{
			let valueData = NSKeyedArchiver.archivedDataWithRootObject(item)
			
			var query = self.baseQueryDictionary(key, service: service, accessGroup: accessGroup)
			
			query[kSecValueData as String] = valueData
			query[kSecAttrAccessible as String] = accessibility.rawValue
			
			let resultCode = SecItemAdd(query, nil)
			if resultCode != errSecSuccess
			{
				let error = Error.ResultCode(resultCode: resultCode)
				throw error
			}
		}
	}
	
	/**
	Loads the item from the keychain that matches the specified key, service and access group.
	
	- parameters:
		- key: The key that the item is associated with.
		- service: The service that the item is associated with.
		- accessGroup: The access group that the item is saved to in the keychain. If this parameter is nil the first access group in the application entitlements file is used by default.
	
	- throws: Could throw an inner error if something goes wrong while loading the raw data from the keychain. I am thinking that I maybe should capture this scenario and raise a unique error case.
		Could also throw an inner error by NSKeyedArchiver which is another thing I should probably handle and encapsulate.
		.IncorrectType if the type specified is not the same as what is returned from the keychain.
	*/
	public static func load<T>(key: String, 
		service: String, 
		accessGroup: String? = nil) 
			throws -> T
	{
		let data = try Keychain.loadData(key, service: service, accessGroup: accessGroup)
		
		let unarchivedItem = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) // TODO: Handle this throw and encapsulate it. 
		if let castedItem = unarchivedItem as? T
		{
			return castedItem
		}
		else
		{
			let error = Error.IncorrectType
			throw error
		}
	}
	
	/**
	Delete the item from the keychain for the specified key, service and access group.
	
	- parameters:
		- key: The key that the item to be deleted is associated with.
		- service: The service that the item to be deleted is associated with.
		- accessGroup: The access group that the item is saved to in the keychain. If this parameter is nil the first access group in the application entitlements file is used by default.

	- throws: .ResultCode if an error occurs while deleting from the keychain.
		.NothingToDelete if the delete failed because there was nothing to delete.
	*/
	public static func delete(key: String, 
		service: String, 
		accessGroup: String? = nil)
			throws
	{
		let queryDictionary = self.baseQueryDictionary(key, service: service, accessGroup: accessGroup)
		
		let resultCode = SecItemDelete(queryDictionary)
		if resultCode != errSecSuccess
		{
			// If the delete failed bacause the item did not exist in the keychain throw a more descriptive error.
			if resultCode == errSecItemNotFound
			{
//				let error = Error(resultCode: resultCode, message: "Could not delete item with key '\(key)' for service '\(service)' from the keychain because it does not exist.")
				let error = Error.NothingToDelete
				throw error
			}
			else
			{
				let error = Error.ResultCode(resultCode: resultCode)
				throw error
			}
		}
	}
	
	/**
	Loads the raw data from the keychain for the specified key, service and access group.
	
	- parameters:
		- key: The key that the data is associated with.
		- service: The service that the data is associated with.
		- accessGroup: The access group that the item is saved to in the keychain. If this parameter is nil the first access group in the application entitlements file is used by default.
	
	- throws: .ResultCode if an error occurs while querying the keychain.
		.Invalid if the query was successful but what was queried was not in the expected format. This is a critical error that should not be physically possible in practice.
		.ItemNotFound if the query was successful but no data was stored. This is a critical error that should not be physically possible in practice.
	*/
	public static func loadData(key: String, 
		service: String, 
		accessGroup: String? = nil) 
			throws -> NSData
	{
		var queryDictionary = self.baseQueryDictionary(key, service: service, accessGroup: accessGroup)
		queryDictionary[kSecMatchLimit as String] = kSecMatchLimitOne
		queryDictionary[kSecReturnAttributes as String] = kCFBooleanTrue
		queryDictionary[kSecReturnData as String] = kCFBooleanTrue
		
		var queryResult: AnyObject? = nil
		let resultCode = SecItemCopyMatching(queryDictionary, &queryResult)
		if resultCode != errSecSuccess
		{
			let error = Error.ResultCode(resultCode: resultCode)
			throw error
		}
		else
		{
			if let itemAttributesAndData = queryResult as? Dictionary<String, AnyObject>
			{
				if let data = itemAttributesAndData[kSecValueData as String] as? NSData
				{
					return data
				}
				else
				{
					let error = Error.ItemNotFound
					throw error
				}
			}
			else
			{
				let error = Error.Internal
				throw error
			}
		}
	}
	
	// MARK: - Private Methods
	
	/**
	Generates a dictionary that will be the basis for all queries made using SecItem* methods.
	
	- parameters:
		- key: The key that that is being queried.
		- service: The service that is being queried.
		- accessGroup: The access group that is being queried. If this parameter is nil the first access group in the application entitlements file is used by default.
	
	- warning: If this is used on the Simulator the access group is completely ignored. Since apps on the simulator are not signed they have no concept of access groups and therefore any query to the keychain uses the same "default" access group.
	*/
	private static func baseQueryDictionary(key: String, 
		service: String, 
		accessGroup optionalAccessGroup: String? = nil) 
			-> Dictionary<String, AnyObject>
	{
		var baseQueryDictionary = Dictionary<String, AnyObject>()
		
		baseQueryDictionary[kSecClass as String] = kSecClassGenericPassword
		baseQueryDictionary[kSecAttrAccount as String] = key
		baseQueryDictionary[kSecAttrService as String] = service
		
#if TARGET_IPHONE_SIMULATOR
		// Note: If this code is running in the Simulator the access group cannot be set. Apps running in the Simulator are not signed so there is no access group for them to check. Apps running in the Simulator treat all keychain items as being part of the same access group. If you need to test apps that use access groups you will need to install the apps on a device.
#else
		if let accessGroup = optionalAccessGroup
		{
			baseQueryDictionary[kSecAttrAccessGroup as String] = accessGroup
		}
#endif
		
		return baseQueryDictionary
	}
}
