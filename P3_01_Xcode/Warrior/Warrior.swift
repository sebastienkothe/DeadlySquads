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
    
    var isFreeze = false
    
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
    
    // MARK: Internals methods
    
    /// Method to attack an enemy
    func attack(_ warrior2: Warrior) {
        
        let regularDamage = self.attackPoints + self.weapon.damage
        warrior2.lifePoints -= regularDamage
        print("\n💥 \(self.name.uppercased()) attacks \(warrior2.name.uppercased()) (- \(regularDamage) HP)❗️")
        
        switch self {
        case is Rogue:
            let rogue = self as! Rogue
            rogue.makeACriticalStrike(to: warrior2)
        case is Mage:
            let mage = self as! Mage
            warrior2.isFreeze = mage.freeze(enemyWarrior: warrior2)
        case is Hunter:
            let hunter = self as! Hunter
            hunter.callAWildBeast(to: warrior2)
        default:
            break
        }
        
        guard warrior2.isAlive else {
            print("\n⚰️ \(warrior2.name.uppercased()) is dead❗️")
            
            if warrior2.lifePoints < minHP {
                print("\n‼️ OVERKILL ‼️\n📊 Excessive damage (+ \(abs(warrior2.lifePoints)))")
                warrior2.lifePoints = minHP
            }
            
            return
        }
        
    }
    
    /// Method to heal an ally
    func heal(_ warrior2: Warrior) {
        
        let regularHeal = self.attackPoints + self.weapon.damage
        
        print("\n⛑ \(self.name.uppercased()) heals \(warrior2.name.uppercased()) (+ \(regularHeal) HP)❗️")
        warrior2.lifePoints += regularHeal
        
        if self is Priest {
            let priest = self as! Priest
            priest.makeAGreatHeal(at: warrior2)
        }
        
        guard warrior2.lifePoints < maxHP else {
            
            if warrior2.lifePoints > maxHP {
                print("\n📈 Excessive heal (+ \(warrior2.lifePoints - maxHP))")
                warrior2.lifePoints = warrior2.maxHP
            }
            
            return
        }
    }
}
