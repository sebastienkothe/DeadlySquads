//
//  Hunter.swift
//  P3_01_Xcode
//
//  Created by Sébastien Kothé on 10/03/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import Foundation

class Hunter: Warrior {
    
    // MARK: Internals methods
    
    override func attack(_ enemyTargeted: Warrior) {
        super.attack(enemyTargeted)
        
        if enemyTargeted.isAlive {
            callAWildBeast(on: enemyTargeted)
        }
        
    }
    
    // MARK: - Private properties
    
    private let numberToUnlockTheCall = 1
    private let chanceToCallABeast = Int.random(in: 1...1)
    
    private let beastDamage = 100
    
    // MARK: - Private methods
    
    private func callAWildBeast(on enemyWarrior: Warrior) {
        
        guard chanceToCallABeast == numberToUnlockTheCall else {
            return
        }
        
        print("\n🐊 \(name.uppercased()) cast［callAWildBeast］on \(enemyWarrior.name.uppercased()) (- \(beastDamage) HP)❗️")
        enemyWarrior.lifePoints -= beastDamage
        
    }
    
}
