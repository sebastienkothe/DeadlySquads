//
//  Priest.swift
//  P3_01_Xcode
//
//  Created by Sébastien Kothé on 11/03/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import Foundation

class Priest: Warrior {
    
    // MARK: - Internals methods
    
    override func heal(_ allyTargeted: Warrior) {
        super.heal(allyTargeted)
        makeAGreatHeal(to: allyTargeted)
    }
    
    // MARK: - Private properties
    
    private let numberToUnlockTheGreatHeal = 1
    private let chanceToMakeAGreatHeal = Int.random(in: 1...1)
    
    private let amountOfGreatHeal = 60
    
    // MARK: - Private methods
    
    private func makeAGreatHeal(to allyWarrior: Warrior) {
        
        guard chanceToMakeAGreatHeal == numberToUnlockTheGreatHeal else {
            return
        }
        
        print("\n🧑‍⚕️ \(name.uppercased()) cast a great heal to \(allyWarrior.name.uppercased()) (+ \(amountOfGreatHeal) HP) 🙌")
        allyWarrior.lifePoints += amountOfGreatHeal
    }
    
}
