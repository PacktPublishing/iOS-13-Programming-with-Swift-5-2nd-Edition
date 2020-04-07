//
//  BurgerModel.swift
//  BurgerRecipe
//
//  Created by Gregor Pichler on 25.01.20.
//  Copyright © 2020 Gregor Pichler. All rights reserved.
//

import Foundation

class BurgerModel {
    
    var burgers: [Burger] = []
    
    init() {
        if let url = Bundle.main.url(forResource: "BurgerResources/burgers", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                burgers = try JSONDecoder().decode([Burger].self, from: data)
            } catch {
                print(error)
            }
        }
    }
    
    func burgers(forType type: BurgerType?) -> [Burger] {
        guard let type = type else { return burgers }
        return burgers.filter { $0.type == type }
    }
}
