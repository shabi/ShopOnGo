//
//  SGItemAPI.swift
//  ShopOnGo
//
//  Created by eCOM-shabi.naqvi on 07/05/18.
//  Copyright © 2018 pixelgenies. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class SGItemAPI {
    
    weak var viewModelDelegate: APIDelegateViewModel?
    var itemId: String?
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
        return SGUtility.notificationName(name: APIConstants.PostNotify.itemsEvent)
    }
    
    func errorEvent() -> NSNotification.Name {
        return SGUtility.notificationName(name: APIConstants.PostNotify.itemsEventError)
    }
    
    func makeModel(json: JSON) -> SGModelMappable? {
        if self.serviceType == .getSItems {
            return SSItemList(json: json)
        } else  {
            return nil
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

extension SGItemAPI: SKServiceManagerDelegate {
    
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
            if self.serviceType == .getSItems {
                let itemInfo = SSItemList(object: (response as! NSArray)[0]) // .init(json: finalResponse as! JSON)
                self.viewModelDelegate?.apiSuccess(serviceType: serviceType, model: itemInfo)
                print("finalResponse")
            } else {
                let itemInfo = SGItemDetail.init(object: response)
                self.viewModelDelegate?.apiSuccess(serviceType: serviceType, model: itemInfo.items![0])
                print("finalResponse")
            }
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

extension SGItemAPI: SKServiceManagerDataSource {
    func requestParameters(serviceType: String) -> [String : AnyObject]? {
        print("requestParameters")
        var params: [String:AnyObject]?
        
        if self.serviceType == .getSItems {
            params = ["ItemId": 1 as AnyObject]
            return params
        } else {
            return nil
        }
        return nil
    }
    
    func requestHeaders(serviceType: String) -> [String : String]? {
        print("requestHeaders")
        return nil
    }
    
    
    // MARK: ServiceKit Datasource
    func requestUrlandHttpMethodType(serviceType: String) -> (url: String?,
        methodType: SKConstant.HTTPMethod?) {
            var urlAndMethodType: (url: String?, methodType: SKConstant.HTTPMethod?)
            if self.serviceType == .getSItems {
                urlAndMethodType.url = APIConstants.ApiUrls.getSItemsUrl
                urlAndMethodType.methodType = .post
            } else {
                urlAndMethodType.url = "\(String(format: APIConstants.ApiUrls.itemUrl, itemId ?? ""))"
                urlAndMethodType.methodType = .get
            }
            return urlAndMethodType
    }
}

