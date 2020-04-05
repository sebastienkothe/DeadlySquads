//
//  Rogue.swift
//  P3_01_Xcode
//
//  Created by Sébastien Kothé on 10/03/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import Foundation

class Rogue: Warrior {
    
    // MARK: - Internals methods
    
    override func attack(_ enemyTargeted: Warrior) {
        super.attack(enemyTargeted)
        
        if enemyTargeted.isAlive {
            makeACriticalStrike(to: enemyTargeted)
        }
    }
    
    // MARK: - Private properties
    
    private let numberToUnlockTheCriticalStrike = 1
    private let chanceToMakeACriticalStrike = Int.random(in: 1...1)
    
    // MARK: - Private methods
    
    private func makeACriticalStrike(to enemyWarrior: Warrior) {
        
        let criticalStrikeDamage = weapon.damage * 10
        
        guard chanceToMakeACriticalStrike == numberToUnlockTheCriticalStrike else {
            return
        }
        
        print("\n🙀 \(name.uppercased()) makes a critical strike to \(enemyWarrior.name.uppercased()) (- \(criticalStrikeDamage) HP) 🤯")
        enemyWarrior.lifePoints -= criticalStrikeDamage
    }
    
}
