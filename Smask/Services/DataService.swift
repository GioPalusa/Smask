//
//  DataService.swift
//  Smask
//
//  Created by Giovanni Palusa on 2017-09-13.
//  Copyright © 2017 Giovanni Palusa. All rights reserved.
//

import Foundation
import Firebase

// Standard value when the app starts
var chosenCategory : String = "allRecipes"
var sortingChoice : String = "icon"

class DataService {
    
    static let instance = DataService()
    
    // Using @escaping because if the function is not fully run, then escape
    // Added sorting (.queryOrdered) that sorts the data to the users needs
    // Take a snapshot of the firebase node
    // Loop through every child and create an array of objects with recipes inside
    func getDatafromFIR(handler: @escaping (_ recipes : [Recipe]) -> ()) {
        var recipesArray = [Recipe]()
        FIR_REF_CATEGORIES.child(chosenCategory).queryOrdered(byChild: sortingChoice).observeSingleEvent(of: .value) { (recipeSnapshot) in
            guard let recipeSnapshot = recipeSnapshot.children.allObjects as? [DataSnapshot]
                else { return }
            for recipe in recipeSnapshot {
                let key = recipe.key 
                let favourite = recipe.childSnapshot(forPath: "favourite").value as! Bool
                let title = recipe.childSnapshot(forPath: "title").value as! String
                let howTo = recipe.childSnapshot(forPath: "howTo").value as! String
                let ingredients = recipe.childSnapshot(forPath: "ingredients").value as! String
                let time = recipe.childSnapshot(forPath: "time").value as! Int
                let icon = recipe.childSnapshot(forPath: "icon").value as! String
                let recipeObject = Recipe(title: title, favourite: favourite, time: time, howto: howTo, ingredients: ingredients, icon: icon, key: key, img: "")
                recipesArray.append(recipeObject)
            }
            handler(recipesArray)
        }
    }
}

// Remove data from Firebase (Data and Images)
func removeDataFromFIR(key : String) {
    FIR_REF_CATEGORIES.child("allRecipes").child(key).setValue(nil)
    
    for (_, element) in CATEGORIES.enumerated() {
        FIR_REF_CATEGORIES.child(element).child(key).setValue(nil)
    }
    
    let recipeImageRef = FIR_STORAGE_REF.child("\(USER_ID ?? "NO_USER")/\(key).jpg")
    
    // Delete the file
    recipeImageRef.delete { error in
        if let error = error {
            // Uh-oh, an error occurred!
        } else {
            // File deleted successfully
        }
    }
}

// Add data to Firebase (Data and Images)
func addDataToFIR(title: String, favourite: Bool, time: Int, howTo: String, ingredients: String, icon: String, category: String, image: UIImage) {
    
    // Create random key
    let tempKey = FIR_REF.childByAutoId().key
    
    // Create a new Recipe object
    let newRecipe = Recipe(title: title, favourite: favourite, time: time, howto: howTo, ingredients: ingredients, icon: icon, key: tempKey, img: "")
    
    // Post image to Firebase Storage
    var imageURL: Any?
    
    let recipeImageRef = FIR_STORAGE_REF.child("\(USER_ID ?? "NO_USER")/\(tempKey).jpg")
    
    if let uploadImage = UIImageJPEGRepresentation(image, 0.1) {
        recipeImageRef.putData(uploadImage, metadata: nil, completion: {(metadata, error) in
            if error != nil {
                print("Error image upload")
            } else {
                imageURL = metadata?.downloadURL()?.absoluteString
                _ = FIR_REF_CATEGORIES.child(category).child(tempKey).child("url").setValue(imageURL)
                _ = FIR_REF_CATEGORIES.child("allRecipes").child(tempKey).child("url").setValue(imageURL)
                if time <= 15 {
                    _ = FIR_REF_CATEGORIES.child(category).child(tempKey).child("url").setValue(imageURL)
                }
            }
        })
    }
    
    // Prepare object to send to Firebase
    let object : [String : Any] = [
        "favourite": newRecipe.favourite,
        "howTo": newRecipe.howTo,
        "ingredients": newRecipe.ingredients,
        "time": newRecipe.time,
        "title": newRecipe.title,
        "icon": newRecipe.icon,
        ]
    
    // Post the recipe data object to Firebase
    _ = FIR_REF_CATEGORIES.child(category).child(tempKey).setValue(object)
    _ = FIR_REF_CATEGORIES.child("allRecipes").child(tempKey).setValue(object)
    
    if time <= 15 {
        _ = FIR_REF_CATEGORIES.child("Under 15 minuter").child(tempKey).setValue(object)
    }
}

