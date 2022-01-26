//
//  FirstViewModel.swift
//  CoreData-Sample
//
//  Created by Sajjad Sarkoobi on 1/26/22.
//

import Foundation

class FirstViewModel {
    
    var counter: Observable<Int> = Observable(nil)
    
    func savePlyaer() {
        CoreDataManager.shared.createPlayer(name: "Sajjad")
        updateCounter()
    }
    
    func deletePlayer() {
        guard let player = CoreDataManager.shared.fetchPlayer(withName: "Sajjad") else {
            return
        }
        CoreDataManager.shared.deletePlayer(player: player)
        updateCounter()
    }
    
    func updateCounter() {
        let count = CoreDataManager.shared.fetchPlayers().count
        counter.value = count
    }
}
