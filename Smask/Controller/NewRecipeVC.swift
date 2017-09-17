//
//  NewRecipeVC.swift
//  Smask
//
//  Created by Giovanni Palusa on 2017-09-14.
//  Copyright © 2017 Giovanni Palusa. All rights reserved.
//

import UIKit

class NewRecipeVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate ,UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var titleTxt: UITextField!
    @IBOutlet weak var categoryPcr: UIPickerView!
    @IBOutlet weak var ingredientsTxt: UITextView!
    @IBOutlet weak var howToTxt: UITextView!
    @IBOutlet weak var minuteSlider: UISlider!
    @IBOutlet weak var totalMinutesLbl: UILabel!
    @IBOutlet weak var autoAddTxtLbl: UILabel!
    @IBOutlet weak var recipeImg: UIImageView!
    @IBOutlet weak var pickImageBtnsStack: UIStackView!
    @IBOutlet weak var changeImgBtn: UIButton!
    
    
// Class variables
    var selectedCategory: String = CATEGORIES[0]
    var minutesFromSlider: Int = 15
    
// View
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return CATEGORIES.count
        }
        
        // Dismiss the keyboard if the user presses outside
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        // Set data source and delegate to the picker
        self.categoryPcr.dataSource = self;
        self.categoryPcr.delegate = self;
        
        // Hide unnecessary objects at start
        recipeImg.isHidden = true
        changeImgBtn.isHidden = true
    }
    
    
// IBActions
    
    // Image picker
    @IBAction func pickImageBtnPressed(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true) {
            // after this is completed
        }
    }
    
    // Camera image picker
    @IBAction func TakeImageBtnPressed(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.camera
        image.allowsEditing = false
        self.present(image, animated: true) {
            // after this is completed
        }
    }
    
    @IBAction func changeImgBtnPressed(_ sender: Any) {
        changeImgBtn.isHidden = true
        pickImageBtnsStack.isHidden = false
    }
    
    // Slider for choosing amount of minutes
    @IBAction func sliderChanged(sender: UISlider) {
        totalMinutesLbl.text = "\(Int(sender.value)) minuter"
        // String.localizedStringWithFormat(NSLocalizedString("%@ minutes", comment: "number of minutes from the slider"), Int(sender.value))
        minutesFromSlider = Int(sender.value)
        
        if minutesFromSlider <= 15 {
            autoAddTxtLbl.isHidden = false
        } else {
            autoAddTxtLbl.isHidden = true
        }
    }
    
    
// Functions
    
    // Show selected image from pickImageBtnPressed
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            recipeImg.image = image
        } else {
            let alertController = UIAlertController(title: NSLocalizedString("Error", comment: "title for alert popup saying something is wrong"), message:
                NSLocalizedString("This image can not be used, please choose another", comment: "Message in alert popup when image pick failed"), preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: NSLocalizedString("Okay!", comment: ""), style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
        self.dismiss(animated: true, completion: nil)
        recipeImg.isHidden = false
        changeImgBtn.isHidden = false
        pickImageBtnsStack.isHidden = true
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
            let alertController = UIAlertController(title: NSLocalizedString("Something is missing", comment: "title for alert popup saying something is wrong"), message:
                NSLocalizedString("Check all fields and try again", comment: "Message in alert popup for a new recipe"), preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: NSLocalizedString("Okay!", comment: ""), style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        } else {
            addDataToFIR(title: titleTxt.text!, favourite: false, time: minutesFromSlider, howTo: howToTxt.text, ingredients: ingredientsTxt.text, icon: CATEGORY_IMAGES[selectedCategory]!, category: selectedCategory)
            self.dismiss(animated: true, completion: nil)
            self.performSegue(withIdentifier: "unwindToStart", sender: self)

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
        selectedCategory = String(CATEGORIES.sorted()[row])
    }
    
}

