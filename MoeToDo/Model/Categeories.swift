//
//  Categ.swift
//  MoeToDo
//
//  Created by Mohamed Aboghali on 1/11/20.
//  Copyright © 2020 Mohamed Aboghali. All rights reserved.
//

import Foundation
import RealmSwift


class Categories:Object {
    
    @objc dynamic var name:String = ""
    
    let items = List<Items>()
}
