//
//  CombineService.swift
//  swiftuiAdvanced
//
//  Created by Hai Dev on 09/07/2022.
//

import Foundation
import Combine


class CombineService {
//    @Published var basicPublisher: [String] = []
//    @Published var stringPublisher: String = ""
//    let currentValuePublisher = CurrentValueSubject<String, Never>("first publish")
//    @Published var passThroughPublisher = PassthroughSubject<String, Error>()
    @Published var passThroughPublisher = PassthroughSubject<Int, Error>()
    @Published var boolPublisher = PassthroughSubject<Bool, Error>()
    @Published var intPublisher = PassthroughSubject<Int?, Error>()
    
    init() {
        publishFakeData()
    }
    
    // fake get data from the api
    private func publishFakeData() {
//        let items: [Int?] = [1,2,3,4,4,nil,7,4,5,6,7,8,11,10]
        let items: [Int] = [1,2,3,4,4,7,4,5,6,7,8,11,10]
        
        for x in items.indices {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(x)) {
                
                // for multiple publishers / subcribers
                if (x > 4 && x < 8) {
                    self.boolPublisher.send(true)
                    self.intPublisher.send(999)
                } else {
                    self.boolPublisher.send(false)
                }
                
//                self.currentValuePublisher = items[x]
//                self.currentValuePublisher.send(items[x])
                self.passThroughPublisher.send(items[x])
                if x == items.indices.last {
                    self.passThroughPublisher.send(completion: .finished)
                }
            }
        }
        
        // debonce
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
//            self.passThroughPublisher.send(1)
//        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//            self.passThroughPublisher.send(2)
//        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
//            self.passThroughPublisher.send(3)
//        }
    }
}
