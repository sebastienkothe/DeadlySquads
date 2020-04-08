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
    
    var lifePoints: Int {
        
        didSet {
            
            if !isAlive {
                print("\n⚰️ \(name.uppercased()) is dead❗️")
            }
            
            if isOverkill {
                print("\n📊 Excessive damage (+ \(abs(lifePoints)))")
                lifePoints = minHP
            }
            
            if isOverheal {
                print("\n📈 Excessive heal (+ \(lifePoints - maxHP))")
                lifePoints = maxHP
            }
            
        }
        
    }
    
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
    
    // MARK: - Internals methods
    
    /// Method to attack an enemy
    func attack(_ enemyTargeted: Warrior) {
        
        let regularDamage = attackPoints + weapon.damage
        
        print("\n💥 \(name.uppercased()) attacks \(enemyTargeted.name.uppercased()) (- \(regularDamage) HP)❗️")
        enemyTargeted.lifePoints -= regularDamage
    }
    
    /// Method to heal an ally
    func heal(_ allyTargeted: Warrior) {
        
        let regularHeal = attackPoints + weapon.damage
        
        print("\n⛑ \(name.uppercased()) heals \(allyTargeted.name.uppercased()) (+ \(regularHeal) HP)❗️")
        allyTargeted.lifePoints += regularHeal
        
    }
    
}
