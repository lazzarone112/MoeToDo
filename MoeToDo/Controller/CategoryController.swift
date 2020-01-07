//
//  ViewController.swift
//  MoeToDo
//
//  Created by Mohamed Aboghali on 1/7/20.
//  Copyright © 2020 Mohamed Aboghali. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryController: UITableViewController {

    var categories :Results<Category>?
    
    let realm = try! Realm()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      loadCategory()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name   ?? "No Category Added Yet"
         
         
        return cell
        
        
        
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoToItems", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
      if  let indexPath = tableView.indexPathForSelectedRow {
        
        
        let destinationvc = segue.destination as! ItemViewController
               
        destinationvc.selectedCategory = categories?[indexPath.row]
       
        }
        
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textWaseet = UITextField()
        
        let alert = UIAlertController(title: "Add Category", message: "Pick a name for You Category", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
    let newCategory = Category()
            
            newCategory.name = textWaseet.text!
            
            do{
                try self.realm.write {
                   
                    self.realm.add(newCategory)
                    
                }
            }catch{
                print (error)
            }
            self.loadCategory()
        }
        
        alert.addAction(action)
        
        alert.addTextField { (textField) in
            
            textField.placeholder = "here.."
            textWaseet = textField
            
        }
        
        present(alert, animated: true, completion: nil)
        
        tableView.reloadData()
    }
    
    func loadCategory(){
        
        categories = realm.objects(Category.self)
        
        tableView.reloadData()
    }
    
}

