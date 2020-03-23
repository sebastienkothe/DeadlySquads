//
//  Player.swift
//  P3_01_Xcode
//
//  Created by Sébastien Kothé on 10/03/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import Foundation

class Player {
    
    init(id: Int) {
        self.id = id
    }
    
    // MARK: - Internal properties

    var isAlive: Bool {
        for warrior in warriors where warrior.isAlive  {
            return true
        }
        return false
    }

    var warriorsNames: [String] {
        var names: [String] = []
        
        for warrior in warriors {
            names.append(warrior.name)
        }
        
        return names
    }
    
    var cantHealHisWarriors: Bool {
        var numberOfWarriors = 0
        for warrior in warriors where warrior.hasMaxHP || !warrior.isAlive {
            numberOfWarriors += 1
        }
        
        if numberOfWarriors == 3 {
            return true
        } else {
            return false
        }
    }
    
    var name: String {
        return "Player \(id)"
    }
    
    let id: Int
    var warriors: [Warrior] = []

    
    // MARK: Internals - Methods
    
    // Method to create Warriors
    func createWarriors(numberOfWarriors: Int, opponentPlayer: Player) {
        while warriors.count < numberOfWarriors {
            let warriorCreated = createSingleWarrior(opponentPlayer: opponentPlayer, warriorsNames: warriorsNames)
                warriors.append(warriorCreated)
        }
    }
    
    // Method to create a single warrior with his name
    private func createSingleWarrior(opponentPlayer: Player, warriorsNames: [String]) -> Warrior {
        let choiceInt = selectWarriorType()
        let selectionOk: Bool = false
        
        while !selectionOk {
            print("\nChoose his name :")
            
            guard let inputName = readLine() else {
                printErrorsMessages(message: .error)
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
            
            let nameVerified = checkName(inputName: inputName, warriorNames: warriorsNames, opponentPlayer: opponentPlayer)
            
            if nameVerified {
                continue
            }
            
            switch WarriorType.allCases[choiceInt - 1] {
            case .Rogue: return Rogue(name: inputName)
            case .Mage: return Mage(name: inputName)
            case .Hunter: return Hunter(name: inputName)
            case .Priest: return Priest(name: inputName)
            }
        }
    }
    
    // Method to select a warrior
    func chooseAWarrior() -> Warrior {
        
        let selectionOk: Bool = false
        
        while selectionOk == false {
            printPlayerName()
            print("Choose a warrior :")
            printListOfWarriors()
            
            guard let choice = getUserInputAsInt() else {
                printErrorsMessages(message: .enterANumber)
                continue
            }
            
            guard 1...warriors.count ~= choice else {
                print("⛔️ Enter a number between 1 and \(warriors.count)")
                continue
            }
            
            let warriorSelected: Warrior
            
            switch choice {
            case 1:
               warriorSelected = self.warriors[0]
            case 2:
                warriorSelected = self.warriors[1]
            case 3:
                warriorSelected = self.warriors[2]
            default:
                continue
            }
            
            if !warriorSelected.isAlive {
                print("\n🖐 You can't choose a dead warrior ☠️")
                continue
            }
            
            return warriorSelected
            
        }
        
    }
    
    // Method to choose the faction
    func chooseFaction() -> WarriorFaction {
        if self.cantHealHisWarriors {
            print("\nYou can't heal your allies❗️\nYou must attack an opponent 😈\n")
            return .enemy
        }
        
        let selectionOk: Bool = false
        
        
        while selectionOk == false {
            print("\nTarget :\n1. Ally\n2. Enemy")
            
            guard let response = getUserInputAsInt() else {
                printErrorsMessages(message: .enterANumber)
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
    
    // Method to target an enemy
    func targetAnEnemy(enemyPlayer: Player) -> Warrior {
        let selectionOk: Bool = false
        
        while selectionOk == false {
            print("\nWhich enemy ?")
            enemyPlayer.printListOfWarriors()
            
            guard let enemySelected = getUserInputAsInt() else {
                printErrorsMessages(message: .enterANumber)
                continue
            }
            
            guard 1...enemyPlayer.warriors.count ~= enemySelected else {
                print("⛔️ Enter a number between 1 and \(enemyPlayer.warriors.count)\n")
                continue
            }
            
            let warriorSelected: Warrior
            
            switch enemySelected {
            case 1:
             warriorSelected = enemyPlayer.warriors[0]
            case 2:
            warriorSelected = enemyPlayer.warriors[1]
            case 3:
            warriorSelected = enemyPlayer.warriors[2]
            default:
                continue
            }
            
            guard warriorSelected.isAlive else {
                print("\n⏹ You can't attack a dead warrior 😵")
                continue
            }
            
            return warriorSelected
        }
    }
    
    // Method to target an ally
    func targetAnAlly() -> Warrior {
        let selectionOk: Bool = false
        
        while selectionOk == false {
            print("\nWho to heal ?")
            self.printListOfWarriors()
            
            guard let allySelected = getUserInputAsInt() else {
                printErrorsMessages(message: .enterANumber)
                continue
            }
                    
            guard 1...warriors.count ~= allySelected else {
                print("⛔️ Enter a number between 1 and \(warriors.count)")
                continue
            }
            
            let warriorSelected: Warrior
            
            switch allySelected {
            case 1:
                warriorSelected = self.warriors[0]
            case 2:
                warriorSelected = self.warriors[1]
            case 3:
                warriorSelected = self.warriors[2]
            default:
                continue
            }
            
            guard !warriorSelected.hasMaxHP else {
                print("You cannot Heal this ally because his health points is over the limit authorized❗️\n")
                continue
            }
            
            guard warriorSelected.isAlive else {
                print("\n❌ This warrior is dead ⚱️")
                continue
            }
            
            return warriorSelected
        }
    }
    
    // Method to heal an ally
    func heal(from warrior1: Warrior, to warrior2: Warrior) {
            print("\n⛑ \(warrior1.name.uppercased()) heals \(warrior2.name.uppercased())❗️")
            warrior2.lifePoints += warrior1.attackPoints + warrior1.weapon.damage
        if warrior1.attackPoints + warrior1.weapon.damage + warrior2.lifePoints >= warrior2.maxHP {
            warrior2.lifePoints = warrior2.maxHP
        }
    
    }
    
    // Method to attack an enemy
    func attack(from warrior1: Warrior, to warrior2: Warrior) {
        print("\n💥 \(warrior1.name.uppercased()) attacks \(warrior2.name.uppercased())❗️")
        if warrior1.attackPoints + warrior1.weapon.damage > warrior2.lifePoints {
            warrior2.lifePoints = 0
            print("⚰️ \(warrior2.name.uppercased()) is dead❗️")
        } else {
            warrior2.lifePoints -= warrior1.attackPoints + warrior1.weapon.damage
        }
    }
    
    // MARK: - Private methods
    
    // Method to print players' warriors
    private func printWarriorsAvailable() {
        for (index, warriorType) in WarriorType.allCases.enumerated() {
            print("\(index + 1) \(warriorType)")
        }
    }
    
    // Method to print the instruction to create a warrior
    private func printCreateSingleWarriorInstruction() {
        printPlayerName()
        print("Choose your warrior n°\(warriors.count + 1) :")
    }
    
    // Method to select the warrior's type
    private func selectWarriorType() -> Int {
        let selectionOk: Bool = false
        printCreateSingleWarriorInstruction()
        printWarriorsAvailable()
        
        while selectionOk == false {
            guard let choiceString = readLine() else {
                printErrorsMessages(message: .error)
                continue
            }
            
            guard let choiceInt = Int(choiceString) else {
                printErrorsMessages(message: .enterANumber)
                continue
            }
            
            guard 1...WarriorType.allCases.count ~= choiceInt else {
                print("⛔️ Your number must be between 1 and \(WarriorType.allCases.count)")
                continue
            }
            return choiceInt
        }
    }

    // Method to check if the name of the warrior is not already taken
    private func checkName(inputName: String, warriorNames: [String], opponentPlayer: Player) -> Bool {
        
        let allWarriorsNames = warriorNames + opponentPlayer.warriorsNames
        
        for warriorName in allWarriorsNames {
            guard inputName != warriorName else {
                print("⛔️ Name already taken")
                return true
            }
            
        }
        
        return false
    }
    
    private func checkIfNameIsAlreadyUsed(by player: Player) {
        
    }
    
    // Method to print the warriors list
    func printListOfWarriors() {
        for (index, warrior) in warriors.enumerated() {
            print("\(index + 1). 👤 \(warrior.name.uppercased()) \(showTheHealth(warrior: warrior)) 💪 \(warrior.attackPoints) 🗡 \(type(of: warrior.weapon))")
        }
    }
    
    func showTheHealth(warrior: Warrior) -> String {
        
        if warrior.lifePoints > 0 && warrior.lifePoints <= 33 {
            return warrior.hasLowLife
        } else if warrior.lifePoints > 33 && warrior.lifePoints <= 67 {
            return warrior.hasMediumLife
        } else if warrior.lifePoints > 67 {
            return warrior.hasHighLife
        } else {
            return warrior.has0HP
        }
    }
    // Method to print the players' names
    func printPlayerName() {
        print("\n➡️ \(self.name.uppercased())")
    }
    
    
    // Method to print the messages often used
    private func printErrorsMessages(message: Message) {
        switch message {
        case .enterANumber:
            print(message.rawValue)
        case .error:
            print(message.rawValue)
        }
    }
    
    // Method to get an input as a int
    private func getUserInputAsInt() -> Int? {
        
        guard let strData = readLine() else {
            return nil
        }
        
        guard let intData = Int(strData) else {
            return nil
        }
        
        return intData
    }
    
}
