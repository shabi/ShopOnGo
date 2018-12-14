//
//  SGOrderPlacedSummaryHeader.swift
//  ShopOnGo
//
//  Created by eCOM-shabi.naqvi on 12/11/18.
//  Copyright © 2018 pixelgeniel. All rights reserved.
//

import UIKit

class SGOrderPlacedSummaryHeader: UICollectionReusableView {
    
    @IBOutlet weak var shopName: UILabel!
    @IBOutlet weak var orderId: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureView(orderId: String, shopName: String) {
        self.shopName.text = shopName
        self.orderId.text = orderId
    }
}

