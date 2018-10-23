import Foundation
import Security

internal protocol KeychainServicing
{
    func SecItemCopyMatching(_ query: CFDictionary, _ result: UnsafeMutablePointer<CFTypeRef?>?) -> OSStatus
    func SecItemAdd(_ attributes: CFDictionary, _ result: UnsafeMutablePointer<CFTypeRef?>?) -> OSStatus
    func SecItemUpdate(_ query: CFDictionary, _ attributesToUpdate: CFDictionary) -> OSStatus
    func SecItemDelete(_ query: CFDictionary) -> OSStatus
}

internal struct KeychainService : KeychainServicing
{
	func SecItemCopyMatching(_ query: CFDictionary, _ result: UnsafeMutablePointer<CFTypeRef?>?) -> OSStatus
	{
		return Security.SecItemCopyMatching(query, result)
	}

	func SecItemAdd(_ attributes: CFDictionary, _ result: UnsafeMutablePointer<CFTypeRef?>?) -> OSStatus
	{
		return Security.SecItemAdd(attributes, result)
	}

	func SecItemUpdate(_ query: CFDictionary, _ attributesToUpdate: CFDictionary) -> OSStatus
	{
		return Security.SecItemUpdate(query, attributesToUpdate)
	}

	func SecItemDelete(_ query: CFDictionary) -> OSStatus
	{
		return Security.SecItemDelete(query)
	}
}
