//
//  Warrior.swift
//  P3_01_Xcode
//
//  Created by Sébastien Kothé on 10/03/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import Foundation

class Warrior {
    let name: String
    var lifePoints: Int = 100
    var attackPoints: Int = 60
    var weapon: Weapon = Bow()
    
    var isAlive: Bool {
        lifePoints > 0
    }
    
    var maxHP = 100
    
    var hasMaxHP: Bool {
        lifePoints >= maxHP
    }
    
    init(name: String) {
        self.name = name
    }
}
