//
//  Player.swift
//  P3_01_Xcode
//
//  Created by Sébastien Kothé on 10/03/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import Foundation

class Player {
    var warriors: [Warrior] = []
    var name = ""
    
    enum Class {
        case rogue
        case mage
        case hunter
        case priest
    }
    
    func createWarriors() -> Optional<[Warrior]> {
        //1. Rogue - 2. Mage - 3. Hunter
        var numberOfWarrior = warriors.count + 1
        
        while warriors.count < 3 {
            print("➡️ \(self.name.uppercased())")
            GameManager.printTheMessage(message: .lineBreak)
            print("Choose your warrior n°\(numberOfWarrior) :")
            GameManager.printTheMessage(message: .listOfWarriorsAvailable)
            GameManager.printTheMessage(message: .lineBreak)
            
            guard let choice = readLine() else {
                return nil
            }
            
            switch choice {
            case "1":
                GameManager.printTheMessage(message: .lineBreak)
                GameManager.printTheMessage(message: .nameOfRogue)
                warriors.append(Rogue(name: gameManager.getUserInputAsString()))
                GameManager.printTheMessage(message: .lineBreak)
            case "2":
                GameManager.printTheMessage(message: .lineBreak)
                GameManager.printTheMessage(message: .nameOfMage)
                warriors.append(Mage(name: gameManager.getUserInputAsString()))
                GameManager.printTheMessage(message: .lineBreak)
            case "3":
                GameManager.printTheMessage(message: .lineBreak)
                GameManager.printTheMessage(message: .nameOfHunter)
                warriors.append(Hunter(name: gameManager.getUserInputAsString()))
                GameManager.printTheMessage(message: .lineBreak)
            case "4":
                GameManager.printTheMessage(message: .lineBreak)
                GameManager.printTheMessage(message: .nameOfPriest)
                warriors.append(Priest(name: gameManager.getUserInputAsString()))
                GameManager.printTheMessage(message: .lineBreak)
            default:
                GameManager.printTheMessage(message: .lineBreak)
                GameManager.printTheMessage(message: .nameOfRogue)
                warriors.append(Rogue(name: gameManager.randomName()))
                GameManager.printTheMessage(message: .lineBreak)
            }
            numberOfWarrior += 1
        }
        
        return warriors
    }
    
    func chooseAWarrior() -> Warrior {
        print("➡️ \(self.name.uppercased())")
        GameManager.printTheMessage(message: .lineBreak)
        GameManager.printTheMessage(message: .chooseAWarrior)
        
        var numberOfWarrior = 0
        for warrior in self.warriors {
            numberOfWarrior += 1
            print("\(numberOfWarrior). \(warrior.name.uppercased()) (\(type(of: warrior)))")
        }
        GameManager.printTheMessage(message: .lineBreak)
        let choice = gameManager.getUserInputAsString()
        let warriorSelected: Warrior
        
        switch choice {
        case "1":
            warriorSelected = warriors[0]
        case "2":
            warriorSelected = warriors[1]
        case "3":
            warriorSelected = warriors[2]
        default:
            warriorSelected = warriors[0]
        }
        GameManager.printTheMessage(message: .lineBreak)
        GameManager.printTheMessage(message: .warriorSelected)
        print("📍 \(warriorSelected.name.uppercased()) the \(type(of: warriorSelected))")
        return warriorSelected
    }
    
    func chooseTarget(enemyPlayer: Player) -> Warrior {
        _ = gameManager.players
        
        GameManager.printTheMessage(message: .lineBreak)
        GameManager.printTheMessage(message: .chooseTarget)
        GameManager.printTheMessage(message: .lineBreak)
        
        let attackOrHeal = gameManager.getUserInputAsString()
        
        if attackOrHeal == "1" {
            GameManager.printTheMessage(message: .lineBreak)
            GameManager.printTheMessage(message: .allySelection)
            gameManager.ShowTheTeamMembers(of: self)
            let target = gameManager.getUserInputAsString()
            
            switch target {
            case "1":
                return self.warriors[0]
            case "2":
                return self.warriors[1]
            case "3":
                return self.warriors[2]
            default:
                return self.warriors[0]
            }
        } else {
            GameManager.printTheMessage(message: .lineBreak)
            GameManager.printTheMessage(message: .enemySelection)
            GameManager.printTheMessage(message: .lineBreak)
            gameManager.ShowTheTeamMembers(of: enemyPlayer)
            let target = gameManager.getUserInputAsString()
            
            switch target {
            case "1":
                return enemyPlayer.warriors[0]
            case "2":
                return enemyPlayer.warriors[1]
            case "3":
                return enemyPlayer.warriors[2]
            default:
                return enemyPlayer.warriors[0]
            }
        }
        
    }
    
    func action(from warrior1: Warrior, to warrior2: Warrior, enemyPlayer: Player) {
        GameManager.printTheMessage(message: .lineBreak)
        print("💉 Press e to heal \(warrior2.name.uppercased())")
        print("🪓 Press f to hit \(warrior2.name.uppercased())")
        GameManager.printTheMessage(message: .lineBreak)
        let healOrHit = gameManager.getUserInputAsString()
        GameManager.printTheMessage(message: .lineBreak)
        
        switch healOrHit {
        case "e":
            print("\(warrior2.name.uppercased()) has \(warrior2.lifePoints) life points.")
            GameManager.printTheMessage(message: .heal)
            warrior2.lifePoints += warrior1.attackPoints + warrior1.weapon.damage
            print("\(warrior2.name.uppercased()) has now \(warrior2.lifePoints) life points.")
            GameManager.printTheMessage(message: .lineBreak)
        case "f":
            print("\(warrior2.name.uppercased()) has \(warrior2.lifePoints) life points.")
            GameManager.printTheMessage(message: .attack)
            if warrior1.attackPoints + warrior1.weapon.damage > warrior2.lifePoints {
                warrior2.lifePoints = 0
            } else {
                warrior2.lifePoints -= warrior1.attackPoints + warrior1.weapon.damage
            }
            print("\(warrior2.name.uppercased()) has now \(warrior2.lifePoints) life points.")
            GameManager.printTheMessage(message: .lineBreak)
        default:
            print("\(warrior2.name.uppercased()) has \(warrior2.lifePoints) life points.")
            GameManager.printTheMessage(message: .attack)
            if warrior1.attackPoints + warrior1.weapon.damage > warrior2.lifePoints {
                warrior2.lifePoints = 0
            } else {
                warrior2.lifePoints -= warrior1.attackPoints + warrior1.weapon.damage
            }
            print("\(warrior2.name.uppercased()) has now \(warrior2.lifePoints) life points.")
            GameManager.printTheMessage(message: .lineBreak)
        }
        
    }
    
    
}
