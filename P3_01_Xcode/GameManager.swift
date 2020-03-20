//
//  GameManager.swift
//  P3_01_Xcode
//
//  Created by Sébastien Kothé on 10/03/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import Foundation

class GameManager {
    
    // MARK: - Static
    // MARK: Static - Properties
    
    private static let numberOfPlayersRequired = 2
    private static let numberOfWarriorsRequired = 3
    private static var endGame = false // True if the player's warriors are dead
    private static var counter = 0 // It stores the number of turns
    
    // MARK: - Public
    // MARK: Public - Methods
    
    // Method for managing the different parts of the game
    public func startNewGame() {
        
        createPlayers()
        
        startTeamCreationPhase()
        
        handleFightPhase()
        
        handleEndGame()
    }
    
    // MARK: - Private
    // MARK: Private - Properties
    
    private var warriorNames: [String] {
        var names: [String] = []
        
        for player in players {
            for warrior in player.warriors {
                names.append(warrior.name)
            }
        }
        
        return names
    }
    
    private var players: [Player] = []
    private var warriorsNames: [String] = []
    
    // MARK: Private - Methods
    
    // Methods to create warriors and initialize their characteristics
    private func startTeamCreationPhase() {
        for player in players {
            player.createWarriors(numberOfWarriors: GameManager.numberOfWarriorsRequired, warriorNames: warriorNames)
            prepareTheWarriors()
        }
    }
    
    // Method to find the enemy player of the current player
    private func getOpponentPlayer(from playingPlayer: Player) -> Player? {
        for player in players {
            if playingPlayer.id != player.id {
                return player
            }
        }
        
        return nil
    }
    
    // Method to create players
    private func createPlayers() {
        while players.count < GameManager.numberOfPlayersRequired {
            createSinglePlayer(id: players.count + 1)
        }
    }
    
    // Method to create a single player
    private func createSinglePlayer(id: Int) {
        let player = Player(id: id)
        players.append(player)
    }
    
    // Method to bring up a chest
    private func bringUpAChest(for warrior: Warrior) {
        let randomNumber = Int.random(in: 0..<11)
        if randomNumber == 1 {
            print("🚨 A chest appears\n👤 \(warrior.name.uppercased()) gets a new weapon")
            warrior.weapon = TragicFate()
        }
    }
    
    // Method to create random names
    private func randomName() -> String {
        let length = 6
        let characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let randomCharacters = (0..<length).map{_ in characters.randomElement()!}
        let randomString = String(randomCharacters)
        
        return randomString
    }
    
    // Method to check if the team's members is dead
    private func endGameChecker() -> Bool {
        for player in players {
            if player.warriors.count == 0 {
                return true
            }
        }
        return false
    }
    
    // Method to show the list of remaining warriors at the end of game
    private func endGameList(player: Player) {
        print("Remaining warriors :")
        for warrior in player.warriors {
            print("👤 \(warrior.name.uppercased()) ❤️ \(warrior.lifePoints) 💪 \(warrior.attackPoints)")
        }
    }
    
    // Method to remove the warriors dead from the warriors array
    private func removeTheDead() {
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
    
    // Method to print the number of turns
    private func printTheNumberOfTurns(counter: Int) {
        print("🏁 Number of turns : \(counter)")
    }
    
    // Method to initialize skill points
    private func prepareTheWarriors() {
        for player in players {
            for warrior in player.warriors{
                if warrior is Rogue {
                    warrior.lifePoints = 70
                    warrior.attackPoints = 30
                    warrior.weapon = Dagger()
                    
                } else if warrior is Mage {
                    warrior.lifePoints = 60
                    warrior.attackPoints = 35
                    warrior.weapon = Spear()
                } else if warrior is Hunter {
                    warrior.lifePoints = 80
                    warrior.attackPoints = 25
                    warrior.weapon = Bow()
                } else {
                    warrior.lifePoints = 54
                    warrior.attackPoints = 32
                    warrior.weapon = Libram()
                }
                
            }
        }
    }
    
    // Method to handle the fight phase
    private func handleFightPhase() {
        while GameManager.endGame != true {
            for player in players where GameManager.endGame != true {
                let warriorSelected = player.chooseAWarrior()
                bringUpAChest(for: warriorSelected)
                let factionTargeted = player.chooseFaction()
                actionFrom(player: player, factionTargeted: factionTargeted, warriorSelected: warriorSelected)
                removeTheDead()
                
                GameManager.endGame = endGameChecker()
            }
            GameManager.counter += 1
        }
        
    }
    
    // Method to handle the end game
    private func handleEndGame() {
        for player in players {
            guard let opponentPlayerUnpack = getOpponentPlayer(from: player) else {
                return
            }
            
            if player.warriors.count == 0 {
                print("\(opponentPlayerUnpack.name) wins❗️")
                endGameList(player: opponentPlayerUnpack)
            }
            
        }
        printTheNumberOfTurns(counter: GameManager.counter)
    }
    
    // Method to handle the two types actions possible
    private func actionFrom(player: Player, factionTargeted: WarriorFaction, warriorSelected: Warrior) {
        switch factionTargeted {
        case .ally:
            let allyTargeted = player.targetAnAlly()
            player.heal(from: warriorSelected, to: allyTargeted)
        case .enemy:
            guard let opponentPlayer = getOpponentPlayer(from: player) else { return }
            let enemytargeted = player.targetAnEnemy(enemyPlayer: opponentPlayer)
            player.attack(from: warriorSelected, to: enemytargeted)
        }
        
    }
    
}
