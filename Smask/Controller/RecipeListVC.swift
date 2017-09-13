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
    
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var timeIndicatorLbl: UILabel!
    @IBOutlet weak var recepieTitleLbl: UILabel!
    @IBOutlet weak var categoryImg: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var recipesArray = [Recipe]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Store a local copy of FB DB on the unit
        Database.database().isPersistenceEnabled = true
        
        // Open up the sidebar menu using revealViewController
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        // If the user taps on the RecepieListVC or pans to it, the side menu closes
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    // Before the view appears get, and reload the data
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DataService.instance.getDatafromFIR { (returnedRecipesArray) in
            self.recipesArray = returnedRecipesArray
            self.tableView.reloadData()
        }
    }
}


extension RecipeListVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Rerturn as many rows as there are recepies in the array
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipesArray.count
    }
    
    // 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recepieCellMain") as? MainPageRecepieCell else { return UITableViewCell() }
        let recepie = recipesArray[indexPath.row]
        
        cell.setCell(title: recepie.title, time: recepie.time, categoryImg: recepie.icon)
        return cell
    }
}
