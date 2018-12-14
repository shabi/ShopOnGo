//
//  SGTransactionListViewModel.swift
//  ShopOnGo
//
//  Created by eCOM-shabi.naqvi on 25/11/18.
//  Copyright © 2018 pixelgeniel. All rights reserved.
//

import Foundation
import SwiftyJSON


class SGTransactionListViewModel {
    
    var transactionListAPI: SGTransactionListAPI?
    weak var viewController: ViewController?
    var transactionList: SGTransactionList?
    
    init(viewController: ViewController) {
        self.viewController = viewController
    }
    
    func fetchEventInfo() {
        self.transactionListAPI =  SGTransactionListAPI(serviceType: .getTransactions, type: .fetchTransactionDetail, delegateViewModel: self)
        self.transactionListAPI?.fetchData()
        SGProgressView.shared.showProgressView((self.viewController as! UIViewController).view)
    }
}

extension SGTransactionListViewModel: APIDelegateViewModel {
    
    func apiSuccess(serviceType: String, model: Any?) {
        if let info = model as? SGTransactionList {
            self.transactionList = info
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




