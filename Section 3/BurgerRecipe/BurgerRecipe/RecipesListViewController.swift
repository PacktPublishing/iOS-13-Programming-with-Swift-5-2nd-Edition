//
//  RecipesListViewController.swift
//  BurgerRecipe
//
//  Created by Gregor Pichler on 11.01.20.
//  Copyright © 2020 Gregor Pichler. All rights reserved.
//

import UIKit

class RecipesListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var model = BurgerModel()
    var selectedType: BurgerType?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
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
}

extension RecipesListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.burgers(forType: selectedType).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BurgerCell", for: indexPath)
        let burger = model.burgers(forType: selectedType)[indexPath.row]
        
        cell.textLabel?.text = burger.name
        cell.detailTextLabel?.text = burger.ingredients
        cell.imageView?.image = UIImage(named: burger.thumbnailName)
        
        return cell
    }
}

extension RecipesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
