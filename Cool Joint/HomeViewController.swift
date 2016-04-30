//
//  HomeViewController.swift
//  Cool Joint
//
//  Created by Zoojoobe on 03/04/16.
//  Copyright © 2016 Abhishek Agarwal. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var noOfTables = 0
    var lastTableKey = ""
    var tables = [Table]()
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var sideMenu: UIBarButtonItem!
    
    @IBAction func addTableClicked(sender: AnyObject) {
        let name = "Table " + String(noOfTables + 1)
        let table: Dictionary<String, AnyObject> = [
            "tableName": name,
            "tableReserved": false,
            ]
        DataService.dataService.createNewTable(table)
    }
    
    @IBAction func removeTableClicked(sender: AnyObject) {
        if lastTableKey != "" {
            DataService.dataService.TABLE_REF.childByAppendingPath(lastTableKey).removeValue()
        } else {
            print("Nothing to delete")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        DataService.dataService.TABLE_REF.observeEventType(.Value, withBlock: { snapshot in
            self.tables = []
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                for snap in snapshots {
                    if let tableDictionary = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let table = Table(key: key, dictionary: tableDictionary)
                        self.lastTableKey = table.tablekey
                        self.tables.append(table)
                    }
                }
                self.noOfTables = self.tables.count
            }
            self.collectionView.reloadData()
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("hg")
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        noOfTables = tables.count
        return noOfTables
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {        
        let table = tables[indexPath.row]
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! TableStatusCollectionCell
        cell.configureCell(table)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let table = tables[indexPath.row]
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! TableStatusCollectionCell
        if table.tableReserved == false {
            cell.reservedView.hidden = false
            DataService.dataService.TABLE_REF.childByAppendingPath(table.tablekey).childByAppendingPath("tableReserved").setValue(true)
        } else {
            cell.reservedView.hidden = true
            DataService.dataService.TABLE_REF.childByAppendingPath(table.tablekey).childByAppendingPath("tableReserved").setValue(false)
        }
    }
}
