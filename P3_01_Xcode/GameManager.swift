//
//  GameManager.swift
//  P3_01_Xcode
//
//  Created by Sébastien Kothé on 10/03/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import Foundation


class GameManager {
    var players: [Player] = [] // The array who contains players
    
    public func startNewGame() {
        let player1 = Player() // Creation of the object "player1" from Player()
        players.append(player1) // player1 add to [Player]
        player1.name = "Player 1" // Initialization of player name
        
        let player2 = Player() // Creation of the object "player2" from Player()
        players.append(player2) // Object "player2" add to the array
        player2.name = "Player 2" // Initialization of player name
        
        _ = player1.createWarriors() // 
        _ = player2.createWarriors()
        
        gameManager.prepareTheWarriors(to: player1)
        gameManager.prepareTheWarriors(to: player2)
        
        var gameChecker: Bool = false
        var counter = 0
        
        while gameChecker != true {
            
            let warriorSelectedByP1 = player1.chooseAWarrior()
            bringUpAChest(for: warriorSelectedByP1)
            let targetSelectedByP1 = player1.chooseTarget(enemyPlayer: player2)
            player1.action(from: warriorSelectedByP1, to: targetSelectedByP1, enemyPlayer: player2)
            
            gameChecker = gameManager.checkTheHealthOfTheWarriors(of: player1, and: player2)
            
            if gameChecker {
                print("🏁 Number of laps : \(counter)")
                break
            }
            
            let warriorSelectedByP2 = player2.chooseAWarrior()
            bringUpAChest(for: warriorSelectedByP2)
            let targetSelectedByP2 = player2.chooseTarget(enemyPlayer: player1)
            player2.action(from: warriorSelectedByP2, to: targetSelectedByP2, enemyPlayer: player1)
            
            gameChecker = gameManager.checkTheHealthOfTheWarriors(of: player1, and: player2)
            
            counter += 1
            
            gameChecker = randomlyKillAWarrior(player1, and: player2)
            
            if gameChecker {
                print("🏁 Number of laps : \(counter)")
                
                break
            }
            
            
            
        }
        
    }
    
    func ShowTheTeamMembers(of: Player) {
        var numberOfWarrior = 0
        for warrior in of.warriors {
            numberOfWarrior += 1
            print("\(numberOfWarrior). \(warrior.name.uppercased()) the \(type(of: warrior))")
            // print("He has \(warrior.lifePoints) life points, \(warrior.attackPoints) attack points and his weapon is a \(type(of: warrior.weapon))")
            
        }
        GameManager.printTheMessage(message: .lineBreak)
    }
    
    
    static func getUserInputAsInt() -> Int {
        let strData = readLine();
        
        return Int(strData!)!
    }
    
    func getUserInputAsString() -> String {
        let strData = readLine();
        
        return strData!
    }
    
    static func getUserInput() -> String {
        let input = readLine()
        if input != nil {
            return input!
        }
        return "David"
    }
    
    func prepareTheWarriors(to theArrayOf: Player) {
        for warrior in theArrayOf.warriors {
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
    
    func checkTheHealthOfTheWarriors(of player1: Player, and player2: Player) -> Bool {
        
        var x = 0
        for warrior in player1.warriors {
            
            if warrior.lifePoints <= 0 {
                player1.warriors.remove(at: x)
                GameManager.printTheMessage(message: .death)
                print("\(warrior.name.uppercased()) is dead ! ⚰️")
                GameManager.printTheMessage(message: .lineBreak)
            }
            x += 1
        }
        
        var y = 0
        for warrior in player2.warriors {
            
            if warrior.lifePoints <= 0 {
                player2.warriors.remove(at: y)
                GameManager.printTheMessage(message: .death)
                print("\(warrior.name.uppercased()) is dead ! ⚰️")
                GameManager.printTheMessage(message: .lineBreak)
            }
            y += 1
        }
        
        if player1.warriors.count == 0 {
            GameManager.printTheMessage(message: .gameOver)
            print("🙈 \(player1.name.uppercased()) lost the game...")
            print("\(player2.name.uppercased()) wins❗️")
            
            GameManager.printTheMessage(message: .lineBreak)
            
            print("Remaining warriors of \(player2.name.uppercased()) :")
            for warrior in player2.warriors {
                print("🏋️‍♂️ \(warrior.name.uppercased())")
                print("❤️ \(warrior.lifePoints)")
                print("💪 \(warrior.attackPoints + warrior.weapon.damage)")
                print("🗡 \(type(of: warrior.weapon))")
                GameManager.printTheMessage(message: .lineBreak)
            }
            return gameManager.gameOver()
        }
        
        if player2.warriors.count == 0 {
            GameManager.printTheMessage(message: .gameOver)
            print("🙈 \(player2.name.uppercased()) lost the game...")
            print("\(player1.name.uppercased()) wins❗️")
            
            GameManager.printTheMessage(message: .lineBreak)
            
            print("Remaining warriors of \(player1.name.uppercased()) :")
            for warrior in player1.warriors {
                print("🏋️‍♂️ \(warrior.name.uppercased())")
                print("❤️ \(warrior.lifePoints)")
                print("💪 \(warrior.attackPoints + warrior.weapon.damage)")
                print("🗡 \(type(of: warrior.weapon))")
                GameManager.printTheMessage(message: .lineBreak)
            }
            return gameManager.gameOver()
        }
        
        return false
    }
    
    func gameOver() -> Bool {
        return true
    }
    
    func countLaps(laps: Int) -> Int {
        return laps
    }
    
    func bringUpAChest(for warrior: Warrior) {
        let number = Int.random(in: 0..<5)
        
        if number == 2 {
            GameManager.printTheMessage(message: .lineBreak)
            GameManager.printTheMessage(message: .chest)
            GameManager.printTheMessage(message: .lineBreak)
            print("\(warrior.name.uppercased()) took the weapon inside, its name is : \(TragicFate().name) 😱")
            warrior.weapon = TragicFate()
        }
        
        if number == 3 {
            GameManager.printTheMessage(message: .lineBreak)
            GameManager.printTheMessage(message: .chest)
            GameManager.printTheMessage(message: .lineBreak)
            print("\(warrior.name.uppercased()) took the weapon inside, its name is : \(Axe().name) 😱")
            warrior.weapon = Axe()
        }
    }
    
    func randomName() -> String {
        let length = 6
        let characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let randomCharacters = (0..<length).map{_ in characters.randomElement()!}
        let randomString = String(randomCharacters)
        
        return randomString
    }
    
    func randomlyKillAWarrior(_ player1: Player, and player2: Player) -> Bool {
        
        if player1.warriors.count == 0 || player2.warriors.count == 0 {
            return true
        } else {
            let randomWarriorP1 = Int.random(in: 0..<player1.warriors.count)
            let randomWarriorP2 = Int.random(in: 0..<player2.warriors.count)
            let randomNumber = Int.random(in: 1..<3)
            
            if randomNumber == 1 {
                print("🧟‍♂️ A wandering zombie killed \(player1.warriors[randomWarriorP1].name.uppercased())❗️")
                GameManager.printTheMessage(message: .lineBreak)
                player1.warriors.remove(at: randomWarriorP1)
            }
            
            if randomNumber == 2 {
                print("🧟‍♂️ A wandering zombie killed \(player2.warriors[randomWarriorP2].name.uppercased())❗️")
                GameManager.printTheMessage(message: .lineBreak)
                player2.warriors.remove(at: randomWarriorP2)
            }
            
            if player1.warriors.count == 0 || player2.warriors.count == 0 {
                
                if player1.warriors.count == 0 {
                    GameManager.printTheMessage(message: .gameOver)
                    print("🙈 \(player1.name.uppercased()) lost the game...")
                    print("\(player2.name.uppercased()) wins❗️")
                    
                    GameManager.printTheMessage(message: .lineBreak)
                    
                    print("Remaining warriors of \(player2.name.uppercased()) :")
                    for warrior in player2.warriors {
                        print("🏋️‍♂️ \(warrior.name.uppercased())")
                        print("❤️ \(warrior.lifePoints)")
                        print("💪 \(warrior.attackPoints + warrior.weapon.damage)")
                        print("🗡 \(type(of: warrior.weapon))")
                        GameManager.printTheMessage(message: .lineBreak)
                    }
                }
                
                if player2.warriors.count == 0 {
                    GameManager.printTheMessage(message: .gameOver)
                    print("🙈 \(player2.name.uppercased()) lost the game...")
                    print("\(player1.name.uppercased()) wins❗️")
                    
                    GameManager.printTheMessage(message: .lineBreak)
                    
                    print("Remaining warriors of \(player1.name.uppercased()) :")
                    for warrior in player1.warriors {
                        print("🏋️‍♂️ \(warrior.name.uppercased())")
                        print("❤️ \(warrior.lifePoints)")
                        print("💪 \(warrior.attackPoints + warrior.weapon.damage)")
                        print("🗡 \(type(of: warrior.weapon))")
                        GameManager.printTheMessage(message: .lineBreak)
                    }
                }
                return true
            } // End of main condition
            
            return false
        }
        
    }
    
    static func printTheMessage(message: Message) {
        switch message {
        case .allySelection:
            print("👫 Which ally do you want to select ?")
        case .attack:
            print("⏳ Attack is coming❗️")
        case .chest:
            print("🚨 A chest has just appeared ❗️")
        case .chooseAWarrior:
            print("🗣 Choose your warrior :")
        case .chooseTarget:
            print("🎯 Do you want target an ally or an enemy ?")
            print("1. Ally")
            print("2. Enemy")
        case .death:
            print("😱 Unbelievable 😱")
        case .enemySelection:
            print("🪓 Which enemy do you want to attack ?")
        case .gameOver:
            print("👾 GAME OVER 👾")
        case .heal:
            print("⏳ Heal is coming❗️")
        case .lineBreak:
            print("")
        case .listOfWarriorsAvailable:
            print("1. 🟡 Rogue ")
            print("2. 🔵 Mage ")
            print("3. 🟢 Hunter ")
            print("4. ⚪️ Priest ")
            
        case .nameOfHunter:
            print("✍️ Choose the name of your Hunter :")
        case .nameOfMage:
            print("✍️ Choose the name of your Mage :")
        case .nameOfPriest:
            print("✍️ Choose the name of your Priest :")
        case .nameOfRogue:
            print("✍️ Choose the name of your Rogue :")
            
        case .warriorSelected:
            print("You choosed")
        }
    }
    
}
