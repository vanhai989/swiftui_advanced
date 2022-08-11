//
//  FutureViewModel.swift
//  swiftuiAdvanced
//
//  Created by Hai Dev on 10/07/2022.
//

import Foundation
import Combine

// download with Combine
// download with @escaping closure
class FutureViewModel: ObservableObject {
    @Published var title: String = "Starting title"
    let url = URL(string: "https://www.google.com")!
    var cancellables = Set<AnyCancellable>()
    init() {
        download()
    }
    
    func download() {
        // with combine
        //        getCombinePublisher()
        //            .sink { _ in
        //
        //            } receiveValue: { [weak self] returnedValue in
        //                self?.title = returnedValue
        //            }
        //            .store(in: &cancellables)
        
        // with closure
        //        getEscapingClosure { returnedValue, error in
        //            self.title = returnedValue
        //        }
        
        //        getFuturePublisher()
        doSomethingInFuture()
            .sink { _ in
                
            } receiveValue: { [weak self] returnedValue in
                self?.title = returnedValue
            }
            .store(in: &cancellables)
        
    }
    
    // combine
    func getCombinePublisher() -> AnyPublisher<String, URLError> {
        URLSession.shared.dataTaskPublisher(for: url)
            .timeout(1, scheduler: DispatchQueue.main)
            .map({_ in return "new value"})
            .eraseToAnyPublisher()
    }
    
    // escaping
    func getEscapingClosure(completionHandler: @escaping (_ value: String, _ error: Error?) -> ()) {
        URLSession.shared.dataTask(with: url) {
            data, response, error in completionHandler("New value 2", nil)
        }
        .resume()
    }
    
    // with future and promise combine
    func getFuturePublisher() -> Future<String, Error> {
        return Future{ promise in
            self.getEscapingClosure { returnedValue, error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(returnedValue))
                }
                
            }
        }
        
    }
    
    // Future + promise and delay timming combine
    func doSomething (completion: @escaping (_ value: String) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            return completion("Value from do something")
        }
    }
    
    func doSomethingInFuture() -> Future<String, Never> {
        Future{promise in
            self.doSomething{ value in
                promise(.success(value))
            }
        }
        
    }
}
