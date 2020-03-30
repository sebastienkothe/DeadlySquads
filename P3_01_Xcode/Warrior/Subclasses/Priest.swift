//
//  Priest.swift
//  P3_01_Xcode
//
//  Created by Sébastien Kothé on 11/03/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import Foundation

class Priest : Warrior {
    
     // MARK: Internals methods
    
    func makeAGreatHeal(at warrior: Warrior) {
        
        guard chanceToMakeAGreatHeal == numberToUnlockTheGreatHeal else {
            return
        }
        
        print("\n🧑‍⚕️ \(self.name) cast a great heal (+ \(amountOfGreatHeal) HP) 🙌")
        warrior.lifePoints += amountOfGreatHeal
    }
    
    // MARK: - Private properties
    
    private let numberToUnlockTheGreatHeal = 1
    private let chanceToMakeAGreatHeal = Int.random(in: 1...1)
    
    private let amountOfGreatHeal = 60
    
}
