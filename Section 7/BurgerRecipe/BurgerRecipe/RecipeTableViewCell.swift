//
//  RecipeTableViewCell.swift
//  BurgerRecipe
//
//  Created by Gregor Pichler on 08.02.20.
//  Copyright © 2020 Gregor Pichler. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbnailImageView.layer.cornerRadius = 4
    }
}
