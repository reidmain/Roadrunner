import Foundation

public class RequestClient : NSObject, NSURLSessionDelegate
{
	// MARK: - Properties
	
	private var urlSession: NSURLSession!
	private var tasks: Dictionary<Int, RequestClientTask>
	
	// MARK: - Initializers
	
	public init(configuration: NSURLSessionConfiguration)
	{
		tasks = Dictionary<Int, RequestClientTask>()
		
		super.init()
		
		urlSession = NSURLSession(configuration: configuration, delegate: self, delegateQueue: nil)
	}
	
	// MARK: - Public Methods
	
	public func load(request: NSURLRequest, completionClosure: RequestClientTask.CompletionClosure)
	{
		let dataTask = urlSession.dataTaskWithRequest(request)
		
		let requestClientTask = RequestClientTask(dataTask: dataTask, completionClosure: completionClosure)
		tasks[dataTask.taskIdentifier] = requestClientTask
		
		[dataTask .resume()]
	}
	
	// MARK: - NSURLSessionDelegate Methods
	
	public func URLSession(session: NSURLSession, 
		didBecomeInvalidWithError error: NSError?)
	{
		print("NSURLSession became invalid \(error). I really should think of some way to handle this and gracefully fail.")
	}
	
	public func URLSession(session: NSURLSession, 
		didReceiveChallenge challenge: NSURLAuthenticationChallenge, 
		completionHandler: (NSURLSessionAuthChallengeDisposition, NSURLCredential?) -> Void)
	{
		print("Received challenge.")
		completionHandler(.PerformDefaultHandling, nil)
	}
	
	// MARK: - NSURLSessionTaskDelegate Methods
	
	func URLSession(session: NSURLSession, 
		task: NSURLSessionTask, 
		willPerformHTTPRedirection response: NSHTTPURLResponse, 
		newRequest request: NSURLRequest, 
		completionHandler: (NSURLRequest?) -> Void)
	{
	}
	
	func URLSession(session: NSURLSession, 
		task: NSURLSessionTask, 
		didReceiveChallenge challenge: NSURLAuthenticationChallenge, 
		completionHandler: (NSURLSessionAuthChallengeDisposition, NSURLCredential?) -> Void)
	{
	}
	
	func URLSession(session: NSURLSession, 
		task: NSURLSessionTask, 
		needNewBodyStream completionHandler: (NSInputStream?) -> Void)
	{
	}
	
	func URLSession(session: NSURLSession, 
		task: NSURLSessionTask, 
		didSendBodyData bytesSent: Int64, 
		totalBytesSent: Int64, 
		totalBytesExpectedToSend: Int64)
	{
	}
	
	func URLSession(session: NSURLSession, 
		task: NSURLSessionTask, 
		didCompleteWithError error: NSError?)
	{
		let requestClientTask = tasks[task.taskIdentifier]
		requestClientTask?.complete(withError: error)
	}
	
	// MARK: - NSURLSessionDataDelegate Methods
	
	func URLSession(session: NSURLSession, 
		dataTask: NSURLSessionDataTask, 
		didReceiveResponse response: NSURLResponse, 
		completionHandler: (NSURLSessionResponseDisposition) -> Void)
	{
		completionHandler(.Allow)
	}
    
	func URLSession(session: NSURLSession, 
		dataTask: NSURLSessionDataTask, 
		didBecomeDownloadTask downloadTask: NSURLSessionDownloadTask)
	{
	}
    
	func URLSession(session: NSURLSession, 
		dataTask: NSURLSessionDataTask, 
		didBecomeStreamTask streamTask: NSURLSessionStreamTask)
	{
	}
    
	func URLSession(session: NSURLSession, 
		dataTask: NSURLSessionDataTask, 
		didReceiveData data: NSData)
	{
		let requestClientTask = tasks[dataTask.taskIdentifier]
		requestClientTask?.receiveData(data)
	}
	
//	func URLSession(session: NSURLSession, 
//		dataTask: NSURLSessionDataTask, 
//		willCacheResponse proposedResponse: NSCachedURLResponse, 
//		completionHandler: (NSCachedURLResponse?) -> Void)
//	{
//	}
}