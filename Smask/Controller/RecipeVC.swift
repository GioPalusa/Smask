//
//  recipeVC.swift
//  Smask
//
//  Created by Giovanni Palusa on 2017-09-11.
//  Copyright © 2017 Giovanni Palusa. All rights reserved.
//

import UIKit


class RecipeVC: UIViewController {
    
    @IBOutlet weak var titleBar: UINavigationItem!
    @IBOutlet weak var ingredientsLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var doThisLbl: UILabel!
    @IBOutlet weak var recipeImg: UIImageView!
    
    var chosenRecipe: Recipe!

    override func viewDidLoad() {
        super.viewDidLoad()
        titleBar.title = chosenRecipe.title
        ingredientsLbl.text = chosenRecipe.ingredients
        doThisLbl.text = chosenRecipe.howTo
        timeLbl.text = "\(chosenRecipe.time) minuter"
        
        // Get image from Firebase
        let reference = FIR_STORAGE_REF.child("\(USER_ID ?? "NO_USER")/\(chosenRecipe.key).jpg")
        
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        reference.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                // Uh-oh, an error occurred!
            } else {
                // Data for "images/island.jpg" is returned
                self.recipeImg.image = UIImage(data: data!)
            }
        }
    }
    
    @IBAction func editBtnPressed(_ sender: Any) {
        
    }
}
