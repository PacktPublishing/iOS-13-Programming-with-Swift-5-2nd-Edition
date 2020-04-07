//
//  Burger.swift
//  BurgerRecipe
//
//  Created by Gregor Pichler on 25.01.20.
//  Copyright © 2020 Gregor Pichler. All rights reserved.
//

import Foundation

struct Burger: Decodable {
    var name: String
    var ingredients: String
    var imageName: String
    var thumbnailName: String
    var type: BurgerType
}

enum BurgerType: String, Decodable {
    case vegetarian = "vegetarian"
    case meat = "meat"
}
