//
//  MenuVC.swift
//  Smask
//
//  Created by Giovanni Palusa on 2017-09-09.
//  Copyright © 2017 Giovanni Palusa. All rights reserved.
//

import UIKit

@IBDesignable
class MenuVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

    }

// functions
    // set the category chosen from the table view
    func categoryChoice(category: String) {
        chosenCategory = category
        self.revealViewController().revealToggle(animated: true)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    
    // Set the start category on home button pressed
    @IBAction func homeBtnPressed(_ sender: Any) {
        categoryChoice(category: "allRecipes")
    }
    
    
}

extension MenuVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Return as many rows as there are recipes in the array
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CATEGORIES.count
    }
    
    // populate the table view cells with info from the array of recipes
    // -w is added to the image name to use white images
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryMenuCell") as? CategoryMenuCell else { return UITableViewCell() }
        
        cell.setCell(title: CATEGORIES.sorted()[indexPath.row], categoryImg: "\(CATEGORY_IMAGES[CATEGORIES.sorted()[indexPath.row]]!)-w")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.categoryChoice(category: CATEGORIES.sorted()[indexPath.row])
    }
    
    // Send the selected recipe
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewRecipe" {
            let clicked = segue.destination as! RecipeVC
            clicked.chosenRecipe = sender as? Recipe
        }
    }
    
    
}
