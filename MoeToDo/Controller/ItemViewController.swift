//
//  ItemViewController.swift
//  MoeToDo
//
//  Created by Mohamed Aboghali on 1/7/20.
//  Copyright © 2020 Mohamed Aboghali. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit

class ItemViewController: UITableViewController,SwipeTableViewCellDelegate {
    
    var itemArray :Results<Items>?
    
   let realm = try! Realm()
    
    var selectedCategory:Categories? {
        
        didSet{
            
            itemArray = selectedCategory?.items.sorted(byKeyPath: "name", ascending: true)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "xibViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        tableView.rowHeight = 80
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! xibViewCell
        
        cell.delegate = self
        
        cell.name.text = itemArray?[indexPath.row].name ?? "No item added.."
        
      
        cell.chkBox.addTarget(self, action: #selector(checkButtonClicked(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func checkButtonClicked (sender :UIButton){
        if sender.isSelected {
            sender.isSelected = false
        }else{
            sender.isSelected = true
        }
        tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = itemArray?[indexPath.row] {
            do {
                  try realm.write {
                    cell.done = !cell.done
                   }
               }catch{
                   
                   print(error)
               }
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
           
            do {
                try self.realm.write {
                    self.realm.delete((self.itemArray?[indexPath.row])!)
                }
            }catch{
                print(error)
            }
        }

        // customize the action appearance
        deleteAction.image = UIImage(named: "delete")

        return [deleteAction]
    }
    
   func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        
        return options
    }
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var intermediateItemText = UITextField()
        
        let alert = UIAlertController(title: "Add Item", message: nil, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newItem = Items()
            newItem.name = intermediateItemText.text!
            do {
               try self.realm.write {
                self.selectedCategory?.items.append(newItem)
                }
            }catch{
                print(error)
            }
            self.tableView.reloadData()
        
        }
        alert.addAction(action)
        
        alert.addTextField { (textField) in
            
            intermediateItemText =  textField
        }
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
}

extension ItemViewController:UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        itemArray = itemArray?.filter(NSPredicate(format: "name CONTAINS[cd] %@", searchBar.text!))
        tableView.reloadData()
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
                self.itemArray = self.selectedCategory?.items.sorted(byKeyPath: "name", ascending: true)
                self.tableView.reloadData()
            }
        }
    }
    
    
}
