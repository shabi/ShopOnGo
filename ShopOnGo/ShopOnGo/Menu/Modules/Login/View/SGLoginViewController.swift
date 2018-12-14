//
//  SGLoginViewController.swift
//  ShopOnGo
//
//  Created by eCOM-shabi.naqvi on 14/11/18.
//  Copyright © 2018 pixelgeniel. All rights reserved.
//

import UIKit

class SGLoginViewController: UIViewController {
    
    //    @IBOutlet weak var signInButton: GIDSignInButton!
    @IBOutlet weak var userName: PRGValidationField!
    @IBOutlet weak var password: PRGValidationField!
    
    var loginViewModel: SGLoginViewModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //GIDSignIn.sharedInstance().uiDelegate = self
    }
    @IBAction func loginAction(_ sender: Any) {
        if self.userName.text?.count == 0 , self.password.text?.count == 0 {
            SGUtility.showAlert(title: "Login", message: "User name or Password is not valid.", actionTitles: "OK", actions: nil)
            return
        }
        
        let reqDic = ["UserName": self.userName.text, "Password": self.password.text]
        self.loginViewModel = SGLoginViewModel(viewController: self, loginInfo: reqDic as? [String: String])
        self.loginViewModel?.fetchEventInfo(serviceType: .login)
    }
    
    @IBAction func gotToSignUpPage(sender: AnyObject) {
        
        let signUpViewNavController = self.storyboard?.instantiateViewController(withIdentifier: "SGSignUpViewController") as! SGSignUpViewController
        self.present(signUpViewNavController, animated: true, completion: nil)
    }
}

extension SGLoginViewController: ViewController {
    
    func updateView() {
        print("updateView")
        let shopListViewController = self.storyboard?.instantiateViewController(withIdentifier: "SGShopListViewController") as! SGShopListViewController
        self.present(shopListViewController, animated: true, completion: nil)
        
        if  true {
//            SGLoginViewModel
        }
    }
}
