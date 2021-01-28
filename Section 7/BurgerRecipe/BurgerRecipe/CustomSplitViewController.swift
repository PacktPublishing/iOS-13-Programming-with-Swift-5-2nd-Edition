//
//  CustomSplitViewController.swift
//  BurgerRecipe
//
//  Created by Gregor Pichler on 15.02.20.
//  Copyright © 2020 Gregor Pichler. All rights reserved.
//

import UIKit

class CustomSplitViewController: UISplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        preferredDisplayMode = .allVisible
        self.delegate = self
    }
}

extension CustomSplitViewController: UISplitViewControllerDelegate {
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
    
}
