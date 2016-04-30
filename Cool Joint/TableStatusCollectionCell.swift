//
//  TableStatusCollectionCell.swift
//  Cool Joint
//
//  Created by Zoojoobe on 03/04/16.
//  Copyright © 2016 Abhishek Agarwal. All rights reserved.
//

import UIKit

class TableStatusCollectionCell: UICollectionViewCell {
    @IBOutlet var reservedView: UIView!
    @IBOutlet var tableNoLabel: UILabel!
    var table: Table!
    
    func configureCell(table: Table) {
        self.table = table
        self.tableNoLabel.text = table.tableName
        if table.tableReserved == true {
            reservedView.hidden = false
        } else {
            reservedView.hidden = true
        }
    }
}
