//
//  GameManager.swift
//  P3_01_Xcode
//
//  Created by Sébastien Kothé on 10/03/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import Foundation

final class GameManager {
    
    // MARK: - Internal methods
    
    /// Method for managing the different parts of the game
    func startNewGame() {
        
        printGameInstruction()
        
        createPlayers()
        
        startTeamCreationPhase()
        
        handleFightPhase()
        
        handleEndGame()
    }

    // MARK: - Private properties
    
    /// Interval used to unlock the chest
    private let intervalForTheChest = 0...3
    /// Number required to unlock the chest
    private let numberToUnlockTheChest = 0
    /// Interval used to choose the bonus weapon
    private let intervalForTheWeapons = 1...2
    
    private var players: [Player] = []
    private let numberOfPlayersRequired = 2
    private let numberOfWarriorsRequired = 3
    
    /// True if the player's warriors are dead
    private var isGameOver: Bool {
        var numberOfPlayerAlive = 0
        
        for player in players where player.isAlive {
            numberOfPlayerAlive += 1
        }
        
        let isGameOver = numberOfPlayerAlive == 1
        
        return isGameOver
    }
    
    /// Stores the number of turns
    private var counter = 0
    
    // MARK: - Private methods
    
    /// Method to print the game title
    private func printGameInstruction() {
        print("🅳🅴🅰🅳🅻🆈 🆂🆀🆄🅰🅳🆂®")
    }
    
    /// Method to create players
    private func createPlayers() {
        while players.count < numberOfPlayersRequired {
            createSinglePlayer(id: players.count + 1)
        }
    }
    
    /// Method to create a single player
    private func createSinglePlayer(id: Int) {
        let player = Player(id: id)
        players.append(player)
    }
    
    /// Method to create warriors
    private func startTeamCreationPhase() {
        for player in players {
            
            guard let opponentPlayer = getOpponentPlayer(from: player) else {
                return
            }
            
            player.createWarriors(numberOfWarriors: numberOfWarriorsRequired, opponentPlayer: opponentPlayer)
        }
    }
    
    /// Method to find the enemy player of the current player
    private func getOpponentPlayer(from playingPlayer: Player) -> Player? {
        for player in players {
            if playingPlayer.id != player.id {
                return player
            }
        }
        
        return nil
    }
    
    /// Method to handle the fight phase
    private func handleFightPhase() {
        
        while !isGameOver {
            
            counter += 1
            
            for player in players where !isGameOver && player.canPlay {
                let warriorSelected = player.chooseAWarrior()
                bringUpAChest(for: warriorSelected)
                let factionTargeted = player.chooseFaction()
                thawWarriors()
                actionFrom(player: player, factionTargeted: factionTargeted, warriorSelected: warriorSelected)
            }
            
        }
        
    }
    
    /// Method to thaw the warriors
    private func thawWarriors() {
        for player in players {
            for warrior in player.warriors where warrior.isFrozen {
                warrior.isFrozen = !warrior.isFrozen
            }
        }
    }
    
    /// Method to bring up a chest
    private func bringUpAChest(for warrior: Warrior) {
        
        let randomNumber = generateRandomNumber(range: intervalForTheChest)
        
        if randomNumber == numberToUnlockTheChest {
            
            guard let randomWeapon = selectTheWeapon() else {
                return
            }
            
            warrior.weapon = randomWeapon
            print("\n🚨 A chest appears 🚨\n👤 \(warrior.name.uppercased()) gets a new weapon 😱")
        }
    }
    
    /// Method to generate a random number
    private func generateRandomNumber(range: ClosedRange<Int>) -> Int {
        let randomNumber = Int.random(in: range)
        return randomNumber
    }
    
    /// Method to select the weapon
    private func selectTheWeapon() -> Weapon? {
        let weaponType = selectTheWeaponType()
        
        switch weaponType {
        case .axe:
            return Axe()
        case .tragicFate:
            return TragicFate()
        default:
            return nil
        }
    }
    
    /// Method to select the weapon type
    private func selectTheWeaponType() -> WeaponType? {
        let randomNumber = generateRandomNumber(range: intervalForTheWeapons)
        switch randomNumber {
        case 1:
            return WeaponType.axe
        case 2:
            return WeaponType.tragicFate
        default:
            return nil
        }
    }
    
    /// Method to handle the actions
    private func actionFrom(player: Player, factionTargeted: WarriorFaction, warriorSelected: Warrior) {
        switch factionTargeted {
        case .ally:
            let allyTargeted = player.targetAnAlly()
            warriorSelected.heal(allyTargeted)
        case .enemy:
            guard let opponentPlayer = getOpponentPlayer(from: player) else { return }
            let enemyTargeted = player.targetAnEnemy(enemyPlayer: opponentPlayer)
            warriorSelected.attack(enemyTargeted)
        }
        
    }
    
    /// Method to handle the end game
    private func handleEndGame() {
        
        for player in players {
            
            guard let opponentPlayerUnpacked = getOpponentPlayer(from: player) else {
                return
            }
            
            if !player.isAlive {
                print("\n🏆 \(opponentPlayerUnpacked.name) wins❗️\n")
                endGameList()
            }
            
        }
        
        printTheNumberOfTurns(counter: counter)
    }
    
    /// Method to show the list of remaining warriors at the end of game
    private func endGameList() {
        print("Remaining warriors :")
        
        for player in players {
            player.printPlayerName()
            player.printListOfWarriors()
        }
    }
    
    /// Method to print the number of turns
    private func printTheNumberOfTurns(counter: Int) {
        print("\n🏁 Number of turns : \(counter)")
    }
    
}
