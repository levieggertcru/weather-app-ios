//
//  URLSessionNetworkRequester.swift
//  WeatherApp
//
//  Created by Levi Eggert on 4/25/24.
//

import Foundation
import shared
import RequestOperation

class URLSessionNetworkRequester: NetworkRequesterInterface {
    
    private let ignoreCacheSession: URLSession = URLSessionNetworkRequester.getNewIgnoreCacheSession(timeout: 60)
    private let requestBuilder: RequestBuilder = RequestBuilder()
    
    init() {
        
    }
    
    private static func getNewIgnoreCacheSession(timeout: TimeInterval) -> URLSession {
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.requestCachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        configuration.urlCache = nil
        
        configuration.httpCookieAcceptPolicy = HTTPCookie.AcceptPolicy.never
        configuration.httpShouldSetCookies = false
        configuration.httpCookieStorage = nil
        
        configuration.timeoutIntervalForRequest = timeout
     
        return URLSession(configuration: configuration)
    }
    
    func sendGetRequest(url: String, completion: @escaping (_ jsonObjects: [[String : Any]]) -> Void) -> CancellableInterface {
        
        let urlRequest: URLRequest = requestBuilder.build(
            session: ignoreCacheSession,
            urlString: url,
            method: .get,
            headers: nil,
            httpBody: nil,
            queryItems: nil
        )
        
        let requestOperation = RequestOperation(session: ignoreCacheSession, urlRequest: urlRequest)
        
        requestOperation.setCompletionHandler { [weak self] (response: RequestResponse) in
            
            let jsonObjectResult: Result<Any?, Error>? = self?.getJsonObject(data: response.data)
            
            var jsonObjects: [[String: Any]] = Array()
            
            if let jsonObjectResult = jsonObjectResult {
                
                switch jsonObjectResult {
                case .success(let anyObject):
                    
                    if let object = anyObject as? [String: Any] {
                        jsonObjects.append(object)
                    }
                    else if let objects = anyObject as? [[String: Any]] {
                        jsonObjects.append(contentsOf: objects)
                    }
                    
                case .failure( _):
                    break
                }
            }
            
            completion(jsonObjects)
        }
        
        let queue = OperationQueue()
        
        queue.addOperations([requestOperation], waitUntilFinished: false)
        
        return CancellableNetworkRequest(queue: queue)
    }
    
    private func getJsonObject(data: Data?, options: JSONSerialization.ReadingOptions = []) -> Result<Any?, Error> {
        
        guard let data = data else {
            return .success(nil)
        }
        
        do {
            let jsonObject: Any = try JSONSerialization.jsonObject(with: data, options: options)
            return .success(jsonObject)
        }
        catch let error {
            return .failure(error)
        }
    }
}
