//
//  SGItemPurchasedCell.swift
//  ShopOnGo
//
//  Created by eCOM-shabi.naqvi on 12/11/18.
//  Copyright © 2018 pixelgeniel. All rights reserved.
//

import UIKit

class SGItemPurchasedCell: UICollectionViewCell {
    
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemSalePrice: UILabel!
    @IBOutlet weak var itemCount: UILabel!
    var totalItemCount = 1
    var indexPath: IndexPath?
    
    var itemDetails: SSItemList?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureItem(itemDetails: SSItemList) {
        self.itemName.text = (itemDetails.itemName ?? "")
        self.itemSalePrice.text = "$" + String(describing: itemDetails.itemPrice ?? 0)
        self.itemCount.text = String(describing: self.totalItemCount)
    }
}


