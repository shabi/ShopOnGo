//
//  SGSignUpViewController.swift
//  ShopOnGo
//
//  Created by eCOM-shabi.naqvi on 14/11/18.
//  Copyright © 2018 pixelgeniel. All rights reserved.
//
import UIKit

class SGSignUpViewController: UIViewController, PRGValidationFieldDelegate, PRGTextFieldDelegate, UITextFieldDelegate {

    @IBOutlet weak var nameField: PRGValidationField!
    @IBOutlet weak var emailField: PRGValidationField!
    @IBOutlet weak var passwordField: PRGValidationField!
    @IBOutlet weak var confirmPasswordField: PRGValidationField!
    @IBOutlet weak var phoneNumber: PRGValidationField!
    @IBOutlet weak var streetName: PRGValidationField!
    @IBOutlet weak var zipCode: PRGValidationField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    var registrationViewModel: SGLoginViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordField.otherPasswordField = confirmPasswordField
        nameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        confirmPasswordField.delegate = self
        phoneNumber.delegate = self
        streetName.delegate = self
        zipCode.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func PRGValidationField(_field: PRGValidationField, didValidateWithResult result: Bool, andErrorMessage errorMessage: String?) {
        if !result {
            _field.errorLabel.text = errorMessage
            _field.errorLabel.isHidden = false
        } else {
            _field.errorLabel.isHidden = true
        }
        
//        registerButton.isEnabled = nameField.isValid ?? false && emailField.isValid ?? false && passwordField.isValid ?? false && confirmPasswordField.isValid ?? false
    }
    
    @IBAction func dissmissButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        print("It works, boo!")
    }
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        print("It works, boo!")
        self.resignFirstResponder()
        let signUpDic = ["UserEmail": self.emailField.text as AnyObject, "Name": self.nameField.text as AnyObject,
                         "UserPassword": self.passwordField.text as AnyObject, "UserContact": self.phoneNumber.text as AnyObject,
                         "UserAddress": self.streetName.text as AnyObject, "ZipCode": self.zipCode.text as AnyObject]
        
        self.registrationViewModel = SGLoginViewModel(viewController: self, loginInfo: signUpDic as? [String : String])
        self.registrationViewModel?.fetchEventInfo(serviceType: .registration)
    }
}

extension SGSignUpViewController: ViewController {
    func updateView() {
        SGUtility.showAlert(title: "Create New Account", message: "Auto generated email is sent to your email address, please verify the same.", actionTitles: "OK", actions: nil)
        self.dismiss(animated: true, completion: nil)
    }
}
