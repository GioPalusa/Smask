//
//  ViewController.swift
//  Smask
//
//  Created by Giovanni Palusa on 2017-09-08.
//  Copyright © 2017 Giovanni Palusa. All rights reserved.
//

import UIKit
import Firebase

class RecepieListVC: UIViewController {
    
    @IBOutlet weak var menuBtn: UIButton!
    
    var ref: DatabaseReference! = Database.database().reference()
    let userID = Auth.auth().currentUser?.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        let key = ref.child("posts").childByAutoId().key
        let testRecept = Recepie(title: "Sockerkaka")
        testRecept.favourite = false
        testRecept.ingredients = "2 ägg, 5 dl mjöl"
        testRecept.time = "40 minuter"
        testRecept.howTo = "Först så ska du, sen så ska du..."
        
        let object : [String : Any] = ["favourite": testRecept.favourite, "howTo": testRecept.howTo, "ingredients": testRecept.ingredients, "time": testRecept.time, "title": testRecept.title]
        self.ref.child("users").child(userID!).child("categories").child("fika").child(key).setValue(object)
        
    }    
}

