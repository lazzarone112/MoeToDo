//
//  ItemViewController.swift
//  MoeToDo
//
//  Created by Mohamed Aboghali on 1/7/20.
//  Copyright © 2020 Mohamed Aboghali. All rights reserved.
//

import UIKit
import RealmSwift


class ItemViewController: UITableViewController {

    
    var ItemsArray = List<Item>()
    
    var selectedCategory : Category? {
        didSet{
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    }
    
}
