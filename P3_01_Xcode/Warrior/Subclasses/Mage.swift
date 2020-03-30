//
//  Mage.swift
//  P3_01_Xcode
//
//  Created by Sébastien Kothé on 10/03/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import Foundation

class Mage : Warrior {
    
    // MARK: Internals methods
    
    /// Method to freeze an enemy
    func freeze(enemyWarrior: Warrior) -> Bool {
        
        guard chanceToFreezeTheEnemy == numberToUnlockTheFreeze else {
            return false
        }
        
        enemyWarrior.lifePoints -= frostDamage
        print("\n\(self.name) freeze \(enemyWarrior.name) (- \(frostDamage) HP) 🥶")
        return true
    }
    
    // MARK: - Private properties
    
    private let numberToUnlockTheFreeze = 1
    private let chanceToFreezeTheEnemy = Int.random(in: 1...1)
    
    /// Damage output for the special ability
    private let frostDamage = 30
    
}

