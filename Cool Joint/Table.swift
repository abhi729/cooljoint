//
//  Table.swift
//  Cool Joint
//
//  Created by Zoojoobe on 03/04/16.
//  Copyright © 2016 Abhishek Agarwal. All rights reserved.
//

import UIKit
import Firebase

class Table {
    private var _tableRef : Firebase!
    
    private var _tableKey: String!
    private var _tableName: String!
    private var _tableReserved: Bool!
    
    var tablekey: String {
        return _tableKey
    }
    
    var tableName: String {
        return _tableName
    }
    
    var tableReserved: Bool {
        return _tableReserved
    }
    
    init(key: String, dictionary: Dictionary<String, AnyObject>) {
        
        self._tableKey = key
        if let name = dictionary["tableName"] as? String {
            self._tableName = name
        }
        if let status = dictionary["tableReserved"] as? Bool {
            self._tableReserved = status
        }
        self._tableRef = DataService.dataService.TABLE_REF.childByAppendingPath(_tableKey)
    }
}

