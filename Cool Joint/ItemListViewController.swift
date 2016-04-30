//
//  ItemListViewController.swift
//  Cool Joint
//
//  Created by Zoojoobe on 02/04/16.
//  Copyright © 2016 Abhishek Agarwal. All rights reserved.
//

import UIKit
import Firebase

class ItemListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var veg: Bool!
    var available: Bool!
    var items = [Item]()
    var rowSelected: Int!
    @IBOutlet var tableView: UITableView!
    var categoryArray = ["starters","main-course","rotis-and-parathas","rice-and-noodles","beverages"]
    var refArray = [DataService.dataService.STARTER_REF, DataService.dataService.MAIN_COURSE_REF, DataService.dataService.PARATHAS_REF, DataService.dataService.RICE_REF, DataService.dataService.BEVERAGES_REF]
    var categorySelected: Int!
    @IBOutlet var editView: UIView!
    @IBOutlet var blackView: UIView!
    @IBOutlet var nameFieldEditView: UITextField!
    @IBOutlet var priceFieldEditView: UITextField!
    @IBOutlet var availableSwitchEditView: UISwitch!
    @IBOutlet var vegLabelEditView: UILabel!
    @IBOutlet var vegSwitchEditView: UISwitch!
    @IBOutlet var discountSwitch: UISwitch!
    @IBOutlet var discountField: UITextField!
    
    @IBAction func removeItemPressed(sender: AnyObject) {
        refArray[categorySelected].childByAppendingPath(items[rowSelected].itemKey).removeValue()
        editView.hidden = true
        tableView.userInteractionEnabled = true
        blackView.hidden = true
    }
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        editView.hidden = true
        tableView.userInteractionEnabled = true
        blackView.hidden = true
    }
    
    @IBAction func saveChangesClicked(sender: AnyObject) {
        let name = nameFieldEditView.text
        let price = priceFieldEditView.text
        if name != "" && price != "" {
            let item: Dictionary<String, AnyObject> = [
                "itemName": name!,
                "price": price!,
                "available": available,
                "veg": veg,
                "discountPercent": (discountField.text != "") ? discountField.text! : "0"
            ]
            refArray[categorySelected].childByAppendingPath(items[rowSelected].itemKey).setValue(item)
            editView.hidden = true
            tableView.userInteractionEnabled = true
            blackView.hidden = true
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameFieldEditView.delegate = self
        priceFieldEditView.delegate = self
        discountField.delegate = self
        tableView.allowsSelection = false
        tableView.allowsMultipleSelection = false
//        let checkWaitingRef = Firebase(url:"cool-joint.firebaseio.com/users")
//        checkWaitingRef.queryOrderedByChild("name").queryEqualToValue("Abhishek")
//            .observeEventType(.ChildAdded, withBlock: { snapshot in
//                print(snapshot)
//            })
        refArray[categorySelected].observeEventType(.Value, withBlock: { snapshot in
            self.items = []
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                for snap in snapshots {
                    if let itemDictionary = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let item = Item(category: self.categoryArray[self.categorySelected], key: key, dictionary: itemDictionary)
                        self.items.append(item)
                    }
                }
            }
            self.tableView.reloadData()
        })
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == nameFieldEditView {
            textField.resignFirstResponder()
        } else if textField == priceFieldEditView{
            priceFieldEditView.resignFirstResponder()
        } else {
            discountField.resignFirstResponder()
        }
        return true
    }
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func addItemPressed(sender: AnyObject) {
        performSegueWithIdentifier("SegueToAddItem", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SegueToAddItem" {
            let x = segue.destinationViewController as! AddItemViewController
            x.categorySelected = categorySelected
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        if let cell = tableView.dequeueReusableCellWithIdentifier("cell") as? ItemTableCell {
            cell.configureCell(indexPath.row, item: item)
            cell.editButton.addTarget(self, action: #selector(ItemListViewController.editButtonPressed(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            return cell
        } else {
            return ItemTableCell()
        }
    }
    
    func editButtonPressed(sender: UIButton!) {
        rowSelected = sender.tag
        blackView.hidden = false
        tableView.userInteractionEnabled = false
        editView.hidden = false
        nameFieldEditView.text = items[rowSelected].itemName
        priceFieldEditView.text = items[rowSelected].itemPrice
        if categorySelected == 4 {
            vegLabelEditView.hidden = true
            vegSwitchEditView.hidden = true
        }
        if items[rowSelected].itemTypeVeg == false {
            vegSwitchEditView.setOn(false, animated: true)
            veg = false
        } else {
            veg = true
        }
        if items[rowSelected].itemAvailability == false {
            availableSwitchEditView.setOn(false, animated: true)
            available = false
        } else {
            available = true
        }
        if items[rowSelected].discount != "0" {
            discountSwitch.setOn(true, animated: true)
            discountField.hidden = false
            discountField.text = items[rowSelected].discount
        } else {
            discountSwitch.setOn(false, animated: true)
            discountField.hidden = true
            discountField.text = ""
        }
        vegSwitchEditView.addTarget(self, action: #selector(ItemListViewController.stateChangedOfVegSwitch(_:)), forControlEvents: UIControlEvents.ValueChanged)
        availableSwitchEditView.addTarget(self, action: #selector(ItemListViewController.stateChangedOfAvailableSwitch(_:)), forControlEvents: UIControlEvents.ValueChanged)
        discountSwitch.addTarget(self, action: #selector(ItemListViewController.stateChangedOfDiscountSwitch(_:)), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func stateChangedOfDiscountSwitch(switchState: UISwitch) {
        if switchState.on {
            discountSwitch.setOn(true, animated: true)
            discountField.hidden = false
            discountField.becomeFirstResponder()
        } else {
            discountSwitch.setOn(false, animated: true)
            discountField.hidden = true
            discountField.text = ""
        }
    }
    
    func stateChangedOfVegSwitch(switchState: UISwitch) {
        if switchState.on {
            veg = true
        } else {
            veg = false
        }
    }
    
    func stateChangedOfAvailableSwitch(switchState: UISwitch) {
        if switchState.on {
            available = true
        } else {
            available = false
        }
    }
    
}
