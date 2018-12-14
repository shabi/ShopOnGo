//
//  SGShopListViewModel.swift
//  ShopOnGo
//
//  Created by eCOM-shabi.naqvi on 13/11/18.
//  Copyright © 2018 pixelgeniel. All rights reserved.
//

import Foundation
import SwiftyJSON


class SGShopListViewModel {
    
    var shopListAPI: SGShopListAPI?
    weak var viewController: ViewController?
    var shopList: SGShopList?
    
    init(viewController: ViewController) {
        self.viewController = viewController
    }
    
    func fetchEventInfo() {
        self.shopListAPI =  SGShopListAPI(serviceType: .getSShops, type: .fetchItem, delegateViewModel: self)
        self.shopListAPI?.fetchData()
        SGProgressView.shared.showProgressView((self.viewController as! UIViewController).view)
    }
}

extension SGShopListViewModel: APIDelegateViewModel {
    
    func apiSuccess(serviceType: String, model: Any?) {
        if let info = model as? SGShopList {
            self.shopList = info
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



