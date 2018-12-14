//
//  SGTransactionListAPI.swift
//  ShopOnGo
//
//  Created by eCOM-shabi.naqvi on 25/11/18.
//  Copyright © 2018 pixelgeniel. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class SGTransactionListAPI {
    
    weak var viewModelDelegate: APIDelegateViewModel?
    var serviceType:  APIConstants.ServiceType = .none
    enum EventType {
        case fetchTransactionDetail
    }
    
    let eventType: EventType
    
    init(serviceType: APIConstants.ServiceType, type: EventType, delegateViewModel: APIDelegateViewModel) {
        self.eventType = type
        self.viewModelDelegate = delegateViewModel
        self.serviceType = serviceType
    }
    
    
    func event() -> NSNotification.Name {
        return SGUtility.notificationName(name: APIConstants.PostNotify.transactionListEvent)
    }
    
    func errorEvent() -> NSNotification.Name {
        return SGUtility.notificationName(name: APIConstants.PostNotify.transactionListEventError)
    }
    
    func makeModel(json: JSON) -> SGModelMappable? {
        return SGTransactionList(json: json)
    }
    
    func fetchData() {
        self.fetchTransactionDetailData()
    }
    
    fileprivate func fetchTransactionDetailData() {
        SKServiceManager(dataSource: self, delegate: self, serviceType: self.serviceType.rawValue)
    }
}

extension SGTransactionListAPI: SKServiceManagerDelegate {
    
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
            let transactionInfo = SGTransactionList(object: response)
            self.viewModelDelegate?.apiSuccess(serviceType: serviceType, model: transactionInfo)
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

extension SGTransactionListAPI: SKServiceManagerDataSource {
    func requestParameters(serviceType: String) -> [String : AnyObject]? {
        print("requestParameters")
        if let userID = AppDataManager.shared.userId, let shopId = AppDataManager.shared.shopId {
            var params = [String:AnyObject]()
            params["UserId"] = "3" as AnyObject//userID as AnyObject
            params["ShopId"] = "3" as AnyObject//shopId as AnyObject
            return params
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
            urlAndMethodType.url = APIConstants.ApiUrls.getTransactionsUrl
            urlAndMethodType.methodType = .post
            return urlAndMethodType
    }
}


