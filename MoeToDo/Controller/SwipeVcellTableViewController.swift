//
//  SwipeVcellTableViewController.swift
//  MoeToDo
//
//  Created by Mohamed Aboghali on 1/14/20.
//  Copyright © 2020 Mohamed Aboghali. All rights reserved.
//

import UIKit
import SwipeCellKit

class SwipeVcellTableViewController: UITableViewController,SwipeTableViewCellDelegate {
    
    
    
  

    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
        
        cell.delegate = self
        return cell
        
    }

        func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
                guard orientation == .right else { return nil }

                let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
                    
                    self.updateSuperModel(at: indexPath)
                    
            }
                // customize the action appearance
                deleteAction.image = UIImage(named: "Trash Icon")

                return [deleteAction]
             }
          func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
              var options = SwipeOptions()
              options.expansionStyle = .destructive
             
              return options
          }
  
    func updateSuperModel(at indexPath:IndexPath) {
        
    }
}
