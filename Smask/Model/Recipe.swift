//
//  Recepie.swift
//  Smask
//
//  Created by Giovanni Palusa on 2017-09-12.
//  Copyright © 2017 Giovanni Palusa. All rights reserved.
//

import Foundation

class Recipe {
    
    private var _title: String
    private var _favourite: Bool
    private var _time: String
    private var _ingredients: String
    private var _howTo: String
    private var _icon: String
    
    init(title: String, favourite: Bool, time: String, howto: String, ingredients: String, icon: String) {
        self._title = title
        self._favourite = favourite
        self._time = time
        self._howTo = howto
        self._ingredients = ingredients
        self._icon = icon
    }
    
    var title : String {
        return _title
    }
    
    var favourite : Bool {
        return _favourite
    }
    
    var time : String {
        return _time
    }
    
    var howTo : String {
        return _howTo
    }
    
    var ingredients : String {
        return _ingredients
    }
    
    var icon : String {
        return _icon
    }
}
