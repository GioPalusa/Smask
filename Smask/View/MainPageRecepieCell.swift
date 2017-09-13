//
//  MainPageRecepieCell.swift
//  Smask
//
//  Created by Giovanni Palusa on 2017-09-13.
//  Copyright © 2017 Giovanni Palusa. All rights reserved.
//

import UIKit

class MainPageRecepieCell: UITableViewCell {
    
    @IBOutlet weak var title : UILabel!
    @IBOutlet weak var time : UILabel!
    @IBOutlet weak var categoryImg : UIImageView!
    
    func setCell(title: String, time: String, categoryImg: String) {
        self.title.text = title
        self.time.text = time
        self.categoryImg.image = UIImage(named: categoryImg)
    }

}
