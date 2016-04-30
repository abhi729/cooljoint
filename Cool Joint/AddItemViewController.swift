//
//  AddItemViewController.swift
//  Cool Joint
//
//  Created by Zoojoobe on 02/04/16.
//  Copyright © 2016 Abhishek Agarwal. All rights reserved.
//

import UIKit
import Firebase

class AddItemViewController: UIViewController, UITextFieldDelegate {
    
    var categoryArray = ["starters","main-course","rotis-and-parathas","rice-and-noodles","beverages"]
    var categorySelected: Int!
    @IBOutlet var nameField: UITextField!
    @IBOutlet var priceField: UITextField!
    @IBOutlet var vegSwitch: UISwitch!
    @IBOutlet var vegLabel: UILabel!
    @IBOutlet var discountSwitch: UISwitch!
    @IBOutlet var discountField: UITextField!
    var veg: Bool!
    var discount: Bool!
    var available: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if categorySelected == 4 {
            vegSwitch.hidden = true
            vegLabel.hidden = true
        }
        nameField.delegate = self
        priceField.delegate = self
        discountField.delegate = self
        nameField.becomeFirstResponder()
        veg = true
        discount = false
        discountSwitch.addTarget(self, action: #selector(AddItemViewController.stateChangedDiscount(_:)), forControlEvents: UIControlEvents.ValueChanged)
        vegSwitch.addTarget(self, action: #selector(AddItemViewController.stateChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func stateChanged(switchState: UISwitch) {
        if switchState.on {
            veg = true
        } else {
            veg = false
        }
    }
    
    func stateChangedDiscount(switchState: UISwitch) {
        if switchState.on {
            discount = true
            discountField.hidden = false
            discountField.becomeFirstResponder()
        } else {
            discount = false
            discountField.hidden = true
            discountField.text = ""
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == nameField {
            textField.resignFirstResponder()
            priceField.becomeFirstResponder()
        } else if textField == priceField{
            priceField.resignFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    @IBAction func addItemClicked(sender: AnyObject) {
        let name = nameField.text
        let price = priceField.text
        if name != "" && price != "" {
            let item: Dictionary<String, AnyObject> = [
                "itemName": name!,
                "price": price!,
                "available": true,
                "veg": veg,
                "discountPercent": (discountField.text != "") ? discountField.text! : "0"
            ]
            DataService.dataService.createNewItem(categoryArray[categorySelected], item: item)
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
