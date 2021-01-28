//
//  AddRecipeViewController.swift
//  BurgerRecipe
//
//  Created by Gregor Pichler on 01.02.20.
//  Copyright © 2020 Gregor Pichler. All rights reserved.
//

import UIKit
import CoreData

protocol AddRecipeDelegate {
    func add(burger: Burger)
}

class AddRecipeViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ingredientsTextView: UITextView!
    
    let ingredientsPlaceholder = "Add ingredients"
    
    var delegate: AddRecipeDelegate?
    var context: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientsTextView.text = ingredientsPlaceholder
        ingredientsTextView.delegate = self
    }
    
    @IBAction func didTapCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapSave(_ sender: Any) {
        guard let name = nameTextField.text else { return }
        let newBurger = Burger(name: name, ingredients: ingredientsTextView.text, type: .vegetarian, context: context)
        delegate?.add(burger: newBurger)
        dismiss(animated: true)
    }
    
}

extension AddRecipeViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.tertiaryLabel {
            textView.text = nil
            textView.textColor = UIColor.label
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = ingredientsPlaceholder
            textView.textColor = UIColor.tertiaryLabel
        }
    }
    
    
}
