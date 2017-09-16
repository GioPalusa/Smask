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
    @IBOutlet weak var categoryPcr: UIPickerView!
    @IBOutlet weak var ingredientsTxt: UITextView!
    @IBOutlet weak var howToTxt: UITextView!
    @IBOutlet weak var minuteSlider: UISlider!
    @IBOutlet weak var totalMinutesLbl: UILabel!
    @IBOutlet weak var autoAddTxtLbl: UILabel!
    
    var selectedCategory: String = CATEGORIES[0]
    var minutesFromSlider: Int = 15
    
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
    
    @IBAction func sliderChanged(sender: UISlider) {
        totalMinutesLbl.text = "\(Int(sender.value)) minuter"
        minutesFromSlider = Int(sender.value)
        
        if minutesFromSlider <= 15 {
            autoAddTxtLbl.isHidden = false
        } else {
            autoAddTxtLbl.isHidden = true
        }
    }
    
    // Close the view on cancel button pressed
    @IBAction func cancelBtnPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // Dismiss the keyboard when the user press outside the text fields
    @objc func dismissKeyboard() {
        //Causes the view (or one of its text fields) quit the editing status.
        view.endEditing(true)
    }
    
    // Send everything to the database
    // If text fields are empty - prompt to user
    @IBAction func saveBtnPressed(_ sender: Any) {
        
        if titleTxt.text == "" || howToTxt.text == "" || ingredientsTxt.text == "" {
            let alertController = UIAlertController(title: "Något saknas", message:
                "Kontrollera att du fyllt i alla fält och försök igen", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Okej!", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        } else {
            addDataToFIR(title: titleTxt.text!, favourite: false, time: minutesFromSlider, howTo: howToTxt.text, ingredients: ingredientsTxt.text, icon: CATEGORY_IMAGES[selectedCategory]!, category: selectedCategory)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    
    // Show the recipe categories in picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView,numberOfRowsInComponent component: Int) -> Int {
        return CATEGORIES.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return CATEGORIES.sorted()[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = String(CATEGORIES[row])
    }
    
}

