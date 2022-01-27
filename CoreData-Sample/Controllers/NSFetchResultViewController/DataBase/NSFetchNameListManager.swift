//
//  NSFetchNameListManager.swift
//  CoreData-Sample
//
//  Created by Sajjad Sarkoobi on 1/27/22.
//

import Foundation
import CoreData

class NSFetchNameListManager {
    
    public static var shared: NSFetchNameListManager = NSFetchNameListManager()
    
    private init() {
        // sigleton class
    }
    
    //Defining PersistentContainer
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NSFetchNameModel")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Loading CoreData persistent container failed \(error)")
            }
        }

        return container
    }()
    
    func addName(name: String) {
        let context = persistentContainer.viewContext
        
        let nameList = NameList(context: context)
        nameList.name = name
        
        do {
            try context.save()
        } catch {
            print("Error in saving to nameList")
        }
    }
    
    func deleteName(nameList: NameList) {
        let context = persistentContainer.viewContext
        context.delete(nameList)
        
        do {
            try context.save()
        } catch(let err) {
            print("error in deleting \(err.localizedDescription)")
        }
    }
}
