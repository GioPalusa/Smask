//
//  DataService.swift
//  Smask
//
//  Created by Giovanni Palusa on 2017-09-13.
//  Copyright © 2017 Giovanni Palusa. All rights reserved.
//

import Foundation
import Firebase

var chosenCategory : String = "fika"

class DataService {
    
    static let instance = DataService()
    
    func getDatafromFIR(handler: @escaping (_ recepies : [Recipe]) -> ()) {
        var recipesArray = [Recipe]()
        FIR_REF_CHOSEN_CATEGORY.observeSingleEvent(of: .value) { (recipeSnapshot) in
            guard let recipeSnapshot = recipeSnapshot.children.allObjects as? [DataSnapshot]
                else { return  }
            for recipe in recipeSnapshot {
                let favourite = recipe.childSnapshot(forPath: "favourite").value as! Bool
                let title = recipe.childSnapshot(forPath: "title").value as! String
                let howTo = recipe.childSnapshot(forPath: "howTo").value as! String
                let ingredients = recipe.childSnapshot(forPath: "ingredients").value as! String
                let time = recipe.childSnapshot(forPath: "time").value as! String
                let icon = recipe.childSnapshot(forPath: "icon").value as! String
                let recipeObject = Recipe(title: title, favourite: favourite, time: time, howto: howTo, ingredients: ingredients, icon: icon)
                recipesArray.append(recipeObject)
            }
            handler(recipesArray)
        }
    }
    
    func createTestData() {
        let testRecept = Recipe(title: "Äppelpaj", favourite: false, time: "15-20", howto: "Do stuff", ingredients: "1 potato, 2 potato", icon: "bun")
        let object : [String : Any] = ["favourite": testRecept.favourite, "howTo": testRecept.howTo, "ingredients": testRecept.ingredients, "time": testRecept.time, "title": testRecept.title]
        
        // Post test data
        _ = FIR_REF_CHOSEN_CATEGORY.child(FIR_REF.childByAutoId().key).setValue(object)
    }
}

