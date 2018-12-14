//
//  SGShopListAPI.swift
//  ShopOnGo
//
//  Created by eCOM-shabi.naqvi on 13/11/18.
//  Copyright © 2018 pixelgeniel. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class SGShopListAPI {
    
    weak var viewModelDelegate: APIDelegateViewModel?
    var serviceType:  APIConstants.ServiceType = .none
    enum EventType {
        case fetchItem
    }
    
    let eventType: EventType
    
    init(serviceType: APIConstants.ServiceType, type: EventType, delegateViewModel: APIDelegateViewModel) {
        self.eventType = type
        self.viewModelDelegate = delegateViewModel
        self.serviceType = serviceType
    }
    
    
    func event() -> NSNotification.Name {
        return SGUtility.notificationName(name: APIConstants.PostNotify.shopListEvent)
    }
    
    func errorEvent() -> NSNotification.Name {
        return SGUtility.notificationName(name: APIConstants.PostNotify.shopListEventError)
    }
    
    func makeModel(json: JSON) -> SGModelMappable? {
        return SGShopList(json: json)
    }
    
    func fetchData() {
        self.fetchItemData()
    }
    
    fileprivate func fetchItemData() {
        SKServiceManager(dataSource: self, delegate: self, serviceType: self.serviceType.rawValue)
    }
}

extension SGShopListAPI: SKServiceManagerDelegate {
    
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
            let itemInfo = SGShopList (object: response)
            self.viewModelDelegate?.apiSuccess(serviceType: serviceType, model: itemInfo)
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

extension SGShopListAPI: SKServiceManagerDataSource {
    func requestParameters(serviceType: String) -> [String : AnyObject]? {
        print("requestParameters")
        return [String:AnyObject]()
    }
    
    func requestHeaders(serviceType: String) -> [String : String]? {
        print("requestHeaders")
        return nil
    }
    
    // MARK: ServiceKit Datasource
    func requestUrlandHttpMethodType(serviceType: String) -> (url: String?,
        methodType: SKConstant.HTTPMethod?) {
            var urlAndMethodType: (url: String?, methodType: SKConstant.HTTPMethod?)
            urlAndMethodType.url = APIConstants.ApiUrls.getSShopsUrl
            urlAndMethodType.methodType = .post
            return urlAndMethodType
    }
}

