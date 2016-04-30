//
//  Item.swift
//  Cool Joint
//
//  Created by Zoojoobe on 02/04/16.
//  Copyright © 2016 Abhishek Agarwal. All rights reserved.
//

import UIKit
import Firebase

class Item {
    private var _itemRef : Firebase!
    
    private var _itemKey: String!
    private var _itemName: String!
    private var _itemPrice: String!
    private var _itemAvailability: Bool!
    private var _itemTypeVeg: Bool!
    private var _discount:String!
    
    var itemKey: String {
        return _itemKey
    }
    
    var itemName: String {
        return _itemName
    }
    
    var itemPrice: String {
        return _itemPrice
    }
    
    var itemAvailability: Bool {
        return _itemAvailability
    }
    
    var itemTypeVeg: Bool {
        return _itemTypeVeg
    }
    
    var discount: String {
        return _discount
    }
    
    init(category:String, key: String, dictionary: Dictionary<String, AnyObject>) {
        
        self._itemKey = key
        if let name = dictionary["itemName"] as? String {
            self._itemName = name
        }
        if let price = dictionary["price"] as? String {
            self._itemPrice = price
        }
        if let availability = dictionary["available"] as? Bool {
            self._itemAvailability = availability
        }
        if let veg = dictionary["veg"] as? Bool {
            self._itemTypeVeg = veg
        }
        if let discount = dictionary["discountPercent"] as? String {
            self._discount = discount
        }
        self._itemRef = DataService.dataService.MENU_REF.childByAppendingPath(category).childByAppendingPath(_itemKey)
    }
}
