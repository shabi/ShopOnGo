//
//  SGPlaceOrderViewModel.swift
//  ShopOnGo
//
//  Created by eCOM-shabi.naqvi on 11/11/18.
//  Copyright © 2018 pixelgeniel. All rights reserved.
//

import Foundation
import SwiftyJSON


class SGPlaceOrderViewModel {
    
    var placeOrderAPI: SGPlaceOrderAPI?
    weak var viewController: ViewController?
    var placeOrder: SSPlaceOrder?
    
    init(viewController: ViewController) {
        self.viewController = viewController
    }
    
    func fetchEventInfo() {
        self.placeOrderAPI =  SGPlaceOrderAPI(serviceType: .placeOrder, type: .fetchItem, delegateViewModel: self)
        self.placeOrderAPI?.fetchData()
        SGProgressView.shared.showProgressView((self.viewController as! UIViewController).view)
    }
}

extension SGPlaceOrderViewModel: APIDelegateViewModel {
    
    func apiSuccess(serviceType: String, model: Any?) {
        if let info = model as? SSPlaceOrder {
            self.placeOrder = info
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


