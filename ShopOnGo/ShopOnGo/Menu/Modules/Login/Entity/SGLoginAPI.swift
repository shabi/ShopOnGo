//
//  SGLoginAPI.swift
//  ShopOnGo
//
//  Created by eCOM-shabi.naqvi on 14/11/18.
//  Copyright © 2018 pixelgeniel. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class SGLoginAPI {
    
    weak var viewModelDelegate: APIDelegateViewModel?
    var serviceType:  APIConstants.ServiceType = .none
    var loginParam: [String: String]?
    enum EventType {
        case fetchLogin
        case fetchRegistration
    }
    
    let eventType: EventType
    
    init(serviceType: APIConstants.ServiceType, type: EventType, delegateViewModel: APIDelegateViewModel, loginInfo: [String: String]?) {
        self.eventType = type
        self.viewModelDelegate = delegateViewModel
        self.serviceType = serviceType
        self.loginParam = loginInfo
    }
    
    func event() -> NSNotification.Name {
        if self.serviceType == APIConstants.ServiceType.login {
            return SGUtility.notificationName(name: APIConstants.PostNotify.loginEvent)
        }
        return SGUtility.notificationName(name: APIConstants.PostNotify.registrationEvent)
    }
    
    func errorEvent() -> NSNotification.Name {
        if self.serviceType == APIConstants.ServiceType.login {
            return SGUtility.notificationName(name: APIConstants.PostNotify.loginEventError)
        }
        return SGUtility.notificationName(name: APIConstants.PostNotify.registrationEventError)
    }
    
    func makeModel(json: JSON) -> SGModelMappable? {
        if self.serviceType == APIConstants.ServiceType.login {
            return SGLoginModel(json: json)
        }
        return nil
    }
    
    func fetchData() {
        self.fetchItemData()
    }
    
    fileprivate func fetchItemData() {
        SKServiceManager(dataSource: self, delegate: self, serviceType: self.serviceType.rawValue)
    }
}

extension SGLoginAPI: SKServiceManagerDelegate {
    
    func didReceiveError(serviceType: String, theError: Error?, failureResponse: Any?) -> [String : String]? {
        
        if let response = failureResponse {
            serviceResponse(response: response)
            print("failureResponse")
            self.viewModelDelegate?.apiFailure(serviceType: serviceType, error: theError!)
        } else {
            SGProgressView.shared.hideProgressView()
        }
        print("didReceiveError")
        return [:]
    }
    
    func didReceiveResponse(serviceType: String, headerResponse: HTTPURLResponse?,
                            finalResponse:Any?) {
        
        if let response = finalResponse {
            if serviceType == APIConstants.ServiceType.login.rawValue {
                let loginInfo = SGLoginModel(object: response)
                self.viewModelDelegate?.apiSuccess(serviceType: serviceType, model: loginInfo)
            } else if serviceType == APIConstants.ServiceType.registration.rawValue {
                self.viewModelDelegate?.apiSuccess(serviceType: serviceType, model: nil)
            }
            
            print("finalResponse")
        } else {
            if let errorMessage = (finalResponse as! NSDictionary)["error_description"] {
                SGUtility.showAlert(title: "Error", message: errorMessage as? String, actionTitles: "OK", actions: nil)
            }
            SGProgressView.shared.hideProgressView()
        }
        print("didReceiveResponse")
    }
    
    fileprivate func serviceResponse(response: Any) {
        print("serviceResponse")
        print("response")
    }
}

extension SGLoginAPI: SKServiceManagerDataSource {
    func requestParameters(serviceType: String) -> [String : AnyObject]? {
        print("requestParameters")
        
        var param: [String: AnyObject]?
        if serviceType == APIConstants.ServiceType.login.rawValue, let paramInfo = self.loginParam {
            param = [
                "UserName": paramInfo["UserName"] as AnyObject,
                "Password": paramInfo["Password"] as AnyObject,
                "grant_type": "password" as AnyObject,
            ]
        } else if serviceType == APIConstants.ServiceType.registration.rawValue, let paramInfo = self.loginParam {
            param = [
                "UserEmail": paramInfo["UserEmail"] as AnyObject,
                "UserPassword": paramInfo["UserPassword"] as AnyObject,
                "Name": paramInfo["Name"] as AnyObject,
                "UserContact": paramInfo["UserContact"] as AnyObject,
                "ZipCode": paramInfo["ZipCode"] as AnyObject,
                "UserAddress": paramInfo["UserAddress"] as AnyObject,
                "CreatedBy": "IOS" as AnyObject,
            ]
        }
        return param
    }
    
    func requestHeaders(serviceType: String) -> [String : String]? {
        print("requestHeaders")
        return nil
    }
    
    // MARK: ServiceKit Datasource
    func requestUrlandHttpMethodType(serviceType: String) -> (url: String?,
        methodType: SKConstant.HTTPMethod?) {
            var urlAndMethodType: (url: String?, methodType: SKConstant.HTTPMethod?)
            urlAndMethodType.url = serviceType == APIConstants.ServiceType.login.rawValue ? APIConstants.ApiUrls.loginUrl : APIConstants.ApiUrls.registrationUrl
            urlAndMethodType.methodType = .post
            return urlAndMethodType
    }
}
