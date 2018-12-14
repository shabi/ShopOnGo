//
//  SGLoginViewModel.swift
//  ShopOnGo
//
//  Created by eCOM-shabi.naqvi on 14/11/18.
//  Copyright © 2018 pixelgeniel. All rights reserved.
//

import Foundation
import SwiftyJSON


class SGLoginViewModel {
    
    var loginAPI: SGLoginAPI?
    weak var viewController: ViewController?
    var loginModel: SGLoginModel?
    var loginInfo: [String: String]?
    
    init(viewController: ViewController, loginInfo: [String: String]?) {
        self.viewController = viewController
        self.loginInfo = loginInfo
    }
    
    func fetchEventInfo(serviceType: APIConstants.ServiceType) {
        if serviceType == .login {
            self.loginAPI =  SGLoginAPI(serviceType: .login, type: .fetchLogin, delegateViewModel: self, loginInfo: self.loginInfo)
        } else {
            self.loginAPI =  SGLoginAPI(serviceType: .registration, type: .fetchRegistration, delegateViewModel: self, loginInfo: self.loginInfo)
        }
        self.loginAPI?.fetchData()
        SGProgressView.shared.showProgressView((self.viewController as! UIViewController).view)
    }
}

extension SGLoginViewModel: APIDelegateViewModel {
    
    func apiSuccess(serviceType: String, model: Any?) {
        
        if serviceType == APIConstants.ServiceType.login.rawValue, let info = model as? SGLoginModel {
            self.loginModel = info
            DispatchQueue.main.async {
                self.viewController?.updateView()
            }
        } else if serviceType == APIConstants.ServiceType.registration.rawValue {
            DispatchQueue.main.async {
                self.viewController?.updateView()
            }
        }

        SGProgressView.shared.hideProgressView()
        print("success")
    }
    
    func apiFailure(serviceType: String, error: Error) {
        print("failue")
        SGProgressView.shared.hideProgressView()
    }
}
