//
//  APIConstants.swift
//  ShopOnGo
//
//  Created by eCOM-shabi.naqvi on 06/05/18.
//  Copyright © 2018 pixelgeniel. All rights reserved.
//

import Foundation
import UIKit

class APIConstants: NSObject {
    
    public enum ServiceType: String {
        case none
        case items
        case login
        case registration
        case getUser
        case placeOrder
        case getOrderDetail
        case getTransactions
        case getSItems
        case getSShops
    }
    
    enum Version {
        static let one = "v1"
    }
    
    enum Results {
        static let model = "model"
        static let errorModel = "errorModel"
    }
    
    enum ApiUrls {
        static let userUrlStr = "http://azapi.baselinematters.com/api/accounts/userbyemailid/taiseer.joudeh@gmail.com"
        static let itemUrl = "https://api.walmartlabs.com/v1/items?format=json&apiKey=zu9yxdzx59x32araqkhaermm&upc=%@"
        
        static let loginUrl = "http://shopongo.baselinematters.com/sogAuth"
        static let registrationUrl = "http://shopongo.baselinematters.com/api/UserApi/CustomerRegistration"
        static let getUserUrl = "http://shopongo.baselinematters.com/api/UserApi/getUsers"
        
        static let placeOrderUrl = "http://smartshopapp.baselinematters.com/api/Order/placeOrder"
        
        //"http://shopongo.baselinematters.com/api/Order/placeOrder"
        static let getOrderDetailUrl = "http://smartshopapp.baselinematters.com/api/Order/getOrderDetail"
        static let getTransactionsUrl = "http://smartshopapp.baselinematters.com/api/Order/getTransactions"
        static let getSItemsUrl = "http://smartshopapp.baselinematters.com/api/Item/getSItems"
        static let getSShopsUrl = "http://smartshopapp.baselinematters.com/api/Shop/getSShops"
    }
    
    enum ServiceHeaders {
        static let contentType = "Content-Type"
        static let Authorization = "Authorization"
        static let cartId = "cart_id"
    }
    
    enum ServiceHeaderValues {
        static let contentType = "application/json"
    }
    
    enum StatusCode {
        static let successStart = 200
        static let successEnd = 300
        static let authTokenExpired = 419
        static let contentNotModified = 304
        static let conflictError = 409
    }
    
    enum APIState: String {
        case started
        case success
        case failed
        case inqueue
    }
    
    enum FailureResponseJsonKey {
        static let statusCode = "statusCode"
        static let error = "error"
        static let message = "message"
        
    }
    
    enum PostNotify {
        static let itemsEvent = "items"
        static let itemsEventError = "itemsError"
        static let placeOrderEvent = "placeOrder"
        static let placeOrderEventError = "placeOrderError"
        static let shopListEvent = "shopList"
        static let shopListEventError = "shopListError"
        static let loginEvent = "login"
        static let loginEventError = "loginError"
        static let registrationEvent = "registration"
        static let registrationEventError = "registrationError"
        static let transactionListEvent = "transactionList"
        static let transactionListEventError = "transactionEventError"
        
    }
    
    enum Errors {
        static let orderNotReady = "order-not-ready"
        static let orderSubmissionFailed = "OrderSubmissionFailed"
        static let credentialFailed = "user name or password is incorrect."
        
    }
}




open class SGProgressView {
    
    var containerView = UIView()
    var progressView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    open class var shared: SGProgressView {
        struct Static {
            static let instance: SGProgressView = SGProgressView()
        }
        return Static.instance
    }
    
    open func showProgressView(_ view: UIView) {
        containerView.frame = view.frame
        containerView.center = view.center
        containerView.backgroundColor = UIColor(hex: 0xffffff, alpha: 0.3)
        
        progressView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        progressView.center = view.center
        progressView.backgroundColor = UIColor(hex: 0x444444, alpha: 0.7)
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        activityIndicator.center = CGPoint(x: progressView.bounds.width / 2, y: progressView.bounds.height / 2)
        
        progressView.addSubview(activityIndicator)
        containerView.addSubview(progressView)
        view.addSubview(containerView)
        
        activityIndicator.startAnimating()
    }
    
    open func hideProgressView() {
        activityIndicator.stopAnimating()
        containerView.removeFromSuperview()
    }
}

extension UIColor {
    
    convenience init(hex: UInt32, alpha: CGFloat) {
        let red = CGFloat((hex & 0xFF0000) >> 16)/256.0
        let green = CGFloat((hex & 0xFF00) >> 8)/256.0
        let blue = CGFloat(hex & 0xFF)/256.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}


