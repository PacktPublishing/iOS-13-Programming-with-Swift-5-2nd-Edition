//
//  Burger+CoreDataClass.swift
//  BurgerRecipe
//
//  Created by Gregor Pichler on 23.02.20.
//  Copyright © 2020 Gregor Pichler. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

@objc(Burger)
public class Burger: NSManagedObject {
    
    convenience init(name: String, ingredients: String, image: UIImage? = nil, thumbnail: UIImage? = nil, type: BurgerType, context: NSManagedObjectContext) {
        self.init(entity: Burger.entity(), insertInto: context)
        self.name = name
        self.ingredients = ingredients
        self.image = image?.jpegData(compressionQuality: 1)
        self.thumbnail = thumbnail?.jpegData(compressionQuality: 1)
        self.burgerType = type.rawValue
    }
    
    var thumbnailImage: UIImage? {
        if let data = self.thumbnail {
            return UIImage(data: data)
        } else {
            return nil
        }
    }
    
    var bannerImage: UIImage? {
        if let data = self.image {
            return UIImage(data: data)
        } else {
            return nil
        }
    }

}
