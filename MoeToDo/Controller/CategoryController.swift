//
//  ViewController.swift
//  MoeToDo
//
//  Created by Mohamed Aboghali on 1/7/20.
//  Copyright © 2020 Mohamed Aboghali. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit

class CategoryController: UITableViewController,SwipeTableViewCellDelegate {
   
    

    var CategoryArray :Results<Categories>?
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 70
        
        CategoryArray = realm.objects(Categories.self)
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int {
            
        return CategoryArray?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
    
        
        cell.textLabel?.text = CategoryArray?[indexPath.row].name ?? "No Category Added yet"
    
        return cell
    }
    
 
        func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
            guard orientation == .right else { return nil }

            let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
                do {
                    try self.realm.write {
                        self.realm.delete((self.CategoryArray?[indexPath.row])!)
                    }
                }catch{
                    print(error)
                }
            }

            // customize the action appearance
            deleteAction.image = UIImage(named: "delete")

            return [deleteAction]
        }
  
        
        
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "GoToItems", sender: self)
        
        
        
    }
   
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "GoToItems" {
            
            let destinationVc = segue.destination as! ItemViewController
            
            if let indexPath = tableView.indexPathForSelectedRow {
                
                destinationVc.selectedCategory = CategoryArray?[indexPath.row]
                
            }
            
            
            
            
        }
    }
    
    
  
    

    
    
    
    
    

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
       
        var IntermediateCategoryText = UITextField()
        
        let alert = UIAlertController(title: "Add new Category", message: nil, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory = Categories()
            
            newCategory.name = IntermediateCategoryText.text!
            
            do {
                try self.realm.write {
                    self.realm.add(newCategory)
                    }
              
            }catch{
                print(error)
            }
            
            self.tableView.reloadData()
            
        }
        
        alert.addAction(action)
        
        alert.addTextField { (textField) in
            
            IntermediateCategoryText = textField
            
            
        }
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
    
}

extension CategoryController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        CategoryArray = CategoryArray?.filter(NSPredicate(format: "name CONTAINS[cd] %@", searchBar.text!))
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text?.count == 0 {
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
                self.CategoryArray = self.realm.objects(Categories.self)
                self.tableView.reloadData()
            }
        }
        
    }
    
    
}
