//
//  SGItemViewModel.swift
//  ShopOnGo
//
//  Created by eCOM-shabi.naqvi on 07/05/18.
//  Copyright © 2018 pixelgeniel. All rights reserved.
//

import Foundation
import SwiftyJSON


class SGItemViewModel {
    
    var itemAPI: SGItemAPI?
    weak var viewController: ViewController?
    var itemDetail: SGItems?
    var itemUPCCode: String?
    var itemInfo: SSItemList?
    
    init(viewController: ViewController) {
        self.viewController = viewController
    }
    
    func fetchEventInfo() {
        self.itemAPI =  SGItemAPI(serviceType: .getSItems, type: .fetchItem, delegateViewModel: self)
        self.itemAPI?.itemId = itemUPCCode
        self.itemAPI?.fetchData()
        SGProgressView.shared.showProgressView((self.viewController as! UIViewController).view)
    }
}

extension SGItemViewModel: APIDelegateViewModel {
    
    func apiSuccess(serviceType: String, model: Any?) {
        if serviceType == APIConstants.ServiceType.getSItems.rawValue, let info = model as? SSItemList {
            self.itemInfo = info
            DispatchQueue.main.async {
                self.viewController?.updateView()
            }
        } else {
            if let info = model as? SGItems {
                self.itemDetail = info
                DispatchQueue.main.async {
                    self.viewController?.updateView()
                }
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

