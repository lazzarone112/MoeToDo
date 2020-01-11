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
    
    var itemArray :Results<Items>?
    
   let realm = try! Realm()
    
    var selectedCategory:Categories? {
        
        didSet{
            
            itemArray = selectedCategory?.items.sorted(byKeyPath: "name", ascending: true)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray?[indexPath.row].name ?? "No item added.."
        
        if itemArray?[indexPath.row].done == true {
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        
        return cell
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
    
}
