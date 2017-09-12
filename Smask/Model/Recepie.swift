//
//  Recepie.swift
//  Smask
//
//  Created by Giovanni Palusa on 2017-09-12.
//  Copyright © 2017 Giovanni Palusa. All rights reserved.
//

import Foundation

class Recepie {
    
    var title: String
    var favourite: Bool
    var time: String
    var ingredients: String
    var howTo: String
    
    init(title: String) {
        self.title = title
        self.favourite = false
        self.time = ""
        self.howTo = ""
        self.ingredients = ""
    }
}
