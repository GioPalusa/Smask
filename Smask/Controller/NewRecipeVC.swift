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
    @IBOutlet weak var timeTxt: UITextField!
    @IBOutlet weak var categoryPcr: UIPickerView!
    @IBOutlet weak var ingredientsTxt: UITextView!
    @IBOutlet weak var howToTxt: UITextView!
    
    var selectedCategory: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return CATEGORIES.count
        }
        
        // Dismiss the keyboard if the user presses outside
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        self.categoryPcr.dataSource = self;
        self.categoryPcr.delegate = self;
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its text fields) quit the editing status.
        view.endEditing(true)
    }
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        addDataToFIR(title: titleTxt.text!, favourite: false, time: Int(timeTxt.text!)!, howTo: howToTxt.text, ingredients: ingredientsTxt.text, icon: "noodles", category: selectedCategory)
        self.dismiss(animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView,numberOfRowsInComponent component: Int) -> Int {
        return CATEGORIES.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return CATEGORIES[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = String(CATEGORIES[row])
    }
    
}
