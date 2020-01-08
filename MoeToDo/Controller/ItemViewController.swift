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

    let realm = try! Realm()
    
    var ItemsArray : Results<Item>?
    
    var selectedCategory : Category? {
        didSet{
            ItemsArray = self.selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ItemsArray?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
            
        cell.textLabel?.text = ItemsArray?[indexPath.row].title ?? "No Item Added"
            
        if ItemsArray?[indexPath.row].done == true {
            
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
            return cell
            
        }
            
            
        
        
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedItem = ItemsArray?[indexPath.row] {
            do {
                try realm.write {
                    selectedItem.done = !selectedItem.done
                }
            }catch{
                print(error)
            }
        }
        tableView.reloadData()
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textWaseeet = UITextField()
        
        let alert = UIAlertController(title: "Add Item", message: "pick a name for your item", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let newItem = Item()
            newItem.title = textWaseeet.text!
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
            
            textField.placeholder = "here"
            textWaseeet = textField
        }
        
        present(alert, animated: true, completion: nil)
    }
    

    
    
    
}
