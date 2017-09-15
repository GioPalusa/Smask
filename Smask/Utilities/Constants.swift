//
//  Constants.swift
//  Smask
//
//  Created by Giovanni Palusa on 2017-09-12.
//  Copyright © 2017 Giovanni Palusa. All rights reserved.
//

import Foundation
import Firebase

// Recepie categories
let CATEGORIES : [String] = ["Under 15 minuter", "Asiatiskt", "Pasta", "Snabbmat", "Kallskuret", "Fika", "Frukost", "Vegetariskt", "Grillat"]

let CATEGORY_IMAGES: [String : String] = [
    "Under 15 minuter" : "micro",
    "Asiatiskt" : "noodles",
    "Pasta" : "pasta",
    "Snabbmat" : "pizza",
    "Kallskuret" : "sandwich",
    "Fika" : "bun",
    "Frukost" : "toast",
    "Vegetariskt" : "vego",
    "Grillat" : "barbeque"
]

// User data
let USER_ID = Auth.auth().currentUser?.uid

// Firebase database paths
let FIR_PATH_USERS = "users"
let FIR_PATH_CATEGORIES = "categories"

let FIR_REF : DatabaseReference! = Database.database().reference()
let FIR_REF_USER = FIR_REF.child(FIR_PATH_USERS).child(USER_ID!)
let FIR_REF_CATEGORIES = FIR_REF.child(FIR_PATH_USERS).child(USER_ID!).child(FIR_PATH_CATEGORIES)

