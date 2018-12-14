//
//  SKServiceManagerProtocol.swift
//  ShopOnGo
//
//  Created by Shabi Naqvi on 07/05/18
//  Copyright (c) pixelgeniel. All rights reserved.
//

import Foundation
import Alamofire



//MARK:-

public protocol SKServiceManagerDataSource {
    
    func requestUrlandHttpMethodType(serviceType: String) -> (url: String?, methodType: SKConstant.HTTPMethod?)
    func requestHeaders(serviceType: String) -> [String: String]?
    func requestParameters(serviceType: String) -> [String: AnyObject]?
}

public protocol SKServiceManagerDelegate {
    
    func didReceiveResponse(serviceType: String, headerResponse: HTTPURLResponse?, finalResponse: Any?)
    func didReceiveError(serviceType: String, theError: Error?, failureResponse: Any?) -> [String: String]?
}

public protocol SKServiceManagerImageDownloadDelegate {
    
    func didReceiveImage(serviceType: String, finalResponse: Any?)
}

protocol APIDelegateViewModel: class {
    
    func apiSuccess(serviceType: String, model: Any?)
    func apiFailure(serviceType: String, error: Error)
}
