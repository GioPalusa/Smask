//
//  CategoryMenuCell.swift
//  Smask
//
//  Created by Giovanni Palusa on 2017-09-15.
//  Copyright © 2017 Giovanni Palusa. All rights reserved.
//

import UIKit

class CategoryMenuCell: UITableViewCell {
    
    @IBOutlet weak var categoryImg: UIImageView!
    @IBOutlet weak var categoryTitleTxt: UILabel!

    // Setters for the cell in the main view
    func setCell(title: String, categoryImg: String) {
        self.categoryTitleTxt.text = title
        self.categoryImg.image = UIImage(named: categoryImg)
    }

}
