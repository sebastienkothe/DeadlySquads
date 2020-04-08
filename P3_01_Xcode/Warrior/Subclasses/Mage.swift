//
//  Mage.swift
//  P3_01_Xcode
//
//  Created by Sébastien Kothé on 10/03/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import Foundation

final class Mage: Warrior {
    
    // MARK: - Internals methods
    
    override func attack(_ enemyTargeted: Warrior) {
        super.attack(enemyTargeted)
        
        if enemyTargeted.isAlive {
            enemyTargeted.isFrozen = freeze(enemyTargeted)
        }
        
    }
    
    // MARK: - Private properties
    
    private let numberToUnlockTheFreeze = 1
    private let chanceToFreezeTheEnemy = Int.random(in: 1...1)
    
    /// Damage output for the special ability
    private let frostDamage = 100
    
    // MARK: - Private methods
    
    /// Method to freeze an enemy
    private func freeze(_ enemyWarrior: Warrior) -> Bool {
        
        guard chanceToFreezeTheEnemy == numberToUnlockTheFreeze else {
            return false
        }
        
        print("\n🥶 \(name.uppercased()) freeze \(enemyWarrior.name.uppercased()) (- \(frostDamage) HP)❗️")
        enemyWarrior.lifePoints -= frostDamage
        
        return true
    }
    
}

