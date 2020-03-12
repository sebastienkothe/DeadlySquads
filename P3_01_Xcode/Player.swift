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
            print("➡️ \(self.name)")
            print("")
            print("Choose your warrior n°\(numberOfWarrior)")
            print("1. 🟡 Rogue ")
            print("2. 🔵 Mage ")
            print("3. 🟢 Hunter ")
            print("4. ⚪️ Priest ")
            print("")
            
            guard let choice = readLine() else {
                return nil
            }
            
            switch choice {
            case "1":
                print("")
                print("Choose the name of your Rogue ✍️")
                warriors.append(Rogue(name: gameManager.getUserInputAsString()))
                print("")
            case "2":
                print("")
                print("Choose the name of your Mage ✍️")
                warriors.append(Mage(name: gameManager.getUserInputAsString()))
                print("")
            case "3":
                print("")
                print("Choose the name of your Hunter ✍️")
                warriors.append(Hunter(name: gameManager.getUserInputAsString()))
                print("")
            case "4":
                print("")
                print("Choose the name of your Priest ✍️")
                warriors.append(Priest(name: gameManager.getUserInputAsString()))
                print("")
            default:
                print("")
                print("Choose the name of your Rogue ✍️")
                warriors.append(Rogue(name: gameManager.getUserInputAsString()))
                print("")
            }
            numberOfWarrior += 1
        }
        
        return warriors
    }
    
    func chooseAWarrior() -> Warrior {
        print("➡️ \(self.name)")
        print("")
        print("Choose your warrior to perform an action")
        
        var numberOfWarrior = 0
        for warrior in self.warriors {
            numberOfWarrior += 1
            print("\(numberOfWarrior). \(warrior.name) (\(type(of: warrior)))")
        }
        print("")
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
        print("")
        print("You choosed \(warriorSelected.name) the \(type(of: warriorSelected))")
        return warriorSelected
    }
    
    func chooseTarget(enemyPlayer: Player) -> Warrior {
        let arrayOfPlayers = gameManager.players
        
        print("")
        print("Do you want target an ally or an enemy ? 🎯")
        print("1. Ally")
        print("2. Enemy")
        print("")
        
        let attackOrHeal = gameManager.getUserInputAsString()
        
        if attackOrHeal == "1" {
            print("")
            print("Which ally do you want to heal?")
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
            print("")
            print("Which enemy do you want to attack?")
            print("")
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
        print("Press NOW e to heal 💊 or f to hit 🪓 instantly \(warrior2.name)")
        let healOrHit = gameManager.getUserInputAsString()
        
        switch healOrHit {
        case "e":
            print("\(warrior2.name) has \(warrior2.lifePoints) life points")
            print("💉 Heal is coming 💉")
            warrior2.lifePoints += warrior1.attackPoints + warrior1.weapon.damage
            print("\(warrior2.name) has \(warrior2.lifePoints) life points")
        case "f":
            print("\(warrior2.name) has \(warrior2.lifePoints) life points")
            print("💥 Attack is coming 💥")
            if warrior1.attackPoints + warrior1.weapon.damage > warrior2.lifePoints {
                warrior2.lifePoints = 0
            } else {
                warrior2.lifePoints -= warrior1.attackPoints + warrior1.weapon.damage
            }
            print("\(warrior2.name) has \(warrior2.lifePoints) life points")
        default:
            print("\(warrior2.name) has \(warrior2.lifePoints) life points")
            print("💉 Heal is coming 💉")
            warrior2.lifePoints += warrior1.attackPoints + warrior1.weapon.damage
            print("\(warrior2.name) has \(warrior2.lifePoints) life points")
        }
        
    }
    
    
}
