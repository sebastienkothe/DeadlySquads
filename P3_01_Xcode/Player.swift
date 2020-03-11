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
            
            print("=== \(self.name), please choose your warrior n°\(numberOfWarrior) ===")
            print("1. Rogue")
            print("2. Mage")
            print("3. Hunter")
            print("4. Priest")
            print("")
            
            guard let choice = readLine() else {
                return nil
            }
            
            switch choice {
            case "1":
                print("=== Choose the name of your Rogue ===")
                warriors.append(Rogue(name: gameManager.getUserInputAsString()))
            case "2":
                print("=== Choose the name of your Mage ===")
                warriors.append(Mage(name: gameManager.getUserInputAsString()))
            case "3":
                print("=== Choose the name of your Hunter ===")
                warriors.append(Hunter(name: gameManager.getUserInputAsString()))
            case "4":
                print("=== Choose the name of your Priest ===")
                warriors.append(Priest(name: gameManager.getUserInputAsString()))
            default:
                print("=== Choose the name of your Rogue ===")
                warriors.append(Rogue(name: gameManager.getUserInputAsString()))
            }
            numberOfWarrior += 1
        }
        
        return warriors
    }
    
    func chooseAWarrior() -> Warrior {
        var numberOfWarrior = warriors.count - 2
        print("== Which warrior do you want to choose to perform an action? ==")
        
        for warrior in self.warriors {
            print("Enter \(numberOfWarrior) to select \(warrior.name) class : \(type(of: warrior))")
            numberOfWarrior += 1
        }
        
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
        print("You choosed \(warriorSelected.name) the \(type(of: warriorSelected))")
        return warriorSelected
    }
    
    func chooseTarget(enemyPlayer: Player) -> Warrior {
        let arrayOfPlayers = gameManager.players
        
        print("=== Do you want target an ally or an enemy ? ===")
        print("1. Ally")
        print("2. Enemy")
        
        let attackOrHeal = gameManager.getUserInputAsString()
        
        if attackOrHeal == "1" {
            print("Which ally do you want to heal?")
            gameManager.ShowTheTeamMembers(of: self)
            let target = gameManager.getUserInputAsString()
            
            switch target {
            case "1":
                return self.warriors[0]
            case "2":
                return self.warriors[1]
            case "3":
                return self.warriors[3]
            default:
                return self.warriors[0]
            }
        } else {
            print("Which enemy do you want to attack?")
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
    
    func action(from warrior1: Warrior, to warrior2: Warrior) {
        print("Press NOW e to heal or f to hit instantly \(warrior2.name)")
        let healOrHit = gameManager.getUserInputAsString()
        
        switch healOrHit {
        case "e":
            print("\(warrior2.name) has \(warrior2.lifePoints)")
            print("// Heal is coming //")
            warrior2.lifePoints += warrior1.attackPoints + warrior1.weapon.damage
            print("\(warrior2.name) has \(warrior2.lifePoints)")
        case "f":
            print("\(warrior2.name) has \(warrior2.lifePoints)")
            print("// Attack is coming //")
            warrior2.lifePoints -= warrior1.attackPoints + warrior1.weapon.damage
            print("\(warrior2.name) has \(warrior2.lifePoints)")
        default:
            print("\(warrior2.name) has \(warrior2.lifePoints)")
            print("// Heal is coming //")
            warrior2.lifePoints += warrior1.attackPoints + warrior1.weapon.damage
            print("\(warrior2.name) has \(warrior2.lifePoints)")
        }
    }
    
    
}
