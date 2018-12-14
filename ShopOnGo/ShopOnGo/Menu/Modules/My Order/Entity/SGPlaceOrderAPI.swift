//
//  SGPlaceOrderAPI.swift
//  ShopOnGo
//
//  Created by eCOM-shabi.naqvi on 11/11/18.
//  Copyright © 2018 pixelgeniel. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class SGPlaceOrderAPI {
    
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
        return SGUtility.notificationName(name: APIConstants.PostNotify.placeOrderEvent)
    }
    
    func errorEvent() -> NSNotification.Name {
        return SGUtility.notificationName(name: APIConstants.PostNotify.placeOrderEventError)
    }
    
    func makeModel(json: JSON) -> SGModelMappable? {
        return SSPlaceOrder(json: json)
    }
    
    func fetchData() {
        self.fetchItemData()
    }
    
    fileprivate func fetchItemData() {
        SKServiceManager(dataSource: self, delegate: self, serviceType: self.serviceType.rawValue)
    }
}

extension SGPlaceOrderAPI: SKServiceManagerDelegate {
    
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
            let itemInfo = SSPlaceOrder(object: (response as! NSArray)[0])
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

extension SGPlaceOrderAPI: SKServiceManagerDataSource {
    func requestParameters(serviceType: String) -> [String : AnyObject]? {
        print("requestParameters")
        var params: [String:AnyObject]?
        var orderCartArray: [AnyObject]?
        if let cartItems = AppDataManager.shared.cartItems {
            orderCartArray = cartItems.map {
                var param = [String:AnyObject]()
                param["ItemId"] = $0.itemId as AnyObject
                param["Quantity"] = /*$0.itemQuantity*/ 1 as AnyObject
                param["UnitAmount"] = ($0.itemPrice ?? 0) * /*($0.itemQuantity ?? 0)*/ 1 as AnyObject
                return param as AnyObject
            }
        }
        params = ["UserId": /*AppDataManager.shared.userId*/ 14 as AnyObject, "ShopId": AppDataManager.shared.cartItems?.first?.shopId as AnyObject, "CreatedBy": "IOS" as AnyObject, "OrderCart": orderCartArray as AnyObject]
        return params
    }
    
    func requestHeaders(serviceType: String) -> [String : String]? {
        print("requestHeaders")
        return nil
    }
    
    
    // MARK: ServiceKit Datasource
    func requestUrlandHttpMethodType(serviceType: String) -> (url: String?,
        methodType: SKConstant.HTTPMethod?) {
            var urlAndMethodType: (url: String?, methodType: SKConstant.HTTPMethod?)
            urlAndMethodType.url = APIConstants.ApiUrls.placeOrderUrl
            urlAndMethodType.methodType = .post
            return urlAndMethodType
    }
}
