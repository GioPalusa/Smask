//
//  NewRecipeVC.swift
//  Smask
//
//  Created by Giovanni Palusa on 2017-09-14.
//  Copyright © 2017 Giovanni Palusa. All rights reserved.
//

import UIKit

class NewRecipeVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var titleTxt: UITextField!
    @IBOutlet weak var labelTxt: UITextField!
    @IBOutlet weak var categoryPcr: UIPickerView!
    @IBOutlet weak var ingredientsTxt: UITextView!
    @IBOutlet weak var howToTxt: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return CATEGORIES.count
        }
        
        self.categoryPcr.dataSource = self;
        self.categoryPcr.delegate = self;
    }
    
    @IBAction func saveBtnPressed(_ sender: Any) {
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CATEGORIES.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return CATEGORIES[row]
    }
    
}
