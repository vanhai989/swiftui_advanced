//
//  CoreDataView.swift
//  swiftuiAdvanced
//
//  Created by Hai Dev on 10/08/2022.
//

import SwiftUI
import CoreData

class CoreDataViewModel: ObservableObject {
    
    let container: NSPersistentContainer
    @Published var saveEntities: [FruitEnttity] = []
    
    init() {
        container = NSPersistentContainer(name: "FruitsContainer")
        container.loadPersistentStores { (persistent, error) in
            if let error = error {
                print("ERROR LOADING COREDATA \(error)")
            } else {
                print("SUCCESSFULLY LOADING COREDATA!")
            }
        }
        fetchEntity()
    }
    
    func fetchEntity() {
        let request = NSFetchRequest<FruitEnttity>(entityName: "FruitEnttity")
        
        do {
            saveEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("ERROR FETCHING COREDATA \(error)")
        }
    }
    
    func addEntity(name: String) {
        let entity = FruitEnttity(context: container.viewContext)
        entity.name = name
        saveEntity()
    }
    
    func saveEntity() {
        do {
            try container.viewContext.save()
            fetchEntity()
        } catch let error {
            print("ERROR FETCHING COREDATA \(error)")
        }
    }
    
    func deleteEntity(indexSet: IndexSet) {
        guard let indexSet = indexSet.first else { return }
        let fruitEntity = saveEntities[indexSet]
        container.viewContext.delete(fruitEntity)
        saveEntity()
    }
}


struct CoreDataView: View {
    @StateObject var vm: CoreDataViewModel = CoreDataViewModel()
    @State var fruit: String = ""
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 10) {
                Spacer().frame(height: 100)
                TextField("Add some fruit", text: $fruit)
                    .padding()
                    .background(.brown)
                    .cornerRadius(15)
                    .padding(.horizontal)
                
                Button {
                    guard !fruit.isEmpty else { return }
                    vm.addEntity(name: fruit)
                    fruit = ""
                } label: {
                    Text("Add")
                        .foregroundColor(.white)
                        .frame(height: 55, alignment: .center)
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                        .cornerRadius(15)
                        .padding()
                    
                }
                
                    Text("List Fruits")
                List {
                    ForEach(vm.saveEntities) { entity in
                        Text(entity.name ?? "have no any fruit")
                    }
                    .onDelete { index in
                        vm.deleteEntity(indexSet: index)
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle(Text("Fruits"))
            .navigationBarItems(leading: EditButton(), trailing: NavigationLink("add", destination: EmptyView()))
        }
    }
    
}

struct CoreDataView_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataView()
    }
}
