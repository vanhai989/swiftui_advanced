//
//  CoreDataRelationShipsView.swift
//  swiftuiAdvanced
//
//  Created by Hai Dev on 11/08/2022.
//

import SwiftUI
import CoreData

class CoreDataManager {
    static let instance = CoreDataManager() // Singleton
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "CoreDataRelationshipsContainer")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error loading Core Data. \(error)")
            }
        }
        context = container.viewContext
    }
    
    func save() {
        do {
            try context.save()
            print("Saved successfully!")
        } catch let error {
            print("Error saving Core Data. \(error.localizedDescription)")
        }
    }
    
}

class CoreDataRelationshipsViewModel: ObservableObject {
    let manager = CoreDataManager.instance
    
    func addBusiness() {
        let newBusiness = BusinessEntity(context: manager.context)
        newBusiness.name = "Facebook"
        
        // add existing departments to the new business
        //newBusiness.departments = [departments[0], departments[1]]
        
        // add existing employees to the new business
        //newBusiness.employees = [employees[1]]
        
        // add new business to existing department
        //newBusiness.addToDepartments(<#T##value: DepartmentEntity##DepartmentEntity#>)
        
        // add new business to existing employee
        //newBusiness.addToEmployees(<#T##value: EmployeeEntity##EmployeeEntity#>)
                
//        save()
    }
    
    
}

struct CoreDataRelationshipsView: View {
    @StateObject var vm = CoreDataRelationshipsViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Business")
                ScrollView(.horizontal, showsIndicators: true) {
                    Text("aaa")
                }
                Text("Department")
                ScrollView(.horizontal, showsIndicators: true) {
                    Text("aaa")
                }
                Text("Employee")
                ScrollView(.horizontal, showsIndicators: true) {
                    Text("aaa")
                }
                Spacer()
            }
        }
        .navigationTitle(Text("Core data relationships"))
    }
}

struct CoreDataRelationshipsView_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataRelationshipsView()
    }
}
