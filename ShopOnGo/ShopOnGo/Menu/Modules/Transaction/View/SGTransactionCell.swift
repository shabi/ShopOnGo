//
//  SGTransactionCell.swift
//  ShopOnGo
//
//  Created by eCOM-shabi.naqvi on 25/11/18.
//  Copyright © 2018 pixelgeniel. All rights reserved.
//

import Foundation
import UIKit

class SGTransactionCell: UICollectionViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var orderId: UILabel!
    @IBOutlet weak var transDate: UILabel!
    @IBOutlet weak var netAmount: UILabel!
    @IBOutlet weak var orderStatus: UILabel!
    //"Name": "Ram Naresh Sarvan Shriman ji",
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureItem(transaction: SGTransaction) {
        self.name.text = transaction.name
        self.orderId.text = transaction.orderId
        self.transDate.text = transaction.transDate
        self.netAmount.text = transaction.netAmount
        self.orderStatus.text = transaction.orderStatus
    }
}

