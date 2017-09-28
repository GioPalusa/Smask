//
//  Recepie.swift
//  Smask
//
//  Created by Giovanni Palusa on 2017-09-12.
//  Copyright © 2017 Giovanni Palusa. All rights reserved.
//

import Foundation

class Recipe {
    
    public private(set) var title: String
    public private(set) var favourite: Bool
    public private(set) var time: Int
    public private(set) var ingredients: String
    public private(set) var howTo: String
    public private(set) var icon: String
    public private(set) var key: String
    public private(set) var img: String
    
    init(title: String, favourite: Bool, time: Int, howto: String, ingredients: String, icon: String, key: String, img: String) {
        self.title = title
        self.favourite = favourite
        self.time = time
        self.howTo = howto
        self.ingredients = ingredients
        self.icon = icon
        self.key = key
        self.img = img
    }
}
