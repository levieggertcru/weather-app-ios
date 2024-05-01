//
//  FlowWrapperNeverPublisher.swift
//  WeatherApp
//
//  Created by Levi Eggert on 5/1/24.
//

import Foundation
import shared
import Combine

extension Publishers {
    
    struct FlowWrapperNeverPublisher<T: AnyObject>: Publisher {
        
        typealias Output = [T]
        typealias Failure = Never
        
        private let flowWrapper: FlowWrapper<T>
        
        init(flowWrapper: FlowWrapper<T>) {
            
            self.flowWrapper = flowWrapper
        }
        
        func receive<S: Subscriber>(subscriber: S) where FlowWrapperNeverPublisher.Failure == S.Failure, FlowWrapperNeverPublisher.Output == S.Input {
                
            let subscription = FlowWrapperNeverSubscription(flowWrapper: flowWrapper, subscriber: subscriber)
            subscriber.receive(subscription: subscription)
        }
    }
}
