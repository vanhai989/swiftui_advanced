//
//  DependencyInjectionView.swift
//  swiftuiAdvanced
//
//  Created by Hai Dev on 10/07/2022.
//

import SwiftUI
import Combine

// proplems with Singleton
// 1. Singleton's are GLOBAL
// 2. can't customize the init! -> because it is created in it's side thus can't takes the agruments
// 3. can't swap out dependencies


struct PostModel: Codable, Identifiable {
    
    /*
     {
         "userId": 1,
         "id": 1,
         "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
         "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
       }
     */
    
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class ProductionDataService {
    static let instance = ProductionDataService() // singleton
    
    let url: URL = URL(string: "https://jsonplaceholder.typicode.com/posts")!
    
    func getData() -> AnyPublisher<[PostModel], Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map({$0.data})
            .decode(type: [PostModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}

class DependencyInjectionViewModel: ObservableObject {
    @Published var dataArray: [PostModel] = []
    var cancellables = Set<AnyCancellable>()
    
    init() {
        loadPosts()
    }
    
    private func loadPosts() {
        ProductionDataService.instance.getData()
            .sink { _ in
                
            } receiveValue: { posts in
                self.dataArray = posts
            }
            .store(in: &cancellables)

    }
    
}


struct DependencyInjectionView: View {
    @StateObject private var vm: DependencyInjectionViewModel = DependencyInjectionViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(vm.dataArray) { post in
                    Text(post.title)
                }
            }
        }
    }
}

struct DependencyInjectionView_Previews: PreviewProvider {
    static var previews: some View {
        DependencyInjectionView()
    }
}
