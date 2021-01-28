//
//  BurgerModel.swift
//  BurgerRecipe
//
//  Created by Gregor Pichler on 25.01.20.
//  Copyright © 2020 Gregor Pichler. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class BurgerModel {
    
    private(set) var burgers: [Burger] = []
    
    let context: NSManagedObjectContext
    
    init() {
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            burgers = try context.fetch(Burger.fetchRequest())
        } catch {
            print(error)
        }
    }
    
    func refresh() {
        burgers = (try? context.fetch(Burger.fetchRequest())) ?? []
    }
    
    func burgers(forType type: BurgerType?) -> [Burger] {
        guard let type = type else { return burgers }
        return burgers.filter { $0.burgerType == type.rawValue }
    }
    
    func add(burger: Burger) {
        burgers.append(burger)
        try? context.save()
    }
}
