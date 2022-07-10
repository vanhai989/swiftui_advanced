//
//  CombineViewModel.swift
//  swiftuiAdvanced
//
//  Created by Hai Dev on 09/07/2022.
//

import Foundation
import Combine


class CombineViewModel: ObservableObject {
    @Published var data: [String] = []
    @Published var dataBools: [Bool] = []

    let service = CombineService()
    var cancellables = Set<AnyCancellable>()
    @Published var err: String = ""
    init() {
        addSubscribers()
    }
    
    func addSubscribers () {
//        service.passThroughPublisher
        // sequence operations
        /*
//            .first(where: {int in
//                print("int \(int)")
//                return int > 1})
//            .tryFirst(where: {
//                int in
//                if int == 5 {
//                    throw URLError(.badServerResponse)
//                }
//                return int > 1
//            })
//            .last()
//            .last(where: { int in
//                int < 2
//            })
//            .tryFirst(where: { int in
//                if int == 5 {
//                    throw URLError(.badServerResponse)
//                }
//                return int > 0
//            })
//            .dropFirst(2)
//            .drop(while: { int in
//                int < 2
//            })
//            .tryDrop(while: { int in
//                if int == 6 {
//                    throw URLError(.badServerResponse)
//                }
//                return int < 2
//            })
//            .prefix(3)
//            .prefix(while: { $0 < 4
//            })
//            .tryPrefix(while: { int in
//                if int == 2 {
//                    throw URLError(.badServerResponse)
//                }
//                return int < 4
//            })
//            .output(at: 2)
            .output(in: 2...4)
        */
        
        // mathematic operation
        /*
//            .max()
//            .max(by: { int1, int2 in
//                return int1 < int2
//            })
//            .tryMax(by: { int1, int2 in
//                print("int1: \(int1), int2: \(int2)")
//                if int1 == int2 {
//                    throw URLError(.badServerResponse)
//                }
//                return int1 < int2
//            })
//            .min()
//            .min(by: { int1, int2 in
//                int1 > int2
//            })
//                    .tryMin(by: { int1, int2 in
//                        print("int1: \(int1), int2: \(int2)")
//                        if int1 == int2 {
//                            throw URLError(.badServerResponse)
//                        }
//                        return int1 < int2
//                    })
         */
        
        // filter / reducing operations
        /*
//            .map({String($0)})
//            .tryMap({ int in
//                if int == 5 {
//                    throw URLError(.badServerResponse)
//                }
//                return String(int ?? 0)
//            })
//            .compactMap({ int in
//                if int == 5 {
//                    return String(999)
//                    return nil
//                }
//                return String(int)
//            })
//            .tryCompactMap(<#T##transform: (Int) throws -> T?##(Int) throws -> T?#>)
//            .filter({ ($0 > 3) && ($0 < 7)
//            })
//            .tryFilter(<#T##isIncluded: (Int) throws -> Bool##(Int) throws -> Bool#>)
//            .removeDuplicates()
//            .removeDuplicates(by: { int1, int2 in
//                return int1 == int2
//            })
//            .tryRemoveDuplicates(by: <#T##(Int, Int) throws -> Bool#>)
//            .replaceNil(with: 999)
//            .replaceEmpty(with: 888)
//            .replaceError(with: "default value")
//            .scan(5, { existingValue, newValue in
//                return existingValue + (newValue ?? 0)
//            })
        // the same setense
//            .scan(5, {$0 + ($1 ?? 0)})
        // the same setense
//            .scan(5, +)
//            .tryScan(<#T##initialResult: T##T#>, <#T##nextPartialResult: (T, Int?) throws -> T##(T, Int?) throws -> T#>)
//            .reduce(5,{ // calculator the sum of the array
//                existingValue, newValue in
//                return existingValue + (newValue ?? 0)
//            })
        // the same the sentense
//            .reduce(5, +)
                    
//                    .collect() // merge the elements to an array
//                    .collect(3)
//            .allSatisfy({ $0 ?? 0 < 50 })
//            .tryAllSatisfy(<#T##predicate: (Int?) throws -> Bool##(Int?) throws -> Bool#>)
        */
        
        // timming operations
        /*
        
//            .debounce(for: 0.75, scheduler: DispatchQueue.main)
//            .delay(for: 3, scheduler: DispatchQueue.main)
//            .measureInterval(using: DispatchQueue.main)
//            .map({stride in
//                return "\(stride.timeInterval)"
//            })
//            .throttle(for: 4, scheduler: DispatchQueue.main, latest: true)
//            .retry(3) // reconect after a failed
//            .timeout(0.75, scheduler: DispatchQueue.main)
        */
        
        // multiple publishers / subscribers
        /*
//            .combineLatest(service.boolPublisher)
//            .compactMap({ (int, bool) in
//                if bool {
//                    return int
//                } else {
//                    return 0
//                }
//            })
        // the same sentense
//            .compactMap({$1 ? $0 : 0})
//            .merge(with: service.intPublisher)
//            .zip(service.boolPublisher, service.intPublisher)
//            .map({ tuple in
//                return "\(tuple.0)" + tuple.1.description + String(tuple.2 ?? 0)
//            })
        */
        
        let sharedPublisher = service.passThroughPublisher
            .dropFirst(2)
            .share()
            .multicast( subject: PassthroughSubject<Int, Error>())
        sharedPublisher
            .map({String($0)})
            .sink { completion in
                switch(completion) {
                case .finished:
                    
                    break
                case .failure(let error):
                    self.err = ("ERROR: \(error)")
                    break
                }
            } receiveValue: { returned in
//                self.data = returned
//                self.data.append(contentsOf: returned)
                self.data.append(returned)
            }
            .store(in: &cancellables)
        
        // duplicate the subscriber
        
        sharedPublisher
            .map({$0 > 5 ? true : false})
            .sink { completion in
                switch(completion) {
                case .finished:
                    break
                case .failure(let error):
                    self.err = ("ERROR: \(error)")
                    break
                }
            } receiveValue: { returned in
                self.dataBools.append(returned)
            }
            .store(in: &cancellables)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            sharedPublisher.connect().store(in: &self.cancellables)
        }

    }
}
