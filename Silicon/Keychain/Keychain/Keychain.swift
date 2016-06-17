import Foundation

enum Accessibility
{
	case Everyone
}

public struct Keychain
{
	/**
	Attempts to retrieve the item from the keychain with the specified key, service and access group.
	
	- parameters:
		- key: The key that the item is associated with.
		- service: The service that the item is associated with. This is usually the name of the application using the keychain.
		- accessGroup: The access group that the item is saved to in the keychain. If this parameter is nil the first access group in the application entitlements file is used by default.
	
	- returns: The item if it exists in the keychain or nil if they item does not exist in the keychain. If nil is returned an error may have also occurred.
	*/
	public static func retrieve<T>(key: String, 
		service: String, 
		accessGroup: String? = nil) 
			-> T?
	{
		// TODO: Implement this method.
		return nil
	}
	
	/**
	Attempts to save the item to the keychain under the associated key, service and access group with the specified accessibility level.
	
	- parameters:
		- item: The item to be saved to the keychain. The item must adhere to the NSCoding protocol because it will be serialized before it is stored in the keychain. If the item is nil FDKeychain will attempt to delete the item from the keychain instead.
		- key: The key that the item will be associated with. This parameter must not be nil.
		- service: The service that the item will be associated with. This is usually the name of the application using the keychain. This parameter must not be nil.
		- accessGroup: The access group that the item will be saved to in the keychain. If this parameter is nil the first access group in the application entitlements file is used by default.
		- accessibility: The accessibility level of the item.

	- returns: YES if the item was saved successfully, NO if an error occurred.
	*/
	public static func save(item: AnyObject, 
		key: String, 
		service: String, 
		accessGroup: String? = nil, 
		accessibilityGroup: Int = 0) 
			-> Bool
	{
		// TODO: Implement this method.
		return false
	}
	
	/**
	Attempts to delete the item from the keychain with the specified key, service and access group.
	
	- parameters:
		- key: The key that the item is associated with. This parameter must not be nil.
		- service: The service that the item is associated with. This is usually the name of the application using the keychain. This parameter must not be nil.
		- accessGroup: The access group that the item is saved to in the keychain. If this parameter is nil the first access group in the application entitlements file is used by default.

	- returns: YES if the item was deleted successfully. NO if an error occurred.
	*/
	public static func delete(key: String, 
		service: String, 
		accessGroup: String? = nil) 
			-> Bool
	{
		// TODO: Implement this method.
		return false
	}
}
