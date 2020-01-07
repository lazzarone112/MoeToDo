//
//  Item.swift
//  MoeToDo
//
//  Created by Mohamed Aboghali on 1/7/20.
//  Copyright © 2020 Mohamed Aboghali. All rights reserved.
//

import Foundation
import RealmSwift



class Item:Object {
    
    @objc dynamic var title:String = ""
    
    @objc dynamic var done:Bool = false
    
    let parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
