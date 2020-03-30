//
//  Hunter.swift
//  P3_01_Xcode
//
//  Created by Sébastien Kothé on 10/03/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import Foundation

class Hunter : Warrior {
    
    // MARK: Internals methods
    
    func callAWildBeast(to enemyWarrior: Warrior) {
        
        guard chanceToCallABeast == numberToUnlockTheCall else {
            return
        }
        
        enemyWarrior.lifePoints -= beastDamage
        print("\n\(self.name) dropped a wild beast on \(enemyWarrior.name) (- \(beastDamage) HP) 🐊")
        
    }
    
    // MARK: - Private properties
    
    private let numberToUnlockTheCall = 1
    private let chanceToCallABeast = Int.random(in: 1...1)
    
    private let beastDamage = 40
    
}
