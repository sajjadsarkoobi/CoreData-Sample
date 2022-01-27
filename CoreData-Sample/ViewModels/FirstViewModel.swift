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
        SimplePlayer.shared.createPlayer(name: "Sajjad")
        updateCounter()
    }
    
    func deletePlayer() {
        guard let player = SimplePlayer.shared.fetchPlayer(withName: "Sajjad") else {
            return
        }
        SimplePlayer.shared.deletePlayer(player: player)
        updateCounter()
    }
    
    func updateCounter() {
        let count = SimplePlayer.shared.fetchPlayers().count
        counter.value = count
    }
}
