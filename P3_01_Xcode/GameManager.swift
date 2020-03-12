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
    
    public func startNewGame() {
        let player1 = Player()
        players.append(player1)
        player1.name = "Player 1"
        
        let player2 = Player()
        players.append(player2)
        player2.name = "Player 2"
        
        _ = player1.createWarriors()
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
            
            gameChecker = gameManager.checkTheHealthOfTheWarriors(of: player2, enemyPlayer: player1)
            
            if gameChecker {
                print("🏁 Number of laps : \(counter)")
                break
            }
            
            gameChecker = gameManager.checkTheHealthOfTheWarriors(of: player1, enemyPlayer: player2)
            
            if gameChecker {
                print("🏁 Number of laps : \(counter)")
                break
            }
            
            let warriorSelectedByP2 = player2.chooseAWarrior()
            bringUpAChest(for: warriorSelectedByP2)
            let targetSelectedByP2 = player2.chooseTarget(enemyPlayer: player1)
            player2.action(from: warriorSelectedByP2, to: targetSelectedByP2, enemyPlayer: player1)
            
            gameChecker = gameManager.checkTheHealthOfTheWarriors(of: player1, enemyPlayer: player2)
            
            counter += 1
            
            if gameChecker {
                print("🏁 Number of laps : \(counter)")
                break
            }
            
            gameChecker = gameManager.checkTheHealthOfTheWarriors(of: player2, enemyPlayer: player1)
        }
        
    }
    
    func ShowTheTeamMembers(of: Player) {
        var numberOfWarrior = 0
        for warrior in of.warriors {
            numberOfWarrior += 1
            print("\(numberOfWarrior). \(warrior.name) the \(type(of: warrior))")
            // print("He has \(warrior.lifePoints) life points, \(warrior.attackPoints) attack points and his weapon is a \(type(of: warrior.weapon))")
            
        }
        print("")
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
    
    func checkTheHealthOfTheWarriors(of fromTheArray: Player, enemyPlayer: Player) -> Bool {
        
        var i = 0
        for warrior in fromTheArray.warriors{
            
            if warrior.lifePoints <= 0 {
                fromTheArray.warriors.remove(at: i)
                print("😱 Unbelievable 😱")
                print("\(warrior.name) is dead ! ⚰️")
                print("")
            }
            i += 1
        }
        
        if fromTheArray.warriors.count == 0 {
            print("GAME OVER")
            print("🙈 \(fromTheArray.name) lost the game...")
            print("\(enemyPlayer.name) wins❗️")
            
            print("")
            
            print("Remaining warriors of \(enemyPlayer.name) :")
            for warrior in enemyPlayer.warriors {
                print("🏋️‍♂️ \(warrior.name)")
                print("❤️ \(warrior.lifePoints)")
                print("💪 \(warrior.attackPoints + warrior.weapon.damage)")
                print("🗡 \(type(of: warrior.weapon))")
                print("")
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
        let number = Int.random(in: 0 ..< 5)
        
        if number == 2 {
            print("")
            print("🚨 A chest has just appeared ❗️")
            print("")
            print("\(warrior.name) took the weapon inside, its name is : \(TragicFate.name) 😱")
            warrior.weapon = TragicFate()
        }
        
        if number == 3 {
            print("")
            print("🚨 A chest has just appeared ❗️")
            print("")
            print("\(warrior.name) took the weapon inside, its name is : \(Axe.name) 😱")
            warrior.weapon = Axe()
        }
    }
    
}
