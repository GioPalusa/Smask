//
//  SettingsVC.swift
//  Smask
//
//  Created by Giovanni Palusa on 2017-09-17.
//  Copyright © 2017 Giovanni Palusa. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
    
    @IBOutlet weak var sortingOption: UISegmentedControl!
    
    // Starting value for the segmented control
    static var selectedSorting = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sortingOption.selectedSegmentIndex = SettingsVC.selectedSorting
    }

    @IBAction func saveCloseBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // The selected option overwrites the value stored in DataService
    // Also sets the start value for the segmented control
    @IBAction func sortingOptionVal(_ sender: UISegmentedControl) {
        switch sortingOption.selectedSegmentIndex {
        case 0:
            sortingChoice = "icon"
            SettingsVC.selectedSorting = 0
        case 1:
            sortingChoice = "time"
            SettingsVC.selectedSorting = 1
        case 2:
            sortingChoice = "title"
            SettingsVC.selectedSorting = 2
        default:
            break;
        }
    }
    

}
