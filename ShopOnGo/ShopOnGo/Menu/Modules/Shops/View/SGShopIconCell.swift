//
//  SGShopIconCell.swift
//  ShopOnGo
//
//  Created by eCOM-shabi.naqvi on 13/11/18.
//  Copyright © 2018 pixelgeniel. All rights reserved.
//

import Foundation
import UIKit

class SGShopIconCell: UICollectionViewCell {
    
    @IBOutlet weak var shopName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureItem(shop: SGShop) {
        self.shopName.text = shop.name
    }
}
