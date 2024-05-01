//
//  FlowWrapperSubscription.swift
//  WeatherApp
//
//  Created by Levi Eggert on 5/1/24.
//

import Foundation
import shared
import Combine

extension Publishers {
    
    class FlowWrapperErrorSubscription<T: AnyObject, S: Subscriber>: Subscription where S.Input == [T], S.Failure == Error {
        
        private let flowWrapper: FlowWrapper<T>
        
        private var subscriber: S?
        
        init(flowWrapper: FlowWrapper<T>, subscriber: S) {
            
            self.flowWrapper = flowWrapper
            self.subscriber = subscriber
            
            flowWrapper.collect { (value: T) in
                
                _ = subscriber.receive([value])
                
            } onCompletion: { (throwable: KotlinThrowable?) in
                
                let error: Error = throwable?.asError() ?? NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "An unknown error occurred."])
                subscriber.receive(completion: Subscribers.Completion.failure(error))
            }
        }
        
        func request(_ demand: Subscribers.Demand) {
            // Optionaly Adjust The Demand
        }
        
        func cancel() {
            subscriber = nil
        }
    }
}
