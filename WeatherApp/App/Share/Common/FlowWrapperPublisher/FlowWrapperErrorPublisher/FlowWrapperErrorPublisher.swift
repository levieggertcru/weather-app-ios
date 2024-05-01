//
//  FlowWrapperPublisher.swift
//  WeatherApp
//
//  Created by Levi Eggert on 5/1/24.
//

import Foundation
import shared
import Combine

extension Publishers {
    
    struct FlowWrapperErrorPublisher<T: AnyObject>: Publisher {
        
        typealias Output = [T]
        typealias Failure = Error
        
        private let flowWrapper: FlowWrapper<T>
        
        init(flowWrapper: FlowWrapper<T>) {
            
            self.flowWrapper = flowWrapper
        }
        
        func receive<S: Subscriber>(subscriber: S) where FlowWrapperErrorPublisher.Failure == S.Failure, FlowWrapperErrorPublisher.Output == S.Input {
                
            let subscription = FlowWrapperErrorSubscription(flowWrapper: flowWrapper, subscriber: subscriber)
            subscriber.receive(subscription: subscription)
        }
    }
}
