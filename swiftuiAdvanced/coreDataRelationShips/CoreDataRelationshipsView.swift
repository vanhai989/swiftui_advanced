//
//  CoreDataRelationShipsView.swift
//  swiftuiAdvanced
//
//  Created by Hai Dev on 11/08/2022.
//

import SwiftUI
import CoreData

struct EmployeeModel {
    var name: String
    var age: Int16
    var dateJoined: Date
}

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
    
    @Published var businesses: [BusinessEntity] = []
    @Published var departments: [DepartmentEntity] = []
    @Published var employees: [EmployeeEntity] = []
    
    init() {
        getBusinesses()
        getDepartments()
        getEmployees()
    }
    
    func deleteAllEntity() {
        let request1: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "BusinessEntity")
        let deleteRequest1 = NSBatchDeleteRequest(fetchRequest: request1)
        
        let request2: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "DepartmentEntity")
        let deleteRequest2 = NSBatchDeleteRequest(fetchRequest: request2)
        
        let request3: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "EmployeeEntity")
        let deleteRequest3 = NSBatchDeleteRequest(fetchRequest: request3)
        
        do {
            try manager.context.execute(deleteRequest1)
            try manager.context.execute(deleteRequest2)
            try manager.context.execute(deleteRequest3)
            save()
        } catch let error {
            print("error delete: \(error)")
        }
       
    }
    
    func addAllEntity(nameBusiness: String, nameDepartment: String, employeeModel: EmployeeModel) {
        addBusiness(name: nameBusiness)
        addDepartment(name: nameDepartment)
        addEmployee(payload: employeeModel)
    }
    
    func addBusiness(name: String) {
//        let newBusiness = BusinessEntity(context: manager.context)
//                newBusiness.name = name
        
        // add existing departments to the new business
//        newBusiness.departments = [departments[0]]
//        businesses[0].departments = [departments[0]]
//        businesses[0].employees = [employees[0], employees[1]]
        
        // add existing employees to the new business
//        newBusiness.employees = [employees[0]]
        
        // add new business to existing department
        //newBusiness.addToDepartments(<#T##value: DepartmentEntity##DepartmentEntity#>)
        
        // add new business to existing employee
        //newBusiness.addToEmployees(<#T##value: EmployeeEntity##EmployeeEntity#>)
        
        save()
    }
    
    func addDepartment(name: String) {
//        let newDepartment = DepartmentEntity(context: manager.context)
//        newDepartment.name = name
//        newDepartment.employees = [employees[0]]
        departments[0].employees = [employees[0]]
        save()
    }
    
    func deleDepartment() {
        
        manager.context.delete(departments[0])
        save()
    }
    
    func addEmployee(payload: EmployeeModel) {
        let newEmployee = EmployeeEntity(context: manager.context)
        newEmployee.name = payload.name
        newEmployee.age = payload.age
        newEmployee.dateJoined = payload.dateJoined
        newEmployee.department = departments[0]
        
//        manager.context.delete(employees[1])
        
        save()
    }
    
    func getBusinesses() {
        let request = NSFetchRequest<BusinessEntity>(entityName: "BusinessEntity")
        
        do {
            let sort = NSSortDescriptor(keyPath: \BusinessEntity.name, ascending: true)
            request.sortDescriptors = [sort]
            
            //let filter = NSPredicate(format: "name == %@", "Business1")
            //request.predicate = filter
            
            businesses = try manager.context.fetch(request)
        } catch let error {
            print("ERROR FETCHING BUSINESSES \(error)")
        }
    }
    
    func getDepartments() {
        let request = NSFetchRequest<DepartmentEntity>(entityName: "DepartmentEntity")
        
        do {
            departments = try manager.context.fetch(request)
        } catch let error {
            print("ERROR FETCHING DEPARTMENTS \(error)")
        }
    }
    
    func getEmployees() {
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        do {
            employees = try manager.context.fetch(request)
        } catch let error {
            print("ERROR FETCHING employees \(error)")
        }
    }
    
    func save() {
        businesses.removeAll()
        departments.removeAll()
        employees.removeAll()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.manager.save()
            self.getBusinesses()
            self.getDepartments()
            self.getEmployees()
        }
    }
}

struct CoreDataRelationshipsView: View {
    @StateObject var vm = CoreDataRelationshipsViewModel()
    @State var businessName: String = ""
    @State var departmentName: String = ""
    @State var employeeName: String = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("Business")
                    VStack {
                        TextField("Business name", text: $businessName)
                            .font(.headline)
                            .padding(.leading)
                            .frame(height: 55)
                            .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
                            .cornerRadius(10)
                            .padding(.horizontal)
                        Button {
                            guard !businessName.isEmpty else { return }
                            vm.addBusiness(name: businessName)
//                            vm.deleteAllEntity()
                        } label: {
                            Text("ADD Business")
                                .foregroundColor(.white)
                                .frame(height: 55, alignment: .center)
                                .frame(maxWidth: .infinity)
                                .background(.blue)
                                .cornerRadius(10)
                                .padding()
                        }
                    }
                    ScrollView(.horizontal, showsIndicators: true) {
                        ForEach(vm.businesses) { business in
                            VStack{
                                BusinessView(entity: business)
                            }
                        }
                    }
                }
                .padding(.bottom, 50)
                
                VStack {
                    Text("Department")
                    TextField("Department name", text: $departmentName)
                        .font(.headline)
                        .padding(.leading)
                        .frame(height: 55)
                        .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
                    Button {
//                        guard !departmentName.isEmpty else { return }
//                        vm.addDepartment(name: departmentName)
                        vm.deleDepartment()
                    } label: {
                        Text("ADD Department")
                            .foregroundColor(.white)
                            .frame(height: 55, alignment: .center)
                            .frame(maxWidth: .infinity)
                            .background(.blue)
                            .cornerRadius(10)
                            .padding()
                    }
                    
                    ScrollView(.horizontal, showsIndicators: true) {
                        ForEach(vm.departments) { department in
                            VStack{
                                DepartmentView(entity: department)
                            }
                        }
                    }
                }.padding(.bottom, 50)
                
                VStack {
                    Text("Employee")
                    
                    TextField("Employee name", text: $employeeName)
                        .font(.headline)
                        .padding(.leading)
                        .frame(height: 55)
                        .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
                    Button {
                        guard !employeeName.isEmpty else { return }
                        vm.addEmployee(payload: EmployeeModel(name: employeeName, age: 18, dateJoined: Date()))
                    } label: {
                        Text("ADD Employee")
                            .foregroundColor(.white)
                            .frame(height: 55, alignment: .center)
                            .frame(maxWidth: .infinity)
                            .background(.blue)
                            .cornerRadius(10)
                            .padding()
                    }
                    ScrollView(.horizontal, showsIndicators: true) {
                        ForEach(vm.employees) { employee in
                            VStack{
                                EmployeeView(entity: employee)
                            }
                        }
                        
                    }
                }.padding(.bottom, 50)
                
                Spacer()
            }
            .navigationTitle(Text("Core data relationships"))
        }
    }
}

struct CoreDataRelationshipsView_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataRelationshipsView()
    }
}

struct BusinessView: View {
    let entity: BusinessEntity
    var body: some View {
        VStack(alignment: .leading) {
            Text("Name: \(entity.name ?? "No entity")").bold()
            
            if let departments = entity.departments?.allObjects as? [DepartmentEntity] {
                Text("Departments:")
                    .bold()
                ForEach(departments) { department in
                    Text(department.name ?? "")
                }
            }
            
            if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                Text("Employees:")
                    .bold()
                ForEach(employees) { employee in
                    Text(employee.name ?? "")
                    Text("Age: \(String(employee.age))")
                    Text("Date joined: \(String(employee.dateJoined?.description ?? ""))")
                }
            }
        }
        .padding()
        .background(.green)
        .cornerRadius(10)
        .padding()
        
    }
}

struct DepartmentView: View {
    let entity: DepartmentEntity
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Name: \(entity.name ?? "No entity")").bold()
            
            if let businesses = entity.businesses?.allObjects as? [BusinessEntity] {
                Text("Businesses:")
                    .bold()
                ForEach(businesses) { business in
                    Text(business.name ?? "")
                }
            }
            
            if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                Text("Employees:")
                    .bold()
                ForEach(employees) { employee in
                    Text(employee.name ?? "")
                    Text("Age: \(String(employee.age))")
                    Text("Date joined: \(String(employee.dateJoined?.description ?? ""))")
                }
            }
        }
        .padding()
        .background(.green)
        .cornerRadius(10)
        .padding()
    }
}

struct EmployeeView: View {
    let entity: EmployeeEntity
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Name: \(entity.name ?? "No entity")").bold()
            Text("Age: \(String(entity.age))")
            Text("Date joined: \(String(entity.dateJoined?.description ?? ""))")
            
            Text("Business: \(entity.business?.name ?? "")").bold()
            Text("Department: \(entity.department?.name ?? "")").bold()
            
        }
        .padding()
        .background(.green)
        .cornerRadius(10)
        .padding()
    }
}
