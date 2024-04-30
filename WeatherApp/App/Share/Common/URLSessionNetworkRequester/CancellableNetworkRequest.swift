//
//  CancellableNetworkRequest.swift
//  WeatherApp
//
//  Created by Levi Eggert on 4/30/24.
//

import Foundation
import shared

class CancellableNetworkRequest: CancellableInterface {
    
    private let queue: OperationQueue
    
    init(queue: OperationQueue) {
        
        self.queue = queue
    }
    
    func cancel() {
        
        queue.cancelAllOperations()
    }
}
