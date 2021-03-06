//
//  ViewController.swift
//  Smask
//
//  Created by Giovanni Palusa on 2017-09-08.
//  Copyright © 2017 Giovanni Palusa. All rights reserved.
//

import UIKit
import Firebase

class RecipeListVC: UIViewController {
    
    @IBOutlet weak var timeIndicatorLbl: UILabel!
    @IBOutlet weak var recepieTitleLbl: UILabel!
    @IBOutlet weak var categoryImg: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var burgerMenuBtn: UIBarButtonItem!
    
    var recipesArray = [Recipe]()
    var refreshControl: UIRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Store a local copy of FIR DB on the unit
        Database.database().isPersistenceEnabled = true
        
        // Open up the sidebar menu using revealViewController
//        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        
        // If the user taps on the RecepieListVC or pans to it, the side menu closes
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        // Set the delegate and dataSource to this VC
        tableView.delegate = self
        tableView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshTableView), name: NSNotification.Name(rawValue: "load"), object: nil)
        
        // Check if later than iOS 10 to use the correct refresh control
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        
        // Add refreshcontrol to this view controller and run a refresh of the table view,
        // fetching new data from Smask on Firebase, then listen for a value change
        refreshControl.addTarget(self, action: #selector(RecipeListVC.refreshTableView), for: UIControlEvents.valueChanged)
        
        // Add the smask logo to the navigation bar
        let logo = UIImage(named: "smask-barlogo")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        
    }

// IB Actions
    @IBAction func burgerBtnPressed(_ sender: Any) {
        self.revealViewController().revealToggle(animated: true)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    
    
// Functions
    
    // Before the view appears get, and reload the data
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DataService.instance.getDatafromFIR { (returnedRecipesArray) in
            self.recipesArray = returnedRecipesArray
            self.tableView.reloadData()
        }
    }
    
    // Same as viewDidAppear, but telling the refresh control to stop after finished
    @objc func refreshTableView() {
        DataService.instance.getDatafromFIR { (returnedRecipesArray) in
            self.recipesArray = returnedRecipesArray
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
}


extension RecipeListVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Rerturn as many rows as there are recipes in the array
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipesArray.count
    }
    
    // populate the table view cells with info from the array of recipes
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCellMain") as? MainPageRecipeCell else { return UITableViewCell() }
        let recipe = recipesArray[indexPath.row]
        
        cell.setCell(title: recipe.title, time: "\(recipe.time) minuter", categoryImg: recipe.icon)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "viewRecipe", sender: recipesArray[indexPath.row])
    }
    
    // Slide to delete entry from the table
    // Deletes from all categories
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let rowKey = recipesArray[indexPath.row].key
        let result = removeDataFromFIR(key: rowKey)
        print(result)
        refreshTableView()
    }
    
    // Send the selected recipe
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewRecipe" {
            let clicked = segue.destination as! RecipeVC
            clicked.chosenRecipe = sender as? Recipe
        }
    }
}
