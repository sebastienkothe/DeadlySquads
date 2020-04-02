//
//  Warrior.swift
//  P3_01_Xcode
//
//  Created by Sébastien Kothé on 10/03/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import Foundation

class Warrior {
    
    init(name: String, attackPoints: Int, weapon: Weapon) {
        self.name = name
        self.attackPoints = attackPoints
        self.weapon = weapon
        lifePoints = maxHP
    }
    
    // MARK: - Internal properties
    
    /// Property to check if the warrior is
    var isFrozen = false
    
    let name: String
    var lifePoints: Int
    var attackPoints: Int
    var weapon: Weapon
    
    var isAlive: Bool {
        lifePoints > 0
    }
    
    var hasMaxHP: Bool {
        lifePoints >= maxHP
    }
    
    // MARK: - Private properties
    
    private var maxHP = 100
    private var minHP = 0
    
    private var isOverheal: Bool {
        lifePoints > maxHP
    }
    
    private var isOverkill: Bool {
        lifePoints < minHP
    }
    
    // MARK: Internals methods
    
    /// Method to attack an enemy
    func attack(_ enemyTargeted: Warrior) {
        
        let regularDamage = self.attackPoints + self.weapon.damage
        enemyTargeted.lifePoints -= regularDamage
        print("\n💥 \(self.name.uppercased()) attacks \(enemyTargeted.name.uppercased()) (- \(regularDamage) HP)❗️")
        
        switch self {
        case is Rogue:
            let rogue = self as! Rogue
            rogue.makeACriticalStrike(to: enemyTargeted)
        case is Mage:
            let mage = self as! Mage
            enemyTargeted.isFrozen = mage.freeze(enemyTargeted)
        case is Hunter:
            let hunter = self as! Hunter
            hunter.callAWildBeast(on: enemyTargeted)
        default:
            break
        }
        
        guard enemyTargeted.isAlive else {
            print("\n⚰️ \(enemyTargeted.name.uppercased()) is dead❗️")
            
            if enemyTargeted.isOverkill {
                print("\n‼️ OVERKILL ‼️\n📊 Excessive damage (+ \(abs(enemyTargeted.lifePoints)))")
                enemyTargeted.lifePoints = minHP
            }
            
            return
        }
        
    }
    
    /// Method to heal an ally
    func heal(_ allyTargeted: Warrior) {
        
        let regularHeal = self.attackPoints + self.weapon.damage
        
        print("\n⛑ \(self.name.uppercased()) heals \(allyTargeted.name.uppercased()) (+ \(regularHeal) HP)❗️")
        allyTargeted.lifePoints += regularHeal
        
        if self is Priest {
            let priest = self as! Priest
            priest.makeAGreatHeal(to: allyTargeted)
        }
        
        guard !allyTargeted.isOverheal else {
            print("\n📈 Excessive heal (+ \(allyTargeted.lifePoints - maxHP))")
            allyTargeted.lifePoints = allyTargeted.maxHP
            
            return
        }
        
    }
}
