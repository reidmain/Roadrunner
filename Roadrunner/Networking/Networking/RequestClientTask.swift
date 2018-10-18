import Foundation

public class RequestClientTask
{
	public typealias CompletionClosure = (response: NSURLResponse?) -> Void
	
	// MARK: - Properties
	
	let dataTask: NSURLSessionDataTask
	let completionClosure: CompletionClosure
	let data: NSMutableData
	
	// MARK: - Initializers
	
	init(dataTask: NSURLSessionDataTask, completionClosure: CompletionClosure)
	{
		self.dataTask = dataTask
		self.completionClosure = completionClosure
		self.data = NSMutableData()
	}
	
	// MARK: - Internal Methods
	
	func receiveData(data: NSData)
	{
		print("Recieved data")
		self.data.appendData(data)
	}
	
	func complete(withError error: NSError?)
	{
		let message = String(data: data, encoding: NSUTF8StringEncoding)
		print(message)
		self.completionClosure(response: dataTask.response)
	}
}