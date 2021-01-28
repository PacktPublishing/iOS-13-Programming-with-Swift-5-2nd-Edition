//
//  RecipesListViewController.swift
//  BurgerRecipe
//
//  Created by Gregor Pichler on 11.01.20.
//  Copyright © 2020 Gregor Pichler. All rights reserved.
//

import UIKit

protocol RecipeSelectionDelegate: class {
    func burgerSelected(_ burger: Burger)
}

class RecipesListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var model = BurgerModel()
    var selectedType: BurgerType?
    
    weak var delegate: RecipeSelectionDelegate?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(UINib(nibName: "RecipeTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "BurgerCell")
        
        #if targetEnvironment(macCatalyst)
        navigationController?.navigationBar.isTranslucent = false
        #endif
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: .NSManagedObjectContextObjectsDidChange, object: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addRecipe" {
            let navVC = segue.destination as? UINavigationController
            let addVC = navVC?.viewControllers.first as? AddRecipeViewController
            addVC?.delegate = self
            addVC?.context = model.context
        }
    }
    
    @IBAction func didChangeFilter(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            selectedType = nil
        case 1:
            selectedType = .meat
        case 2:
            selectedType = .vegetarian
        default:
            break
        }
        
        tableView.reloadData()
    }
    
    @objc func reload() {
        model.refresh()
        DispatchQueue.main.async {
            self.tableView.reloadData()            
        }
    }
}

extension RecipesListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.burgers(forType: selectedType).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BurgerCell", for: indexPath) as! RecipeTableViewCell
        let burger = model.burgers(forType: selectedType)[indexPath.row]
        
        cell.nameLabel.text = burger.name
        cell.ingredientsLabel.text = burger.ingredients
        cell.thumbnailImageView.image = burger.thumbnailImage
        
        return cell
    }
}

extension RecipesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let burger = model.burgers[indexPath.row]
        delegate?.burgerSelected(burger)
        
        if let detailVC = delegate as? RecipeDetailViewController {
            splitViewController?.showDetailViewController(detailVC, sender: nil)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension RecipesListViewController: AddRecipeDelegate {
    func add(burger: Burger) {
        model.add(burger: burger)
        tableView.reloadData()
    }
}
