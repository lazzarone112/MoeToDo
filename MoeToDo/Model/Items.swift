//
//  Items.swift
//  MoeToDo
//
//  Created by Mohamed Aboghali on 1/11/20.
//  Copyright © 2020 Mohamed Aboghali. All rights reserved.
//

import Foundation
import RealmSwift


class Items:Object {
    
    @objc dynamic var name:String = ""
    
    @objc dynamic var done:Bool = false
    
    let parentCategory = LinkingObjects(fromType: Categories.self, property: "items")
    
}
