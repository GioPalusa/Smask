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
let CATEGORIES : [String] = ["under15", "asiatiskt", "pasta", "snabbmat", "kallskuret", "fika", "frukost", "vegetariskt", "grillat"]

// User data
let USER_ID = Auth.auth().currentUser?.uid

// Firebase database paths
let FIR_PATH_USERS = "users"
let FIR_PATH_CATEGORIES = "categories"

let FIR_REF : DatabaseReference! = Database.database().reference()
let FIR_REF_CHOSEN_CATEGORY = FIR_REF.child(FIR_PATH_USERS).child(USER_ID!).child(FIR_PATH_CATEGORIES).child(chosenCategory)
let FIR_REF_USER = FIR_REF.child(FIR_PATH_USERS).child(USER_ID!)
let FIR_REF_CATEGORIES = FIR_REF.child(FIR_PATH_USERS).child(USER_ID!).child(FIR_PATH_CATEGORIES)

