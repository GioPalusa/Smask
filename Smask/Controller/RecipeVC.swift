//
//  recipeVC.swift
//  Smask
//
//  Created by Giovanni Palusa on 2017-09-11.
//  Copyright © 2017 Giovanni Palusa. All rights reserved.
//

import UIKit


class RecipeVC: UIViewController {
    
    @IBOutlet weak var recepieTitleLbl: UILabel!
    @IBOutlet weak var favouriteBtn: UIButton!
    @IBOutlet weak var ingredientsLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var doThisLbl: UILabel!
    
    var chosenRecipe: Recipe!

    override func viewDidLoad() {
        super.viewDidLoad()
        recepieTitleLbl.text = chosenRecipe.title
        ingredientsLbl.text = chosenRecipe.ingredients
        doThisLbl.text = chosenRecipe.howTo
        timeLbl.text = "\(chosenRecipe.time) minuter"
        
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(backBtnPressed(_:)))
        edgePan.edges = .left
        
        view.addGestureRecognizer(edgePan)
    }
    
   

    @IBAction func backBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
