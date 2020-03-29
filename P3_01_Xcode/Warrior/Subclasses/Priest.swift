//
//  Priest.swift
//  P3_01_Xcode
//
//  Created by Sébastien Kothé on 11/03/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import Foundation

class Priest : Warrior {
    let numberToUnlockTheGreatHeal = 1
    let chanceToMakeAGreatHeal = Int.random(in: 1...1)
    
    let amountOfGreatHeal = 60
    
    func makeAGreatHeal(at warrior: Warrior) {
        
        guard chanceToMakeAGreatHeal == numberToUnlockTheGreatHeal else {
            return
        }
        
        print("\n🧑‍⚕️ \(self.name) cast a great heal (+ \(amountOfGreatHeal) HP) 🙌")
        warrior.lifePoints += amountOfGreatHeal
    }
}
