//
//  FavouritesViewController.swift
//  BurgerRecipe
//
//  Created by Gregor Pichler on 11.01.20.
//  Copyright © 2020 Gregor Pichler. All rights reserved.
//

import UIKit
import CoreData

class FavouritesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var resultsController: NSFetchedResultsController<Burger>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "RecipeTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "BurgerCell")
        tableView.dataSource = self
        
        if resultsController == nil {
            let request: NSFetchRequest<Burger> = Burger.fetchRequest()
            let predicate = NSPredicate(format: "favourite == true")
            let sort = NSSortDescriptor(key: "name", ascending: true)
            request.sortDescriptors = [sort]
            request.predicate = predicate
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            resultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            resultsController.delegate = self
            
            do {
                try resultsController.performFetch()
                tableView.reloadData()
            } catch {
                print(error)
            }
        }
    }
}

extension FavouritesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsController.fetchedObjects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BurgerCell", for: indexPath) as! RecipeTableViewCell
        let burger = resultsController.object(at: indexPath)
        
        cell.nameLabel.text = burger.name
        cell.ingredientsLabel.text = burger.ingredients
        cell.thumbnailImageView.image = burger.thumbnailImage
        
        return cell
    }
}

extension FavouritesViewController: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        tableView.reloadData()
    }
    
}
