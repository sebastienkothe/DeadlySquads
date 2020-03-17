//
//  GameManager.swift
//  P3_01_Xcode
//
//  Created by Sébastien Kothé on 10/03/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import Foundation


class GameManager {
    var players: [Player] = []
    var warriorsNames = [String]()
    
    let numberOfPlayersRequired = 2
    let numberOfWarriorsRequired = 3
    
    // Method to get an input as a int
    func getUserInputAsInt() -> Int? {
        
        guard let strData = readLine() else {
            return nil
        }
        
        guard let intData = Int(strData) else {
            return nil
        }
        
        return intData
    }
    
    // Method to create players
    func createPlayer() {
        while players.count < numberOfPlayersRequired {
            let player = Player()
            players.append(player)
            player.name = "Player \(players.count)"
        }
    }
    
    // Method to bring up a chest
    func bringUpAChest(for warrior: Warrior) {
        let number = Int.random(in: 0..<1)
        
        if number == 0 {
            print("\(warrior.name.uppercased()) took the weapon inside, its name is : \(TragicFate().name) 😱")
            warrior.weapon = TragicFate()
        }
    }
    
    // Method to create random names
    func randomName() -> String {
        let length = 6
        let characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let randomCharacters = (0..<length).map{_ in characters.randomElement()!}
        let randomString = String(randomCharacters)
        
        return randomString
    }
    
    // Method to check if a team is dead
    func endGameChecker() -> Bool {
        for player in players {
            if player.warriors.count == 0 {
                return true
            }
        }
        return false
    }
    
    // Method to show the list of remaining warriors at the end of game
    func endGameList(player: Player) {
        print("Remaining warriors :")
        for (index, warrior) in player.warriors.enumerated() {
            print("\(index + 1). 👤 \(warrior.name.uppercased()) ❤️ \(warrior.lifePoints) 💪 \(warrior.attackPoints)")
        }
    }
    
    // Method to remove the warriors dead from the warriors array
    func removeTheDead(){
        for player in players {
            var indexOfWarrior = 0
            for warrior in player.warriors {
                
                if warrior.lifePoints <= 0 {
                    player.warriors.remove(at: indexOfWarrior)
                    print("\(warrior.name.uppercased()) is dead ! ⚰️")
                }
                indexOfWarrior += 1
            }
        }
        
        
    }
    
    // Method for managing the different parts of the game
    public func startNewGame() {
        createPlayer()
        var counter = 0
        
        let player1 = players[0]
        let player2 = players[1]
        
        for player in players {
            player.createWarriors(numberOfWarriors: numberOfWarriorsRequired)
            player.prepareTheWarriors()
        }
        
        while endGameChecker() != true {
            
            let warriorSelected = player1.chooseAWarrior()
            //bringUpAChest(for: warriorSelected)
            let factionTargeted = player1.chooseFaction()
            
            switch factionTargeted {
            case .ally:
                let allyTargeted = player1.targetAnAlly()
                player1.heal(from: warriorSelected, to: allyTargeted)
            case .enemy:
                let enemytargeted = player1.targetAnEnemy(enemyPlayer: player2)
                player1.attack(from: warriorSelected, to: enemytargeted)
            }
            
            removeTheDead()
            if endGameChecker() {
                print("\(player1.name) wins❗️")
                endGameList(player: player1)
                print("🏁 Number of laps : \(counter)")
                break
            }
            
            let warriorSelectedByP2 = player2.chooseAWarrior()
            bringUpAChest(for: warriorSelectedByP2)
            let factionTargetedByP2 = player2.chooseFaction()
            
            switch factionTargetedByP2 {
            case .ally:
                let allyTargeted = player2.targetAnAlly()
                player1.heal(from: warriorSelectedByP2, to: allyTargeted)
            case .enemy:
                
                let enemytargeted = player2.targetAnEnemy(enemyPlayer: player1)
                player2.attack(from: warriorSelectedByP2, to: enemytargeted)
            }
            counter += 1
            removeTheDead()
            if endGameChecker() {
                print("\(player2.name) wins❗️")
                endGameList(player: player2)
                print("🏁 Number of laps : \(counter)")
                break
            }
        }
        
    }
}
