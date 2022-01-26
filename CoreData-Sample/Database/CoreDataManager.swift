//
//  CoreDataManager.swift
//  CoreData-Sample
//
//  Created by Sajjad Sarkoobi on 1/26/22.
//

import Foundation
import CoreData

class CoreDataManager {
    
    public static var shared: CoreDataManager = CoreDataManager()
    
    private init() {
        //Singleton class
    }
    
    //Defining PersistentContainer
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreData_Sample")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Loading CoreData persistent container failed \(error)")
            }
        }

        return container
    }()
    
    @discardableResult
    func createPlayer(name: String) -> Player? {
        let context = persistentContainer.viewContext
        
        let player = Player(context: context)
        player.name = name
        
        do {
            try context.save()
            return player
        } catch(let err){
            print("error in saving context \(err.localizedDescription)")
        }
        return nil
    }
    
    func fetchPlayers() -> [Player] {
        let context = persistentContainer.viewContext
        
        guard let players = try? context.fetch(NSFetchRequest(entityName: "Player")) as? [Player] else {
            return []
        }
        return players
    }
    
    func fetchPlayer(withName name: String) -> Player? {
        let context = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<Player>(entityName: "Player")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)

        do {
            let employees = try context.fetch(fetchRequest)
            return employees.first
        } catch let error {
            print("Failed to fetch: \(error)")
        }

        return nil
    }
    
    func deletePlayer(player: Player) {
        let context = persistentContainer.viewContext
        context.delete(player)
        
        do {
            try context.save()
        } catch(let err) {
            print("error in deleting \(err.localizedDescription)")
        }
    }
}
