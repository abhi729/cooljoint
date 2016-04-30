//
//  DataService.swift
//  Cool Joint
//
//  Created by Zoojoobe on 01/04/16.
//  Copyright © 2016 Abhishek Agarwal. All rights reserved.
//

import Foundation
import Firebase

class DataService {
    static let dataService = DataService()
    
    private var _BASE_REF = Firebase(url: "\(BASE_URL)")
    private var _MENU_REF = Firebase(url: "\(BASE_URL)/menu")
    private var _TABLE_REF = Firebase(url: "\(BASE_URL)/tables")
    private var _USER_REF = Firebase(url: "\(BASE_URL)/users")
    private var _STARTER_REF = Firebase(url: "\(BASE_URL)/menu/starters")
    private var _MAIN_COURSE_REF = Firebase(url: "\(BASE_URL)/menu/main-course")
    private var _PARATHAS_REF = Firebase(url: "\(BASE_URL)/menu/rotis-and-parathas")
    private var _RICE_REF = Firebase(url: "\(BASE_URL)/menu/rice-and-noodles")
    private var _BEVERAGES_REF = Firebase(url: "\(BASE_URL)/menu/beverages")
    
    var BASE_REF : Firebase {
        return _BASE_REF
    }
    
    var USER_REF : Firebase {
        return _USER_REF
    }
    
    var MENU_REF : Firebase {
        return _MENU_REF
    }
    
    var TABLE_REF : Firebase {
        return _TABLE_REF
    }
    
    var STARTER_REF : Firebase {
        return _STARTER_REF
    }
    
    var MAIN_COURSE_REF : Firebase {
        return _MAIN_COURSE_REF
    }
    
    var PARATHAS_REF : Firebase {
        return _PARATHAS_REF
    }
    
    var RICE_REF : Firebase {
        return _RICE_REF
    }
    
    var BEVERAGES_REF : Firebase {
        return _BEVERAGES_REF
    }
    
    var CURRENT_USER_REF : Firebase {
        let userId = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
        let currentUser = Firebase(url: "\(BASE_REF)").childByAppendingPath("users").childByAppendingPath(userId)
        return currentUser!
    }
    
    func createNewAccount(uid: String, user: Dictionary<String, String>) {
        USER_REF.childByAppendingPath(uid).setValue(user)
    }
    
    func createNewItem(category: String, item: Dictionary<String, AnyObject>) {
        let firebaseNewItem = MENU_REF.childByAppendingPath(category).childByAutoId()
        firebaseNewItem.setValue(item)
    }
    
    func createNewTable(table: Dictionary<String, AnyObject>) {
        let firebaseNewTable = TABLE_REF.childByAutoId()
        firebaseNewTable.setValue(table)
    }
    
}
