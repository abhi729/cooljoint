//
//  SignUpViewController.swift
//  Cool Joint
//
//  Created by Zoojoobe on 01/04/16.
//  Copyright © 2016 Abhishek Agarwal. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var contactField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var dobField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.delegate = self
        nameField.delegate = self
        contactField.delegate = self
        passwordField.delegate = self
        dobField.delegate = self
        nameField.becomeFirstResponder()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == nameField {
            textField.resignFirstResponder()
            emailField.becomeFirstResponder()
        } else if textField == emailField {
            textField.resignFirstResponder()
            contactField.becomeFirstResponder()
        } else if textField == contactField {
            textField.resignFirstResponder()
            dobField.becomeFirstResponder()
        } else if textField == dobField {
            textField.resignFirstResponder()
            passwordField.becomeFirstResponder()
        } else {
            passwordField.resignFirstResponder()
        }
        return true
    }
    
    func signupErrorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func signUpPressed(sender: AnyObject) {
        let name = nameField.text
        let email = emailField.text
        let contact = contactField.text
        let password = passwordField.text
        let dob = dobField.text
        
        if name != "" && email != "" && contact != "" && password != "" && dob != "" {
            DataService.dataService.BASE_REF.createUser(email, password: password, withValueCompletionBlock : { error, result in
                if error != nil {
                    self.signupErrorAlert("Oops!", message: "\(error)")
                } else {
                    DataService.dataService.BASE_REF.authUser(email, password: password, withCompletionBlock : { err, authData in
                        let user = ["provider": authData.provider!, "email": email!, "name": name!, "contact": contact!, "date-of-birth": dob!]
                        DataService.dataService.createNewAccount(authData.uid, user: user)
                    })
                    NSUserDefaults.standardUserDefaults().setValue(result["uid"], forKey: "uid")
                    self.performSegueWithIdentifier("SegueToHome", sender: self)
                }
            })
        } else {
            signupErrorAlert("Oops!", message: "Don't forget to enter your email, password, contact number, date of birth and a username.")
        }
    }
    
    @IBAction func signInPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
