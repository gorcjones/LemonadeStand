//
//  Supplies.swift
//  LemonadeStand
//
//  Created by Ryan Jones on 5/25/15.
//  Copyright (c) 2015 Ryan Jones. All rights reserved.
//

import Foundation

struct Supplies {
    var money = 0
    var lemons = 0
    var iceCubes = 0
    
    init (aMoney: Int, aLemons: Int, aIceCubes: Int) {
        money = aMoney
        lemons = aLemons
        iceCubes = aIceCubes
    }
}