//
//  ItemTableCell.swift
//  Cool Joint
//
//  Created by Zoojoobe on 02/04/16.
//  Copyright © 2016 Abhishek Agarwal. All rights reserved.
//

import UIKit
import Firebase

class ItemTableCell: UITableViewCell {
    
    var item: Item!
    
    @IBOutlet var availableImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var editButton: UIButton!
    @IBOutlet var nameInCaseOfDiscountLabel: UILabel!
    @IBOutlet var discountInCaseOfDiscountLabel: UILabel!
    
    func configureCell(row:Int, item: Item) {
        editButton.tag = row
        self.item = item
        if item.discount == "0" {
            self.nameLabel.text = item.itemName
            self.nameInCaseOfDiscountLabel.text = ""
            self.discountInCaseOfDiscountLabel.text = ""
        } else {
            self.nameLabel.text = ""
            self.nameInCaseOfDiscountLabel.text = item.itemName
            self.discountInCaseOfDiscountLabel.text = "(Offer: " + item.discount + "% discount)"
        }
        self.priceLabel.text = "Rs. \(item.itemPrice)"
        if item.itemAvailability == true {
            availableImageView.image = UIImage(named: "available.png")
        } else {
            availableImageView.image = UIImage(named: "unavailable.png")
        }
    }
}
