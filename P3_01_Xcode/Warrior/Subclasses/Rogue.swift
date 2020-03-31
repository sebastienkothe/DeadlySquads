//
//  Rogue.swift
//  P3_01_Xcode
//
//  Created by Sébastien Kothé on 10/03/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import Foundation

class Rogue : Warrior {
    
    // MARK: Internals methods
    
    /// Method to handle the critical strikes
    func makeACriticalStrike(to enemyWarrior: Warrior) {
        let criticalStrikeDamage = self.weapon.damage * 3
        
        guard chanceToMakeACriticalStrike == numberToUnlockTheCriticalStrike else {
            return
        }
        
        print("\n🙀 \(self.name.uppercased()) makes a critical strike to \(enemyWarrior.name.uppercased()) (- \(criticalStrikeDamage) HP) 🤯")
        enemyWarrior.lifePoints -= criticalStrikeDamage
    }
    
    // MARK: - Private properties
    
    private let numberToUnlockTheCriticalStrike = 1
    private let chanceToMakeACriticalStrike = Int.random(in: 1...1)
    
}
