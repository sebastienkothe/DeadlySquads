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
    
    private func printWarriorsAvailable() {
        for (index, warriorType) in WarriorType.allCases.enumerated() {
            print("\(index + 1) \(warriorType)")
        }
    }
    
    private func printCreateSingleWarriorInstruction() {
        printPlayerName()
        print("Choose your warrior n°\(warriors.count + 1) :")
    }
    
    func checkName(inputName: String) -> Bool {
        for name in gameManager.warriorsNames {
            guard inputName != name else {
                print("⛔️ Name already taken")
                return true
            }
            
        }
        return false
    }
    
    func createSingleWarrior() -> Warrior? {
        printCreateSingleWarriorInstruction()
        printWarriorsAvailable()
        
        guard let choiceString = readLine() else {
            print("En of file reached too early")
            return nil
        }
        
        guard let choiceInt = Int(choiceString) else {
            print("⛔️ Enter a number")
            return nil
        }
        
        guard 1...WarriorType.allCases.count ~= choiceInt else {
            print("⛔️ Your number must be between 1 and \(WarriorType.allCases.count)")
            return nil
        }
        
        // let inputName = gameManager.randomName()
        let selectionOk: Bool = false
        
        while selectionOk == false {
            print("Choose his name :")
            guard let inputName = readLine() else {
                print("En of file reached too early")
                continue
            }
            
            guard inputName.count <= 6 else {
                print("⛔️ Name must contain a maximum of six characters")
                continue
            }
            
            guard inputName.count > 0 else {
                print("⛔️ Name must contain at least one character")
                continue
            }
            
            let nameVerified = checkName(inputName: inputName)
            if nameVerified {
                continue
            }
            
            gameManager.warriorsNames.append(inputName)
            
            switch WarriorType.allCases[choiceInt - 1] {
            case .Rogue: return Rogue(name: inputName)
            case .Mage: return Mage(name: inputName)
            case .Hunter: return Hunter(name: inputName)
            case .Priest: return Priest(name: inputName)
            }
        }
    }
    
    func createWarriors(numberOfWarriors: Int) {
        while warriors.count < numberOfWarriors {
            if let warriorCreated = createSingleWarrior() {
                warriors.append(warriorCreated)
            }
        }
    }
    
    func prepareTheWarriors() {
        for warrior in warriors {
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
    
    func printListOfWarriors() {
        for (index, warrior) in warriors.enumerated() {
            print("\(index + 1). 👤 \(warrior.name.uppercased()) ❤️ \(warrior.lifePoints) 💪 \(warrior.attackPoints)")
        }
    }
    
    func printPlayerName() {
        print("➡️ \(self.name.uppercased())")
    }
    
    func chooseAWarrior() -> Warrior {
        let selectionOk: Bool = false
        
        while selectionOk == false {
            printPlayerName()
            print("Choose a warrior :")
            printListOfWarriors()
            
            guard let choice = gameManager.getUserInputAsInt() else {
                print("⛔️ Enter a number")
                continue
            }
            
            guard 1...warriors.count ~= choice else {
                print("⛔️ Enter a number between 1 and \(warriors.count)")
                continue
            }
            
            switch choice {
            case 1:
                return self.warriors[0]
            case 2:
                return self.warriors[1]
            case 3:
                return self.warriors[2]
            default:
                continue
            }
            
        }
        
    }
    
    func chooseFaction() -> WarriorFaction {
        let selectionOk: Bool = false
        
        while selectionOk == false {
            print("Target :\n1. ally\n2. enemy")
            guard let response = gameManager.getUserInputAsInt() else {
                print("⛔️ Enter a number")
                continue
            }
            guard 1...2 ~= response else {
                print("⛔️ Enter a number between 1 and 2")
                continue
            }
            switch response {
            case 1:
                return .ally
            case 2:
                return .enemy
            default:
                continue
            }
        }
        
    }
    
    func targetAnEnemy(enemyPlayer: Player) -> Warrior {
        let selectionOk: Bool = false
        
        while selectionOk == false {
            print("Which enemy ?")
            enemyPlayer.printListOfWarriors()
            
            guard let enemySelected = gameManager.getUserInputAsInt() else {
                print("⛔️ Enter a number")
                continue
            }
            
            guard 1...enemyPlayer.warriors.count ~= enemySelected else {
                print("⛔️ Enter a number between 1 and \(enemyPlayer.warriors.count)")
                continue
            }
            
            switch enemySelected {
            case 1:
                return enemyPlayer.warriors[0]
            case 2:
                return enemyPlayer.warriors[1]
            case 3:
                return enemyPlayer.warriors[2]
            default:
                continue
            }
        }
    }
    
    func targetAnAlly() -> Warrior {
        let selectionOk: Bool = false
        
        while selectionOk == false {
            print("Which ally ?")
            self.printListOfWarriors()
            
            guard let allySelected = gameManager.getUserInputAsInt() else {
                print("⛔️ Enter a number")
                continue
            }
            
            guard 1...warriors.count ~= allySelected else {
                print("⛔️ Enter a number between 1 and \(warriors.count)")
                continue
            }
            
            switch allySelected {
            case 1:
                return self.warriors[0]
            case 2:
                return self.warriors[1]
            case 3:
                return self.warriors[2]
            default:
                continue
            }
        }
    }
    
    func heal(from warrior1: Warrior, to warrior2: Warrior) {
        print("\(warrior1.name) heals \(warrior2.name)❗️")
        warrior2.lifePoints += warrior1.attackPoints + warrior1.weapon.damage
    }
    
    func attack(from warrior1: Warrior, to warrior2: Warrior) {
        print("\(warrior1.name) attacks \(warrior2.name)❗️")
        if warrior1.attackPoints + warrior1.weapon.damage > warrior2.lifePoints {
            warrior2.lifePoints = 0
        } else {
            warrior2.lifePoints -= warrior1.attackPoints + warrior1.weapon.damage
        }
    }

}
